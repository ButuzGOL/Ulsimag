module Email
  class Mailbox
    MAILBOX_ALIASES = {
      :all       => ['ALL'],
      :seen      => ['SEEN'],
      :unseen    => ['UNSEEN'],
      :read      => ['SEEN'],
      :unread    => ['UNSEEN'],
      :flagged   => ['FLAGGED'],
      :unflagged => ['UNFLAGGED'],
      :starred   => ['FLAGGED'],
      :unstarred => ['UNFLAGGED'], 
      :deleted   => ['DELETED'],
      :undeleted => ['UNDELETED'],
      :draft     => ['DRAFT'],
      :undrafted => ['UNDRAFT']
    }
  
    attr_reader :name

    # This is a convenience method that really probably shouldn't need to exist, 
    # but it does make code more readable, if seriously all you want is the count 
    # of messages.
    def count(*args)
      emails(*args).size
    end

    # Cached messages. 
    def messages
      @messages ||= {}
    end
    
    def to_s
      name
    end

    MAILBOX_ALIASES.each_key { |mailbox|
      define_method(mailbox) do |*args, &block|
        emails(mailbox, *args, &block)
      end
    }
  end # Mailbox
end # Email
