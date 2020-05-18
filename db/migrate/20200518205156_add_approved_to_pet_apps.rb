class AddApprovedToPetApps < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_apps, :approved, :boolean
  end
end
