module CommentsHelper
  def comment_redirect_path(commentable)
    case commentable
    when Episode
      podcast_episode_path(commentable.podcast, commentable)
    when Podcast
      podcast_path(commentable)
    when Comment
      comment_redirect_path(commentable.commentable)
    else
      root_path
    end
  end
end