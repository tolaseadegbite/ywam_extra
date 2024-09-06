class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :account, null: false, foreign_key: true
      t.references :followable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :follows, [:account_id, :followable_id], unique: true
    add_index :follows, [:account_id, :followable_id, :followable_type], unique: true
  end
end
