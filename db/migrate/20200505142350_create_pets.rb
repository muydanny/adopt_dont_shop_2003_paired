class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :image
      t.text :description
      t.boolean :adoptable
      t.string :name
      t.string :age
      t.string :sex
      t.string :shelter
    end
  end
end
