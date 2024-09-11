class FollowsController < ApplicationController
  before_action :authenticate_account!

  def create
    @follow = current_account.follows.new(follow_params)
    @followable = @follow.followable
    if @follow.save
      respond_to do |format|
        format.html {redirect_to @followable, notice: "Podcast Followed"}
        format.turbo_stream { flash.now[:notice] = "Podcast Followed" }
      end
    else
      flash[:notice] = @follow.errors.full_messages.to_sentence
    end
  end

  def destroy
    @follow = current_account.follows.find(params[:id])
    @followable = @follow.followable
    @follow.destroy
    respond_to do |format|
      format.html {redirect_to @followable, notice: "Podcast Unfollowed"}
      format.turbo_stream { flash.now[:notice] = "Podcast Unfollowed" }
    end
  end

  private

      def follow_params
        params.require(:follow).permit(:followable_id, :followable_type)
      end

      def followable
        @followable ||= Followable.find(params[:followable_id])
      end
end
