class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :title, null: false
      t.string :artist_name, null: false
      t.integer :genre, null: false
      t.text :introduction, null: false
      t.date :release_date, null: false
      t.integer :end_user_id, null: false
      t.string :image_id
      t.timestamps
    end
  end
end
