class AddColumnsToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :year, :string
    add_column :movies, :rated, :string
    add_column :movies, :released, :string
    add_column :movies, :runtime, :string
    add_column :movies, :genre, :string
    add_column :movies, :director, :string
    add_column :movies, :writer, :string
    add_column :movies, :actors, :string
    add_column :movies, :plot, :string
    add_column :movies, :language, :string
    add_column :movies, :country, :string
    add_column :movies, :awards, :string
    add_column :movies, :poster, :string
    add_column :movies, :ratings, :string
    add_column :movies, :metascore, :string
    add_column :movies, :imdb_rating, :string
    add_column :movies, :imdb_votes, :string
    add_column :movies, :imdb_id, :string
    add_column :movies, :type, :string
    add_column :movies, :dvd, :string
    add_column :movies, :box_office, :string
    add_column :movies, :production, :string
  end
end
