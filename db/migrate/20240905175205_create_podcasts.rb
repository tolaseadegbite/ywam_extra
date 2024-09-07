class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.string :name, null: false
      t.text :about, null: false
      t.integer :episodes_count, default: 0
      t.integer :followers_count, default: 0
      t.references :account, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
