# frozen_string_literal: true

module Movies
  class Create
    def initialize(title)
      @title = title
    end

    def call
      movie = Movie.new(movie_attributes)
      movie.save! if movie.title
    end

    private

    attr_reader :title

    def movie_attributes
      print_error(movie_data)
      movie_attributes = {}
      movie_data.each do |key, value|
        next if key == 'Type'
        movie_attributes[key.underscore.to_sym] = value
      end
      movie_attributes
    end

    def fetch_data
      @movie_data ||= Apis::Omdb.new(title).call
    end

    def print_error(all_data)
      if all_data['Response'] == 'False'
        puts "#{all_data['Error']} for title #{title} at #{all_data[:timestamp].strftime("%k:%M")} on #{all_data[:timestamp].strftime("%d/%m/%Y")}"
      end
    end
  end
end
