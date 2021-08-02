# frozen_string_literal: true

module Movies
  class Update
    def initialize(movie)
      @movie = movie
    end

    def call
      up_to_date_movie = Movie.new(movie_attributes)
      if up_to_date_movie == @movie
        @movie.touch
      else
        @movie.update(up_to_date_movie.attributes)
      end
    end

    private

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
