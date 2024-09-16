# == Schema Information
#
# Table name: podcasts
#
#  id             :bigint           not null, primary key
#  about          :text             not null
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
require "test_helper"

class PodcastTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
