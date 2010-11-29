module Email
  class Client
    # Raised when connection with AOL IMAP service couldn't be established.
    class ConnectionError < SocketError; end
    # Raised when given username or password are invalid.
    class AuthorizationError < Net::IMAP::NoResponseError; end
    # Raised when delivered email is invalid. 
    class DeliveryError < ArgumentError; end

    attr_reader :username
    attr_reader :password
    attr_reader :options

    def initialize(username, password, options={})
      defaults  = {}
      @username = username
      @password = password
      @options  = defaults.merge(options)
    end
    
    # This version of connect will raise error on failure...
    def connect!
      connect(true)
    end
    
    # Return current connection. Log in automaticaly to specified account if 
    # it is necessary.
    def connection
      login and at_exit { logout } unless logged_in?
      @imap
    end
    alias :conn :connection
    
    # Login to specified account.
    def login(raise_errors=false)
      @imap and @logged_in = (login = @imap.login(username, password)) && login.name == 'OK'
    rescue Net::IMAP::NoResponseError
      raise_errors and raise AuthorizationError, "Couldn't login to given account: #{username}"
    end
    alias :sign_in :login
    
    # This version of login will raise error on failure...
    def login!
      login(true)
    end
    alias :sign_in! :login!
    
    # Returns +true+ when you are logged in to specified account.
    def logged_in?
      !!@logged_in
    end
    alias :signed_in? :logged_in?
    
    # Logout from service.
    def logout
      @imap && logged_in? and @imap.logout
    ensure
      @logged_in = false
    end
    alias :sign_out :logout

    def mailboxes
      @mailboxes ||= {}
    end
    
    private
    
    def switch_to_mailbox(mailbox)
      conn.select(mailbox) if mailbox
      @current_mailbox = mailbox
    end
    
    def mailbox_stack
      @mailbox_stack ||= []
    end
    
  end # Client
end # Email
