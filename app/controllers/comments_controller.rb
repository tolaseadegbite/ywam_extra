class CommentsController < ApplicationController
  include CommentsHelper
  before_action :set_commentable, only: [:create]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      redirect_to comment_redirect_path(@commentable), notice: 'Comment created'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to create comment'
    end
  end

  def edit
    @commentable = @comment.commentable
  end

  def update
    if @comment.update(comment_params)
      redirect_to comment_redirect_path(@comment.commentable), notice: 'Comment updated'
    else
      @commentable = @comment.commentable
      render :edit
    end
  end

  def destroy
    commentable = @comment.commentable
    @comment.destroy
    redirect_to comment_redirect_path(commentable), notice: 'Comment deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(account: current_account)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    unless @comment.account == current_account
      redirect_to comment_redirect_path(@comment.commentable), alert: 'You are not authorized to perform this action'
    end
  end

  def set_commentable
    @commentable = if params[:comment_id]
                     Comment.find(params[:comment_id])
                   elsif params[:episode_id]
                     Episode.find(params[:episode_id])
                   elsif params[:podcast_id]
                     Podcast.find(params[:podcast_id])
                   else
                     raise "Unexpected commentable type"
                   end
  end
end