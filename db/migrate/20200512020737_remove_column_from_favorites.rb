class RemoveColumnFromFavorites < ActiveRecord::Migration[5.1]
  def change
    remove_column :favorites, :name, :string
  end
end
