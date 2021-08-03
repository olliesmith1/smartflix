# frozen_string_literal: true

require 'rails_helper'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.default_cassette_options = { record: :once,
                                      match_requests_on: %i[body method] }
  config.ignore_hosts 'chromedriver.storage.googleapis.com'
  config.filter_sensitive_data('apikey') { OMDB_API_KEY }
end

RSpec.describe Apis::Omdb do
  before do
    Timecop.freeze(Time.local(2008))
  end

  after do
    Timecop.return
  end

  it 'should return movie data when provided with a title', aggregate_failures: true do
    VCR.use_cassette 'get_movie' do
      movie = Apis::Omdb.new('Cars').call
      expect(movie['Title']).to eq('Cars')
      expect(movie['Year']).to eq('2006')
      expect(movie['imdbRating']).to eq('7.1')
      expect(movie['BoxOffice']).to eq('$244,082,982')
    end
  end

  it 'should return error data when provided with a false title', aggregate_failures: true do
    VCR.use_cassette 'get_not_movie' do
      data = Apis::Omdb.new('notmovie').call
      expect(data['Response']).to eq('False')
      expect(data['Error']).to eq('Movie not found!')
    end
  end
  #
  # it 'should log an error when provided with a false title' do
  #   VCR.use_cassette 'get_not_movie' do
  #     # Apis::Omdb.new('notmovie').call
  #     expect(Rails.logger).to receive(:error)
  #   end
  # end

end
