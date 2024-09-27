# == Schema Information
#
# Table name: episode_progresses
#
#  id         :bigint           not null, primary key
#  progress   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  episode_id :bigint           not null
#
# Indexes
#
#  index_episode_progresses_on_account_id  (account_id)
#  index_episode_progresses_on_episode_id  (episode_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (episode_id => episodes.id)
#
class EpisodeProgress < ApplicationRecord
  belongs_to :account
  belongs_to :episode
end
