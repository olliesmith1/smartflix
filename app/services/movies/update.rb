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
      all_data = fetch_data
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
      Apis::Omdb.new(@movie.title).call
    end
  end
end
