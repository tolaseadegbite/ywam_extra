class AddStatusToEpisodes < ActiveRecord::Migration[7.1]
  def change
    add_column :episodes, :status, :integer, default: 0
  end
end
