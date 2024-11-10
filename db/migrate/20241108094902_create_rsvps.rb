class CreateRsvps < ActiveRecord::Migration[7.1]
  def change
    create_table :rsvps do |t|
      t.references :account, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
