class CreateContactUserJoinTable < ActiveRecord::Migration
  def self.up
    create_table :contacts_users, :id => false do |t|
      t.integer :contact_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :contacts_users
  end
end
