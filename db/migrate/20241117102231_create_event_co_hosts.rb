class CreateEventCoHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :event_co_hosts do |t|
      t.references :event, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.integer :role, default: 1
      t.integer :status, default: 0
      t.integer :decline_count, default: 0

      t.timestamps
    end

    add_index :event_co_hosts, [:event_id, :account_id], unique: true
  end
end
