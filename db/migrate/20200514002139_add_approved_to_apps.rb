class AddApprovedToApps < ActiveRecord::Migration[5.1]
  def change
    add_column :apps, :approved, :string
  end
end
