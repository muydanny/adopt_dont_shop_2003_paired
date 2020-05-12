class AddFavoritesToPets < ActiveRecord::Migration[5.1]
  def change
    add_reference :pets, :favorite, foreign_key: true
  end
end
