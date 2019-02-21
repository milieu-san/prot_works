class AddUniqueToHeart < ActiveRecord::Migration[5.2]
  def change
    add_index :hearts, [:user_id, :prot_id], unique: true
  end
end
