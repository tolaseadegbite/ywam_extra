# == Schema Information
#
# Table name: playlist_episodes
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  episode_id  :bigint           not null
#  playlist_id :bigint           not null
#
# Indexes
#
#  index_playlist_episodes_on_episode_id   (episode_id)
#  index_playlist_episodes_on_playlist_id  (playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (episode_id => episodes.id)
#  fk_rails_...  (playlist_id => playlists.id)
#
class PlaylistEpisode < ApplicationRecord
  belongs_to :playlist
  belongs_to :episode
end
