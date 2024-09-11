module PodcastsHelper
  def render_podcast_date(podcast)
    if podcast.created_at < 1.year.ago
      podcast.created_at.strftime("%m/%d")
    else
      podcast.created_at.strftime("%m/%d/%Y")
    end
  end
end
