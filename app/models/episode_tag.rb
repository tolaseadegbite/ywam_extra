# == Schema Information
#
# Table name: episode_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  episode_id :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_episode_tags_on_episode_id  (episode_id)
#  index_episode_tags_on_tag_id      (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (episode_id => episodes.id)
#  fk_rails_...  (tag_id => tags.id)
#
class EpisodeTag < ApplicationRecord
  belongs_to :episode
  belongs_to :tag
end
