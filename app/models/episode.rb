# == Schema Information
#
# Table name: episodes
#
#  id            :bigint           not null, primary key
#  description   :text             not null
#  episode_type  :integer          default("standard"), not null
#  follows_count :integer          default(0), not null
#  saves_count   :integer          default(0), not null
#  status        :integer          default("draft")
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
  validates :title, presence: true, length: { minimum: 10 }

  def display_name
    title
  end

  belongs_to :podcast
  belongs_to :category

  has_many :episode_tags, dependent: :destroy
  has_many :tags, through: :episode_tags

  has_many :episode_progresses, dependent: :destroy

  # An episode can have many followers
  has_many :follows, as: :followable
  has_many :followers, through: :follows, source: :account

  has_many :plays, dependent: :destroy
  has_many :play_accounts, through: :plays, source: :account

  has_many :comments, -> { order(created_at: :desc) }, as: :commentable, dependent: :destroy

  # cover art
  has_one_attached :cover_art do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  validates :cover_art, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }

  has_one_attached :audio

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

  # Episode statuses
  enum status: {
    draft: 0,
    published: 1,
    archived: 2
  }

  scope :desc, -> { order(id: :desc) }
  scope :asc, -> { order(id: :asc) }
  scope :published, -> { where(status: :published) }
  scope :recent, -> (n) { order(id: :desc).limit(n) }
end
