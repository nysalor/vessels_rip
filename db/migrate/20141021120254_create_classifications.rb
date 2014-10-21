class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :name_ja, null: false
      t.string :name_en, null: false

      t.timestamps
    end
  end
end
