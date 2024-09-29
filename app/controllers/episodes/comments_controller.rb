module Episodes
  class CommentsController < CommentsController
    private

    def set_commentable
      @commentable = Episode.find(params[:episode_id])
    end
  end
end