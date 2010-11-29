require 'mime/message'

module Email
  class MessageMail < Message
    
    def initialize(mailbox, uid)
      @uid     = uid
      @mailbox = mailbox
      @mail   = mailbox.instance_variable_get("@mail") if mailbox
    end
    
    def uid
      @uid ||= @mail.conn.uid_search(['HEADER', 'Message-ID', message_id])[0]
    end
    
    def inspect
      "#<Mail::Message#{'0x%04x' % (object_id << 1)} mailbox=#{@mailbox.name}#{' uid='+@uid.to_s if @uid}#{' message_id='+@message_id.to_s if @message_id}>"
    end
    
    def envelope
      @envelope ||= @mail.mailbox(@mailbox.name) {
        @mail.conn.uid_fetch(uid, "ENVELOPE")[0].attr["ENVELOPE"]
      }
    end

    private
    
    def message
      @message ||= Mail.new(@mail.mailbox(@mailbox.name) {
        @mail.conn.uid_fetch(uid, "RFC822")[0].attr["RFC822"] # RFC822
      })
    end
  end # MessageMail
end # Email
