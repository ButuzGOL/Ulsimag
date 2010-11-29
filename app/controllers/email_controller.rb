class EmailController < ApplicationController
  before_filter :authenticate
  before_filter :count_email_accounts

  COUNT_EMAILS_TO_PARSE = 5
  
  def inbox
    @title = "Inbox"
    @broken_email_accounts, @emails = get_and_refactor_emails(:inbox)
  end

  def outbox
    @title = "Outbox"
    @broken_email_accounts, @emails = get_and_refactor_emails(:outbox)
  end

  private
    def count_email_accounts
      @count_email_accounts = current_user.email_account.count
    end
    
    def get_and_refactor_emails(mailbox)
      require 'email_parser/email'

      broken_email_accounts = emails = []
      begin
        for email_account in current_user.email_account.each do
          email_parser = Email.new(email_account.email, email_account.password)
          if email_parser.logged_in?
            emails += email_parser.send(mailbox).emails.reverse[0..COUNT_EMAILS_TO_PARSE]
          else
            broken_email_accounts << email_account
          end
        end
        emails.sort! { |a, b| b.date.to_datetime <=> a.date.to_datetime }
      rescue
      end
        return broken_email_accounts, emails
    end
end
