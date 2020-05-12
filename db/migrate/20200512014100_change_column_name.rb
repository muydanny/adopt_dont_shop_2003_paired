class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :favorites, :pet_name, :name
  end
end
