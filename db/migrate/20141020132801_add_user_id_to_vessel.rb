class AddUserIdToVessel < ActiveRecord::Migration
  def change
    add_column :vessels, :user_id, :integer, null: false
  end
end
