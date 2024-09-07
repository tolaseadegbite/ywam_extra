class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :episodes do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :podcast, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :likes_count, default: 0
      t.integer :saves_count, default: 0

      t.timestamps
    end
  end
end
