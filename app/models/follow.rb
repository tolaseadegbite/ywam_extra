# == Schema Information
#
# Table name: follows
#
#  id              :bigint           not null, primary key
#  followable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  followable_id   :bigint           not null
#
# Indexes
#
#  idx_on_account_id_followable_id_followable_type_b71b2f7ef2  (account_id,followable_id,followable_type) UNIQUE
#  index_follows_on_account_id                                 (account_id)
#  index_follows_on_account_id_and_followable_id               (account_id,followable_id) UNIQUE
#  index_follows_on_followable                                 (followable_type,followable_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Follow < ApplicationRecord
  validates :account_id, uniqueness: { scope: [:followable_id, :followable_type] }
  
  belongs_to :account
  belongs_to :followable, polymorphic: true, counter_cache: :follows_count
end
