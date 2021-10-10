class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.text :message
      t.integer :end_user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
