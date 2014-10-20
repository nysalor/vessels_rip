class AddUserIdToVesselRevision < ActiveRecord::Migration
  def change
    add_column :vessel_revisions, :user_id, :integer, null: false
  end
end
