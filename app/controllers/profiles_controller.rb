class ProfilesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_account
  # before_action :owned_profile, only: [:edit, :update]

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
    # @account  = Account.find_by(username: params[:username])
    @accounts = @account.following.order(id: :desc)
    render 'profiles/components/show_follow'
  end

  def followers
    @title = "Followers"
    # @account  = Account.find_by(username: params[:username])
    @accounts = @account.followers.order(id: :desc)
    render 'profiles/components/show_follow'
  end

  private

    def profile_params
      params.require(:account).permit(:first_name, :last_name, :username, :dob, :bio)
    end

    def find_account
      @account = Account.find_by(username: params[:username]) || current_account
      redirect_to(root_url, status: :see_other, notice: 'Access denied, profile does not belong to you.') unless @account == current_account
    end

    # def owned_profile
    #   @account = Account.find_by(username: params[:username])
    #   redirect_to(root_url, status: :see_other, notice: 'Access denied, profile does not belong to you!') unless current_account == @account
    # end
end
