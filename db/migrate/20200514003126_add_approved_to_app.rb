class AddApprovedToApp < ActiveRecord::Migration[5.1]
  def change
    add_column :apps, :approved, :boolean
  end
end
