class AddBookingUrlToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :booking_url, :string
  end
end
