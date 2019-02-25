# frozen_string_literal: true

class AddUniqueToHeart < ActiveRecord::Migration[5.2]
  def change
    add_index :hearts, %i[user_id prot_id], unique: true
  end
end
