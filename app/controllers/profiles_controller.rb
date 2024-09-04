class ProfilesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_account
  before_action :owned_profile, only: [:edit, :update, :update, :destroy_cover_image]

  def show
  end

  def edit
    
  end

  def update
    if @account.update(profile_params)
      redirect_to(profile_url(@account.username), notice: "Profile updated!")
    else
      # render :edit, status: :unprocessable_entity
      render(
        turbo_stream: turbo_stream.update(
          "profile_form",
          partial: "profiles/form",
          locals: {
            account: current_account
          }
        )
      )
    end
  end

  def following
    @title = "Following"
    @accounts = @account.following.order(id: :desc)
    render 'profiles/components/show_follow'
  end

  def followers
    @title = "Followers"
    @accounts = @account.followers.order(id: :desc)
    render 'profiles/components/show_follow'
  end

  def destroy_cover_image
    if @account.cover_image.attached?
      @account.cover_image.purge
      redirect_to profile_url(current_account.username), notice: 'Cover image deleted successfully'
    else
      redirect_to profile_url(current_account.username), notice: 'Nothing to delete'
    end
  end

  private

    def profile_params
      params.require(:account).permit(:first_name, :last_name, :username, :dob, :bio, :avatar, :cover_image)
    end

    def find_account
      @account = Account.find_by(username: params[:username]) || current_account
    end

    def owned_profile
      redirect_to(root_url, status: :see_other, notice: 'Access denied, profile does not belong to you!') unless current_account == @account
    end
end
