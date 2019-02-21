class CreateHearts < ActiveRecord::Migration[5.2]
  def change
    create_table :hearts do |t|
      t.references :user, foreign_key: true, null: false
      t.references :prot, foreign_key: true, null: false

      t.timestamps
    end
  end
end
