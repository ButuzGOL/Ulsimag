class RemoveLoginFromEmailAccount < ActiveRecord::Migration
  def self.up
    remove_column :email_accounts, :login
  end

  def self.down
    add_column :email_accounts, :login, :string
  end
end
