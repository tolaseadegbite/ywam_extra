class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.text :details, null: false
      t.string :street_address
      t.string :streaming_link
      t.references :account, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :event_type, null: false
      t.integer :cost_type, null: false
      t.string :country
      t.string :state
      t.string :city
      t.string :time_zone
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
