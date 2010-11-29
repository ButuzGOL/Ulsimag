require 'net/imap'
require 'net/smtp'
require 'mail'
require 'date'
require 'time'

if RUBY_VERSION < "1.8.7"
  require "smtp_tls"
end

class Object
  def to_imap_date
    Date.parse(to_s).strftime("%d-%B-%Y")
  end
end

module Email

  autoload :Client,  "email_parser/base/client"
  autoload :Mailbox, "email_parser/base/mailbox"
  autoload :Message, "email_parser/base/message"

  class << self
    def new(username, password, options={}, &block)
      
      aload(username, password, options)

      @client.connect and @client.login
      if block_given?
        yield @client
        @client.logout
      end
      @client
    end
    alias :connect :new
    
    def new!(username, password, options={}, &block)
      
      aload(username, password, options)
      
      @client.connect! and @client.login!
      if block_given?
        yield @client
        @client.logout
      end
      @client
    end
    alias :connect! :new!

    def aload(username, password, options)

      if username.match(/@aol.com/)
        autoload :ClientAOL,  "email_parser/aol/client"
        autoload :MailboxAOL, "email_parser/aol/mailbox"
        autoload :MessageAOL, "email_parser/aol/message"

        @client = ClientAOL.new(username, password, options)
      elsif username.match(/@mail.com/)
        autoload :ClientMail,  "email_parser/mail/client"
        autoload :MailboxMail, "email_parser/mail/mailbox"
        autoload :MessageMail, "email_parser/mail/message"

        @client = ClientMail.new(username, password, options)
      else
        autoload :ClientGmail,  "email_parser/gmail/client"
        autoload :MailboxGmail, "email_parser/gmail/mailbox"
        autoload :MessageGmail, "email_parser/gmail/message"

        @client = ClientGmail.new(username, password, options)
      end
    end
  end # << self
end # Email
