class AddBayesianToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :bayesian, :float
    add_index :posts, :bayesian
  end
end
