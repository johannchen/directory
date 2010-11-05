class AddUserToContact < ActiveRecord::Migration
  def self.up
    remove_column :users, :contact_id
    add_column :contacts, :user_id, :integer
  end

  def self.down
    add_column :users, :contact_id, :integer
    remove_column :contacts, :user_id 
  end
end
