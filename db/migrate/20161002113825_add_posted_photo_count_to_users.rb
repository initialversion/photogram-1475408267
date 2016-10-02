class AddPostedPhotoCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :posted_photos_count, :integer
  end
end
