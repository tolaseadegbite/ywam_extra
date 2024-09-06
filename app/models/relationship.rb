# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer
#  follower_id :integer
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
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
