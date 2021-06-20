class AddSettingsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :settings, :string
  end
end
