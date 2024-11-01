# == Schema Information
#
# Table name: podcasts
#
#  id             :bigint           not null, primary key
#  about          :text             not null
#  average_rating :decimal(, )      default(0.0)
#  episodes_count :integer          default(0), not null
#  follows_count  :integer          default(0), not null
#  name           :string           not null
#  reviews_count  :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :bigint           not null
#  category_id    :bigint           not null
#
# Indexes
#
#  index_podcasts_on_account_id   (account_id)
#  index_podcasts_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (category_id => categories.id)
#
class Podcast < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5 }

  def display_name
    name
  end

  belongs_to :account
  belongs_to :category
  
  has_many :episodes, dependent: :destroy
  has_many :podcast_tags, dependent: :destroy
  has_many :tags, through: :podcast_tags, dependent: :destroy

  # A podcast can have many followers
  has_many :follows, as: :followable
  has_many :followers, through: :follows, source: :account

  has_many :reviews, as: :reviewable, dependent: :destroy
  # has_many :comments, -> { order(created_at: :desc) }, as: :commentable, dependent: :destroy

  # cover art
  has_one_attached :cover_art do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  validates :cover_art, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }
  
  scope :ordered, -> { order(id: :desc) }
end
