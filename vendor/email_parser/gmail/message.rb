require 'mime/message'

module Email
  class MessageGmail < Message
    
    def initialize(mailbox, uid)
      @uid     = uid
      @mailbox = mailbox
      @gmail   = mailbox.instance_variable_get("@gmail") if mailbox
    end
    
    def uid
      @uid ||= @gmail.conn.uid_search(['HEADER', 'Message-ID', message_id])[0]
    end
    
    def inspect
      "#<Gmail::Message#{'0x%04x' % (object_id << 1)} mailbox=#{@mailbox.name}#{' uid='+@uid.to_s if @uid}#{' message_id='+@message_id.to_s if @message_id}>"
    end
    
    def envelope
      @envelope ||= @gmail.mailbox(@mailbox.name) {
        @gmail.conn.uid_fetch(uid, "ENVELOPE")[0].attr["ENVELOPE"]
      }
    end

    private
    
    def message
      @message ||= Mail.new(@gmail.mailbox(@mailbox.name) { 
        @gmail.conn.uid_fetch(uid, "RFC822")[0].attr["RFC822"] # RFC822
      })
    end
  end # MessageGmail
end # Email
