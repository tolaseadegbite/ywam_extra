# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :podcast_tags
  has_many :podcasts, through: :podcast_tags
  has_many :episode_tags
  has_many :episodes, through: :episode_tags
end
