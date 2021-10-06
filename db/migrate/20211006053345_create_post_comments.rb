class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.text :comment, null: false
      t.integer :end_user_id, null: false
      t.integer :record_id, null: false

      t.timestamps
    end
  end
end
