class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :likeable_id
      t.string :likeable_type
      t.integer :user_id
      t.integer :post_id
      t.integer :comment_id

      t.timestamps
    end
    add_index :likes, [:likeable_id, :likeable_type]
  end
end
