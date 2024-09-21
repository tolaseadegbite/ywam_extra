# == Schema Information
#
# Table name: plays
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  episode_id :bigint           not null
#
# Indexes
#
#  index_plays_on_account_id                 (account_id)
#  index_plays_on_account_id_and_episode_id  (account_id,episode_id) UNIQUE
#  index_plays_on_episode_id                 (episode_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (episode_id => episodes.id)
#
class Play < ApplicationRecord
  validates :account_id, uniqueness: {scope: :episode_id, message: "has already marked this episode as played"}
  
  belongs_to :account
  belongs_to :episode
end
