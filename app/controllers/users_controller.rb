class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Ulsimag!"
      redirect_to email_inbox_url
    else
      @title = "Sign up"
      render 'new'
    end
  end
end
