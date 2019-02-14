class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :title, default: "new node", null: false
      t.text :body, default: "", null: false
      t.integer :position, null: false
      t.integer :parent_id
      t.references :prot, add_foreign_key: true, null: false
      t.timestamps
    end
  end
end
