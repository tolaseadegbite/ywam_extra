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

class Event < ApplicationRecord
  # Make sure the follwing event attributes are present before saving to database
  validates :name, :details, :start_date, :start_time, :end_date, :end_time, :event_type, :cost_type, presence: true

  # Validates that states belong to proper country and cities belong to proper state
  validates :state, inclusion: { in: ->(record) { record.states.keys }, allow_blank: true }
  validates :city, inclusion: { in: ->(record) { record.cities }, allow_blank: true }

  # Associate event to a account
  belongs_to :account

  # Associate event to a eventcategory
  belongs_to :category

  # Image
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [1225, 388]
  end

  validates :image, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }


  # associate the follwing objects to an event and also delete from database when the event is destroyed
  # has_many :event_speakers, dependent: :destroy
  # has_many :event_talks, dependent: :destroy

  has_many :event_co_hosts, dependent: :destroy
  has_many :co_hosts, through: :event_co_hosts, source: :account

  def add_co_host(account)
    event_co_hosts.create(account: account, role: :co_host, status: :pending)
  end

  def remove_co_host(account)
    event_co_hosts.find_by(account: account)&.destroy
  end

  has_many :rsvps, dependent: :destroy
  has_many :accounts, through: :rsvps

  # event types
  enum event_type: {
    'online': 0,
    'physical': 1,
    'online and physical': 2
  }

  # cost type options
  enum cost_type: {
    free: 0,
    paid: 1
  }

  # enums for status
  enum status: {
    draft: 0,
    published: 1,
    archived: 2
  }

  # enums for audience
  enum audience: {
    anyone: 0,
    serving_members_only: 1,
    alumni_only: 2,
    staffs_only: 3,
    leadership_only: 4
  }

  scope :ordered, -> { order("start_date ASC, start_time ASC") }
  scope :published, -> { where(status: :published) }

  def countries
    CS.countries.with_indifferent_access
  end
  
  def states
    CS.states(country).with_indifferent_access
  end
  
  def cities
    CS.cities(state, country) || []
  end
  
  def country_label
    countries[country]
  end
  
  def state_label
    states[state]
  end
end
