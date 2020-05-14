class RemoveApprovedFromApps < ActiveRecord::Migration[5.1]
  def change
    remove_column :apps, :approved, :boolean
  end
end
