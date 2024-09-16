# == Schema Information
#
# Table name: reviews
#
#  id              :bigint           not null, primary key
#  comment         :text
#  rating          :integer          not null
#  reviewable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  reviewable_id   :bigint           not null
#
# Indexes
#
#  index_reviews_on_account_id  (account_id)
#  index_reviews_on_reviewable  (reviewable_type,reviewable_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Review < ApplicationRecord
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { minimum: 10 }
  validates :account_id, uniqueness: { scope: [:reviewable_type, :reviewable_id], message: 'has already reviewed this item' }

  belongs_to :reviewable, polymorphic: true, counter_cache: :reviews_count
  belongs_to :account
end
