# frozen_string_literal: true

require 'sidekiq-scheduler'

class UpdateMoviesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    Movie.all.each do |movie|
      if movie.updated_at < 2.days.ago
        movie.destroy
      else
        puts "*********"
        Movies::Update.new(movie).call
      end
    end
  end
end

