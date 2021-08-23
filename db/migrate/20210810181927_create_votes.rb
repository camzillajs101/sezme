class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :value, default: 0
      t.references :voteable, polymorphic: true
      t.belongs_to :user

      t.timestamps
    end
  end
end
