# frozen_string_literal: true

module Movies
  class Update
    def initialize(movie)
      @movie = movie
    end

    def call
      p "*********"
      # movie = Movie.new(movie_attributes)
      # movie.save! if movie.title
    end

  end
end
