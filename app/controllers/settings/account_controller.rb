class Settings::AccountController < SettingsController
  def index
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated."
      redirect_to settings_account_url
    else
      render 'index'
    end
  end

end
