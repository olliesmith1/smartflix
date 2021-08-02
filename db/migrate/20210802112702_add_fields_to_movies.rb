class AddFieldsToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :website, :string
  end
end
