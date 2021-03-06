class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :salt
      t.string :encrypted_password
      t.string :lost_password
      t.boolean :admin

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
