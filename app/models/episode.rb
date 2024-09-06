# == Schema Information
#
# Table name: episodes
#
#  id          :bigint           not null, primary key
#  likes_count :integer          default(0), not null
#  saves_count :integer          default(0), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  podcast_id  :bigint           not null
#
# Indexes
#
#  index_episodes_on_category_id  (category_id)
#  index_episodes_on_podcast_id   (podcast_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (podcast_id => podcasts.id)
#
class Episode < ApplicationRecord
  validates :title, :description, presence: true

  has_rich_text :description

  belongs_to :podcast
  belongs_to :category

  has_many :episode_tags
  has_many :tags, through: :episode_tags

  # An episode can have many followers
  has_many :follows, as: :followable
  has_many :followers, through: :follows, source: :account
end
