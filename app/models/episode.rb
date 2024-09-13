# == Schema Information
#
# Table name: episodes
#
#  id            :bigint           not null, primary key
#  description   :text             not null
#  episode_type  :integer          default("standard"), not null
#  follows_count :integer          default(0), not null
#  saves_count   :integer          default(0), not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :bigint           not null
#  podcast_id    :bigint           not null
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
  validates :title, :description, :episode_type, presence: true

  belongs_to :podcast
  belongs_to :category

  has_many :episode_tags, dependent: :destroy
  has_many :tags, through: :episode_tags

  # An episode can have many followers
  has_many :follows, as: :followable
  has_many :followers, through: :follows, source: :account

  # cover art
  has_one_attached :cover_art do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  validates :cover_art, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }

  # Episode types
  enum episode_type: {
    standard: 0,
    trailer: 1,
    interview: 2,
    solo: 3,
    panel_discussion: 4,
    storytelling: 5,
    educational: 6,
    question_and_answer: 7,
    review: 8,
    news: 9,
    debate: 10,
    special: 11,
    bonus: 12
  }

  scope :ordered, -> { order(id: :desc) }
end
