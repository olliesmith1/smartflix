# frozen_string_literal: true

module Movies
  class Create
    def initialize(title)
      @title = title
    end

    def call
      movie = Movie.new(movie_attributes)
      movie.save! if movie.title
      external_rating = ExternalRating.new(movie_id: movie.id,
                                           imdb_rating: movie_attributes[:ratings][0]['Value'],
                                           rotten_tomatoes_rating: movie_attributes[:ratings][1]['Value'],
                                           metacritic_rating: movie_attributes[:ratings][2]['Value'])
      external_rating.save! if movie.title
    end

    private

    attr_reader :title

    def movie_attributes
      if movie_data['Response'] == 'False'
        print_error(movie_data)
        return
      end
      movie_attributes = {}
      movie_data.each do |key, value|
        next if key == 'Type'
        movie_attributes[key.underscore.to_sym] = value
      end
      movie_attributes
    end

    def movie_data
      @movie_data ||= Apis::Omdb.new(title).call
    end

    def print_error(movie_data)
      time = Time.now
      timestamp = "#{time.strftime("%k:%M")} on #{time.strftime("%d/%m/%Y")}"
      Rails.logger.error "#{movie_data['Error']} for title #{title} at #{timestamp}"
    end
  end
end
