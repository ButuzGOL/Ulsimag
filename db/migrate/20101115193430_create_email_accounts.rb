class CreateEmailAccounts < ActiveRecord::Migration
  def self.up
    create_table :email_accounts do |t|
      t.integer :user_id
      t.string :email
      t.string :login
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :email_accounts
  end
end
