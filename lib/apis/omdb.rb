require 'net/http'
require 'json'

module Apis
  class Omdb
    def initialize(title)
      @title = title
    end

    def call
      make_api_call
    end

    private

    attr_reader :title

    def make_api_call
      uri = URI('http://www.omdbapi.com/')
      params = { t: title, apikey: OMDB_API_KEY }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body)
    end
  end
end
