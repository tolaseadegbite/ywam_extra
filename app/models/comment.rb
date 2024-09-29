# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint           not null
#  commentable_id   :bigint           not null
#
# Indexes
#
#  index_comments_on_account_id   (account_id)
#  index_comments_on_commentable  (commentable_type,commentable_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Comment < ApplicationRecord
  belongs_to :account
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  def find_top_parent
    return commentable unless commentable.is_a?(Comment)
    commentable.find_top_parent
  end

  def root_commentable
    top_parent = find_top_parent
    case top_parent
    when Episode
      [top_parent.podcast, top_parent]
    when Podcast
      top_parent
    else
      raise "Unexpected top parent type: #{top_parent.class}"
    end
  end
end
