class CreatePlaylists < ActiveRecord::Migration[7.1]
  def change
    create_table :playlists do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.integer :visibility, null: false

      t.timestamps
    end
  end
end
