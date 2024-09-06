class FollowsController < ApplicationController
  before_action :authenticate_account!

  def create
    @follow = current_account.follows.new(follow_params)
    if @follow.save
        followable = @follow.followable
        redirect_to followable
    else
        flash[:notice] = @follow.errors.full_messages.to_sentence
    end
  end

  def destroy
    @follow = current_account.follows.find(params[:id])
    followable = @follow.followable
    @follow.destroy
    redirect_to followable
  end

  private

      def follow_params
        params.require(:follow).permit(:followable_id, :followable_type)
      end

      def followable
        @followable ||= Followable.find(params[:followable_id])
      end
end
