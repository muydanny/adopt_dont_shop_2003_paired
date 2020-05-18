class RemoveApproved2FromApps < ActiveRecord::Migration[5.1]
  def change
    remove_column :apps, :approved, :string
  end
end
