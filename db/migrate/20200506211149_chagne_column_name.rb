class ChagneColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :pets, :shelter, :shelter_name
  end
end
