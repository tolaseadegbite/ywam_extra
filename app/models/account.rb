# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  bio                    :string
#  dob                    :date             not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  followers_count        :integer          default(0), not null
#  following_count        :integer          default(0), not null
#  last_name              :string           not null
#  mod                    :boolean          default(FALSE)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#  index_accounts_on_username              (username) UNIQUE
#
class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  validates :first_name, :last_name, :dob, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false, message: "Username must be unique" }

  def name
    first_name + " " + last_name
  end

  has_many :podcasts

  # Account can follow other accounts
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Account can follow many podcasts and episodes
  has_many :follows
  has_many :followed_podcasts, through: :follows, source: :followable, source_type: 'Podcast'
  has_many :followed_episodes, through: :follows, source: :followable, source_type: 'Episode'
  has_many :reviews, dependent: :destroy
  has_many :plays, dependent: :destroy
  has_many :played_episodes, through: :plays, source: :episode
  has_many :playlists, dependent: :destroy
  has_many :episode_progresses, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :rsvps, dependent: :destroy
  has_many :rsvp_events, through: :rsvps, source: :event

  has_many :event_co_hosts, dependent: :destroy
  has_many :co_hosted_events, through: :event_co_hosts, source: :event

  # Follows a account.
  def follow(other_account)
    following << other_account unless self == other_account
  end

  # Unfollows a account.
  def unfollow(other_account)
    following.delete(other_account)
  end

  # Returns true if the current account is following the other account.
  def following?(other_account)
    following.include?(other_account)
  end

  # active storage image and validations
  # avatar
  has_one_attached :avatar do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end

  validates :avatar, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }
  # cover image
  has_one_attached :cover_image do |attachable|
    attachable.variant :display, resize_to_limit: [1225, 388]
  end

  validates :cover_image, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }
end
