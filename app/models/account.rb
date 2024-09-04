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

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

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
