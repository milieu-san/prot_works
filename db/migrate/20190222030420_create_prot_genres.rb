class CreateProtGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :prot_genres do |t|
      t.references :prot, foreign_key: true, null: false
      t.references :genre, foreign_key: true, null: false

      t.timestamps
    end
  end
end
