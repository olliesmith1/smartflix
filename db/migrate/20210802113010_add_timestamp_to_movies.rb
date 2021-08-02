class AddTimestampToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :timestamp, :timestamp
  end
end
