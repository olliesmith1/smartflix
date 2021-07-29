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
      all_data = fetch_data
      print_error_to_logs(all_data)
      { title: all_data['Title'],
        year: all_data['Year'],
        rated: all_data['Rated'],
        released: all_data['Released'],
        runtime: all_data['Runtime'],
        genre: all_data['Genre'],
        director: all_data['Director'],
        writer: all_data['Writer'],
        plot: all_data['Plot'],
        country: all_data['Country'],
        awards: all_data['Awards'],
        poster: all_data['Poster'],
        ratings: all_data['Ratings'],
        metascore: all_data['Metascore'],
        imdb_rating: all_data['imdbRating'],
        imdb_votes: all_data['imdbVotes'],
        imdb_id: all_data['imdbID'],
        dvd: all_data['DVD'],
        box_office: all_data['BoxOffice'],
        production: all_data['Production'] }
    end

    def fetch_data
      Apis::Omdb.new(title).call
    end

    def print_error_to_logs(all_data)
      if all_data['Response'] == 'False'
        puts "#{all_data['Error']} for title #{title} at #{all_data[:timestamp].strftime("%k:%M")} on #{all_data[:timestamp].strftime("%d/%m/%Y")}"
      end
    end
  end
end
