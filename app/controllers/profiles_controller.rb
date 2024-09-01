class ProfilesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_account
  before_action :owned_profile, only: [:edit, :update]

  def show
    @account = Account.find_by(username: params[:username])
  end

  def edit
  end

  def update
  end

  private

    def profile_params
      params.require(:account).permit(:first_name, :last_name, :dob)
    end

    def find_account
      @account = Account.find_by(username: params[:username])
    end

    def owned_profile
      @account = Account.find_by(username: params[:username])
      redirect_to(root_url, status: :see_other, notice: 'Access denied, profile does not belong to you!') unless current_account == @account
    end
end
