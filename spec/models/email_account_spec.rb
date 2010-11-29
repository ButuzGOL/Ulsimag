require 'spec_helper'

describe EmailAccount do
  before(:each) do
    @user = Factory(:user)
    @attr = { :email => "ButuzGOL.7@gmail.com", :password => "welcome777" }
  end

  it "should create a new instance given valid attributes" do
    @user.email_account.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @email_account = @user.email_account.create(@attr)
    end

    it "should have a user attribute" do
      @email_account.should respond_to(:user)
    end

    it "should have the right associated user" do
      @email_account.user_id.should == @user.id
      @email_account.user.should == @user
    end
  end

  describe "validations" do

    it "should require a user id" do
      EmailAccount.new(@attr).should_not be_valid
    end

    it "should require nonblank email" do
      @user.email_account.build(@attr.merge(:email => "")).should_not be_valid
    end

    it "should require nonblank password" do
      @user.email_account.build(@attr.merge(:password => "")).should_not be_valid
    end

    it "should reject invalid email" do
      @user.email_account.build(@attr.merge(:email => "example@example.ru")).should_not be_valid
    end

    it "should reject duplicate email" do
      @user.email_account.create!(@attr)
      @user.email_account.build(@attr).should_not be_valid
    end

    it "should reject valid email addresses" do
      addresses = %w[ButuzGOL.7@gmail.com ButuzGOL@mail.com]
      addresses.each do |address|
        valid_email_account = @user.email_account.build(@attr.merge(:email => address))
        valid_email_account.should be_valid
      end
    end
  end

end
