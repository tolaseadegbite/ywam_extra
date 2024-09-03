module ProfilesHelper
  def follow_button(account)
    if current_account.following?(account)
      render 'profiles/components/unfollow_button', account: account
    else
      render 'profiles/components/follow_button', account: account
    end
  end
end
