# frozen_string_literal: true

class AddNotNullTostars < ActiveRecord::Migration[5.2]
  def change
    change_column :stars, :give_user_id, :integer, null: false
    change_column :stars, :take_user_id, :integer, null: false
  end
end
