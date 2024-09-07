class AddEpisodeTypeToEpisodes < ActiveRecord::Migration[7.1]
  def change
    add_column :episodes, :episode_type, :integer, default: 0, null: false
  end
end
