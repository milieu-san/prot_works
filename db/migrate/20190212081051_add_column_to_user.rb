# frozen_string_literal: true

class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :nick_name, :string, null: false
    add_column :users, :profile, :text, null: false, default: ''
  end
end
