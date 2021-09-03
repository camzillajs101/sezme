class AddCiLowerBoundToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :ci_lower_bound, :float
    add_index :reviews, :ci_lower_bound
  end
end
