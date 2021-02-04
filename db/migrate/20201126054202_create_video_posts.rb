class CreateVideoPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :video_posts do |t|
      t.text :caption
      t.integer :user_id
      t.integer :comment_id
      t.integer :like_id

      t.timestamps
    end
  end
end
