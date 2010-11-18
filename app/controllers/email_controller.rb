class EmailController < ApplicationController
  before_filter :authenticate
  before_filter :count_email_accounts

  def inbox
    @title = "Inbox"    
  end

  def outbox
    @title = "Outbox"
  end

  def all
    @title = "All"
  end

  private
    def count_email_accounts
      @count_email_accounts = current_user.email_account.count
    end
end
