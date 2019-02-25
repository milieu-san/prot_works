# frozen_string_literal: true

class AddUniqueToGood < ActiveRecord::Migration[5.2]
  def change
    add_index :goods, %i[user_id review_id], unique: true
  end
end
