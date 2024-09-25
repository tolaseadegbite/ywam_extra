# == Schema Information
#
# Table name: episodes
#
#  id            :bigint           not null, primary key
#  description   :text             not null
#  episode_type  :integer          default("standard"), not null
#  follows_count :integer          default(0), not null
#  saves_count   :integer          default(0), not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :bigint           not null
#  podcast_id    :bigint           not null
#
# Indexes
#
#  index_episodes_on_category_id  (category_id)
#  index_episodes_on_podcast_id   (podcast_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (podcast_id => podcasts.id)
#
require "test_helper"

class EpisodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
