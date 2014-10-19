class CreateVessels < ActiveRecord::Migration
  def change
    create_table :vessels do |t|
      t.string :name_ja, null: false
      t.string :name_en, null: false
      t.string :type_name
      t.datetime :sunk_at, null: false
      t.string :place_name
      t.decimal :latitude, precision: 11, scale: 8, null: false
      t.decimal :longitude, precision: 11, scale: 8, null: false
      t.integer :classification_id, null: false
      t.integer :cause_id, null: true

      t.timestamps
    end
  end
end
