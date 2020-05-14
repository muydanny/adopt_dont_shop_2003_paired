class ChangeApprovedToString < ActiveRecord::Migration[5.1]
  def change
    change_column :apps, :approved, :string
  end
end
