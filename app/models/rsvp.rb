# == Schema Information
#
# Table name: rsvps
#
#  id         :bigint           not null, primary key
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_rsvps_on_account_id  (account_id)
#  index_rsvps_on_event_id    (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (event_id => events.id)
#
class Rsvp < ApplicationRecord
  
  belongs_to :account
  belongs_to :event
  
  enum status: { 
    interested: 0, 
    going: 1 
  }
  # validates :status, inclusion: { in: statuses.keys }
end
