# == Schema Information
#
# Table name: podcast_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  podcast_id :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_podcast_tags_on_podcast_id  (podcast_id)
#  index_podcast_tags_on_tag_id      (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (podcast_id => podcasts.id)
#  fk_rails_...  (tag_id => tags.id)
#
class PodcastTag < ApplicationRecord
  belongs_to :podcast
  belongs_to :tag
end
