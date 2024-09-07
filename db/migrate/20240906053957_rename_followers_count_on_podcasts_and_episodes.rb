class RenameFollowersCountOnPodcastsAndEpisodes < ActiveRecord::Migration[7.1]
  def change
    rename_column :podcasts, :followers_count, :follows_count
    rename_column :episodes, :likes_count, :follows_count
  end
end
