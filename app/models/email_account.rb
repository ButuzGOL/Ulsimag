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
  email_regex = /\A[\w+\-.]+@(gmail|mail|aol).com/i

  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false,
                                     :scope => :user_id }

  validates :password, :presence => true

end
