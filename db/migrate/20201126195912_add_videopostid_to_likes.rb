class AddVideopostidToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :video_post_id, :integer
  end
end
