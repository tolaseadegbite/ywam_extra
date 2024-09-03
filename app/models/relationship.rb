class Relationship < ApplicationRecord

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  belongs_to :follower, class_name: "Account", counter_cache: :following_count
  belongs_to :followed, class_name: "Account", counter_cache: :followers_count

  after_commit :update_follower_count, on: :destroy

  private

  def update_follower_count
    follower.update(following_count: follower.following_count - 1)
    followed.update(followers_count: followed.followers_count - 1)
  end
end
