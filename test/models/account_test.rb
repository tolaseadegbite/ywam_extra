# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  bio                    :string
#  dob                    :date             not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  followers_count        :integer          default(0), not null
#  following_count        :integer          default(0), not null
#  last_name              :string           not null
#  mod                    :boolean          default(FALSE)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#  index_accounts_on_username              (username) UNIQUE
#
require "test_helper"

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
