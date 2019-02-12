class CreateProts < ActiveRecord::Migration[5.2]
  def change
    create_table :prots do |t|
      t.string :title, null: false
      t.text :content, default: "", null: false
      t.boolean :private, default: true, null: false
      t.boolean :accepts_review, default: true, null: false

      t.timestamps
    end
  end
end
