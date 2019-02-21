class AddUniqueToGood < ActiveRecord::Migration[5.2]
  def change
    add_index :goods, [:user_id, :review_id], unique: true
  end
end
