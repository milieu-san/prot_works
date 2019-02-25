# frozen_string_literal: true

class AddUserRefToProts < ActiveRecord::Migration[5.2]
  def change
    add_reference :prots, :user, foreign_key: true, null: false
  end
end
