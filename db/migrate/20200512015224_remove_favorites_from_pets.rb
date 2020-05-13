class RemoveFavoritesFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_reference :pets, :favorite, index:true, foreign_key: true
  end
end
