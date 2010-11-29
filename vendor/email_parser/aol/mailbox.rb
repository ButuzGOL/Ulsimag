module Email
  class MailboxAOL < Mailbox
    
    def initialize(aol, name="INBOX")
      @name  = name
      @aol = aol
    end

    # Returns list of emails which meets given criteria. 
    def emails(*args, &block)
      args << :all if args.size == 0

      if args.first.is_a?(Symbol) 
        search = MAILBOX_ALIASES[args.shift].dup
        opts = args.first.is_a?(Hash) ? args.first : {}
        
        opts[:after]      and search.concat ['SINCE', opts[:after].to_imap_date]
        opts[:before]     and search.concat ['BEFORE', opts[:before].to_imap_date]
        opts[:on]         and search.concat ['ON', opts[:on].to_imap_date]
        opts[:from]       and search.concat ['FROM', opts[:from]]
        opts[:to]         and search.concat ['TO', opts[:to]]
        opts[:subject]    and search.concat ['SUBJECT', opts[:subject]]
        opts[:label]      and search.concat ['LABEL', opts[:label]]
        opts[:attachment] and search.concat ['HAS', 'attachment']
        opts[:search]     and search.concat [opts[:search]]
        
        @aol.mailbox(name) do
          @aol.conn.uid_search(search).collect do |uid|
            message = (messages[uid] ||= MessageAOL.new(self, uid))
            block.call(message) if block_given?
            message
          end
        end
      elsif args.first.is_a?(Hash)
        emails(:all, args.first)
      else
        raise ArgumentError, "Invalid search criteria"
      end
    end
    alias :mails :emails
    alias :search :emails
    alias :find :emails
    alias :filter :emails

    def inspect
      "#<AOL::Mailbox#{'0x%04x' % (object_id << 1)} name=#{@name}>"
    end

  end # MailboxAOL
end # Email
