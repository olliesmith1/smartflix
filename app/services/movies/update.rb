# frozen_string_literal: true

module Movies
  class Update
    def initialize(movie)
      @movie = movie
    end

    def call
      if refreshed_movie == @movie
        @movie.touch
      else
        @movie.update(refreshed_movie.attributes)
      end
    end

    private

    def refreshed_movie
      @refreshed_movie ||= Movie.new(movie_attributes)
    end

    def movie_attributes
      movie_attributes = {}
      movie_data.each do |key, value|
        next if key == 'Type'
        movie_attributes[key.underscore.to_sym] = value
      end
      movie_attributes
    end

    def movie_data
      @movie_data ||= Apis::Omdb.new(@movie.title).call
    end
  end
end
