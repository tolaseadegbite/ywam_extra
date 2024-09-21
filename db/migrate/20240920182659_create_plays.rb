class CreatePlays < ActiveRecord::Migration[7.1]
  def change
    create_table :plays do |t|
      t.references :account, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true

      t.timestamps
    end

    add_index :plays, [:account_id, :episode_id], unique: true
  end
end
