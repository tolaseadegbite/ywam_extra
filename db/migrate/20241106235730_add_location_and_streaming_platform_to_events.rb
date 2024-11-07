class AddLocationAndStreamingPlatformToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :location, :string
    add_column :events, :streaming_platform, :string
  end
end
