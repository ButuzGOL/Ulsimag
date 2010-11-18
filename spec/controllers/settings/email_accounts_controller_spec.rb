require 'spec_helper'

describe Settings::EmailAccountsController do
  render_views

  describe "GET 'index'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "Settings")
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :password => "" }
      end

      it "should not create a email_account" do
        lambda do
          post :create, :email_account => @attr
        end.should_not change(EmailAccount, :count)
      end

      it "should have the right title" do
        post :create, :email_account => @attr
        response.should have_selector("title", :content => "Settings")
      end

      it "should render the 'index' page" do
        post :create, :user => @attr
        response.should render_template('index')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :email => "example@gmail.com",
                  :password => "example" }
      end

      it "should create a email account" do
        lambda do
          post :create, :email_account => @attr
        end.should change(EmailAccount, :count).by(1)
      end

      it "should redirect to the email account page" do
        post :create, :email_account => @attr
        response.should redirect_to(settings_email_accounts_path)
      end

      it "should have a message" do
        post :create, :email_account => @attr
        flash[:success].should =~ /Email account add./i
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => "example@aol.com", :name => "exampleaol")
        test_sign_in(wrong_user)
        @email_account = Factory(:email_account, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @email_account
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @email_account = Factory(:email_account, :user => @user)
      end

      it "should destroy the email account" do
        lambda do
          delete :destroy, :id => @email_account
        end.should change(EmailAccount, :count).by(-1)
      end
    end
  end
  
end
