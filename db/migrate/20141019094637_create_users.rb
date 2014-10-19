class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :screen_name, null: true

      t.timestamps
    end
  end
end
