# frozen_string_literal: true

class CreateStars < ActiveRecord::Migration[5.2]
  def change
    create_table :stars do |t|
      t.integer :give_user_id
      t.integer :take_user_id

      t.timestamps
    end

    add_index :stars, :give_user_id
    add_index :stars, :take_user_id
    add_index :stars, %i[give_user_id take_user_id], unique: true
  end
end
