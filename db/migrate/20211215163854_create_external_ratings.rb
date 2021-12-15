class CreateExternalRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :external_ratings do |t|
      t.integer :movie_id
      t.float :imdb_rating
      t.float :rotten_tomatoes_rating
      t.float :metacritic_rating
      t.timestamps
      t.index [:movie_id], name: "index_movies_on_movie_id"
    end
  end
end
