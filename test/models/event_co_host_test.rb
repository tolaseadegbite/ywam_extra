# == Schema Information
#
# Table name: event_co_hosts
#
#  id            :bigint           not null, primary key
#  decline_count :integer          default(0)
#  role          :integer          default(1)
#  status        :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint           not null
#  event_id      :bigint           not null
#
# Indexes
#
#  index_event_co_hosts_on_account_id               (account_id)
#  index_event_co_hosts_on_event_id                 (event_id)
#  index_event_co_hosts_on_event_id_and_account_id  (event_id,account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (event_id => events.id)
#
require "test_helper"

class EventCoHostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
