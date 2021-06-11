require 'net/http'
require 'json'

class CreateMovieWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform(*args)
    movie_title = make_api_call
    Movie.create!(title: movie_title)
  end

  private

  def make_api_call
    uri = URI('http://www.omdbapi.com/')
    params = { t: Faker::Movie.title, apikey: OMDB_API_KEY }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    json_res = JSON.parse(res.body)
    json_res['Title']
  end
end
