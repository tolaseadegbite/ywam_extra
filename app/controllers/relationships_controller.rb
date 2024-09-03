class RelationshipsController < ApplicationController
  before_action :authenticate_account!

  def create
    @account = Account.find(params[:followed_id])
    current_account.follow(@account)
    respond_to do |format|
      format.html { redirect_to profile_path(@account.username) }
      format.turbo_stream
    end
  end
  
  def destroy
    @account = Relationship.find(params[:id]).followed
    current_account.unfollow(@account)
    respond_to do |format|
      format.html { redirect_to profile_path(@account.username), status: :see_other }
      format.turbo_stream
    end
  end
end