class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :title

      t.timestamps
    end

    create_table :groups_users, id: false do |t|
      t.belongs_to :group
      t.belongs_to :user
    end
  end
end
