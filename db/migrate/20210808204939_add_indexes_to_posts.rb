class AddIndexesToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :rating, :integer
    add_column :posts, :review_average, :float
    add_index :posts, :review_average
    add_column :posts, :review_count, :bigint
    add_index :posts, :review_count
    add_index :users, :username, unique: true
  end
end
