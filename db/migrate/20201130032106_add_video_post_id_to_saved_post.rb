class AddVideoPostIdToSavedPost < ActiveRecord::Migration[6.0]
  def change
    add_column :saved_posts, :video_post_id, :integer
  end
end
