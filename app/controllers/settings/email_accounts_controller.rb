class Settings::EmailAccountsController < SettingsController
  before_filter :authorized_user, :only => :destroy
  
  def index
    @email_account = EmailAccount.new
    @email_accounts = current_user.email_account.paginate(:page => params[:page])
  end

  def create
    @email_account = current_user.email_account.build(params[:email_account])
   
    if @email_account.save
      flash[:success] = "Email account add."
      redirect_to
    else
      @email_accounts = current_user.email_account.paginate(:page => params[:page])
      render 'index'
    end
  end

  def destroy
    @email_account = EmailAccount.find(params[:id])

    @email_account.destroy
    flash[:success] = "Email account destroyed."
    redirect_to settings_email_accounts_url
  end

  private

    def authorized_user
      @email_account = EmailAccount.find(params[:id])
      redirect_to root_path unless current_user?(@email_account.user)
    end
end