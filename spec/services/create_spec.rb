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

RSpec.describe Apis::Omdb::Movie do
  it 'should return a movie when provided with a title' do
    VCR.use_cassette 'get_movie' do
      movie = Apis::Omdb::Movie.new('Cars').call
      expect(movie['Title']).to eq('Cars')
      expect(movie['Year']).to eq('2006')
      expect(movie['imdbRating']).to eq('7.1')
      expect(movie['BoxOffice']).to eq('$244,082,982')
    end
  end
end
