class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, presence: true
      t.string :url
      t.text :content
      t.integer :sub_id, presence: true
      t.integer :author_id, presence: true
      t.timestamps null: false
    end
    add_index :posts, :title
    add_index :posts, :sub_id
    add_index :posts, :author_id
  end
end
