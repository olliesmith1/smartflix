# frozen_string_literal: true

class UpdateMoviesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    Movies.all.each do |movie|
      if movie.updated_at > 2.days.ago
        movie.destroy
      else
        Movies::Update.new(movie).call
      end
    end
  end
end

Sidekiq::Cron::Job.create(name: 'UpdateMoviesWorker - every day at 7am', cron: '0 7 * * *', class: 'UpdateMoviesWorker')
