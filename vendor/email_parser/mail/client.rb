module Email
  class ClientMail < Client
   
    # Mail IMAP defaults
    Mail_IMAP_HOST = 'imap.aol.com'
    Mail_IMAP_PORT = 143
    
    # Connect to mail service.
    def connect(raise_errors=false)
      @imap = Net::IMAP.new(Mail_IMAP_HOST, Mail_IMAP_PORT, false, nil, false)
    rescue SocketError
      raise_errors and raise ConnectionError, "Couldn't establish connection with Mail IMAP service"
    end
    
    # Do something with given mailbox or within it context. 
    def mailbox(name, &block)
      name = name.to_s
      mailbox = (mailboxes[name] ||= MailboxMail.new(self, name))
      switch_to_mailbox(name) if @current_mailbox != name
      if block_given?
        mailbox_stack << @current_mailbox
        result = block.arity == 1 ? block.call(mailbox) : block.call
        mailbox_stack.pop
        switch_to_mailbox(mailbox_stack.last)
        return result
      end
      mailbox
    end
    alias :in_mailbox :mailbox
    alias :in_label :mailbox
    alias :label :mailbox
    
    def inbox
      mailbox("inbox")
    end

    def outbox
      mailbox("sent")
    end

    def inspect
      "#<Mail::Client#{'0x%04x' % (object_id << 1)} (#{username}) #{'dis' if !logged_in?}connected>"
    end
    
  end # ClientMail
end # Email
