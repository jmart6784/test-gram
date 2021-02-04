class AddVideoPostIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :video_post_id, :integer
  end
end
