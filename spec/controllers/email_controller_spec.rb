require 'spec_helper'

describe EmailController do

  describe "GET 'inbox'" do
    it "should be successful" do
      get 'inbox'
      response.should be_success
    end
  end

  describe "GET 'outbox'" do
    it "should be successful" do
      get 'outbox'
      response.should be_success
    end
  end

  describe "GET 'all'" do
    it "should be successful" do
      get 'all'
      response.should be_success
    end
  end

end
