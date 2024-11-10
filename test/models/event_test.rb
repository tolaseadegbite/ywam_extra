# == Schema Information
#
# Table name: events
#
#  id                 :bigint           not null, primary key
#  audience           :integer          default("anyone")
#  booking_url        :string
#  city               :string
#  cost_type          :integer          not null
#  country            :string
#  details            :text             not null
#  end_date           :date             not null
#  end_time           :time             not null
#  event_type         :integer          not null
#  location           :string
#  name               :string           not null
#  start_date         :date             not null
#  start_time         :time             not null
#  state              :string
#  status             :integer          default("draft")
#  streaming_link     :string
#  streaming_platform :string
#  street_address     :string
#  time_zone          :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_id         :bigint           not null
#  category_id        :bigint           not null
#
# Indexes
#
#  index_events_on_account_id   (account_id)
#  index_events_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (category_id => categories.id)
#
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
