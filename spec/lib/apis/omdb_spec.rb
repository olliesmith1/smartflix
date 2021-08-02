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

  it 'should return a movie when provided with a title', aggregate_failures: true do
    VCR.use_cassette 'get_movie' do
      movie = Apis::Omdb.new('Cars').call
      expect(movie['Title']).to eq('Cars')
      expect(movie['Year']).to eq('2006')
      expect(movie['imdbRating']).to eq('7.1')
      expect(movie['BoxOffice']).to eq('$244,082,982')
    end
  end

  it 'should return an error when provided with a false title', aggregate_failures: true do
    VCR.use_cassette 'get_not_movie' do
      data = Apis::Omdb.new('notmovie').call
      expect(data['Response']).to eq('False')
      expect(data['Error']).to eq('Movie not found!')
      expect(data['Timestamp']).to eq('2008-01-01 00:00:00.000000000 +0000')
    end
  end
end
