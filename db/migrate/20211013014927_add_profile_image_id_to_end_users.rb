class AddProfileImageIdToEndUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :end_users, :profile_image_id, :string
  end
end
