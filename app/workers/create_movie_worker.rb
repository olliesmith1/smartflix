# frozen_string_literal: true

require 'net/http'
require 'json'

class CreateMovieWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform(title)
    Movies::Create.new(title).call
  end
end
