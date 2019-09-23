class RemoveNotNullFromUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :icon, :text, null: true
  end

  def down
    change_column :users, :icon, :text, null: false
  end
end
