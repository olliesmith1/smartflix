class AddResponseToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :response, :string
  end
end
