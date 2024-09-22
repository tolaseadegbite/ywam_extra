# == Schema Information
#
# Table name: playlists
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  visibility  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#
# Indexes
#
#  index_playlists_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Playlist < ApplicationRecord
  validates :name, presence: true

  belongs_to :account

  has_many :playlist_episodes, dependent: :destroy
  has_many :episodes, through: :playlist_episodes

  scope :ordered, -> { order(id: :asc) }

  # Visibility
  enum visibility: {
    open: 0,
    restricted: 1
  }

  # photo
  has_one_attached :photo do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  validates :photo, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }
end
