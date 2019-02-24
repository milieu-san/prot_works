class CreateProtMediaTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :prot_media_types do |t|
      t.references :prot, foreign_key: true, null: false
      t.references :media_type, foreign_key: true, null: false

      t.timestamps
    end
  end
end
