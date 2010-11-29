module EmailHelper
  def not_subject_if_blank(value)
    value.blank? ? "(No subject)" : value
  end

  def clear_address(from)
    from.mailbox + "@" + from.host
  end

  def clear_datetime(datetime)
    datetime = datetime.to_datetime.strftime("%H:%M %d-%m-%Y")
  end

  def clear_body(email)
    if !email.parts.empty?
      return refactor_html_body(email.html_part.decoded) if !email.html_part.nil?
      return refactor_text_body(email.text_part.decoded) if !email.text_part.nil?
    elsif !email.body.empty?
      refactor_text_body(email.body)
    end
  end

  private
    def refactor_html_body(content)
      content.to_s.html_safe
    end

    def refactor_text_body(content)
      content.to_s.html_safe
    end
end
