# == Schema Information
# Schema version: 20101115203843
#
# Table name: email_accounts
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  email      :string(255)
#  password   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class EmailAccount < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :presence => true
  
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false,
                                     :scope => :user_id }

  email_regex = /(\A[\w+\-.]+@(gmail|mail|aol).com$|^$)/i
  validates_format_of :email, :with => email_regex, 
            :message => "account can be just (gmail.com aol.com mail.com)"
            
  after_validation :is_login_to_service?

  validates :password, :presence => true

  def is_login_to_service?
      if errors.empty?
        require 'email_parser/email'
        email_parser = Email.new(email, password)
        errors[:base] << "Wrong email or password" if !email_parser.logged_in?
      end
  end
end
