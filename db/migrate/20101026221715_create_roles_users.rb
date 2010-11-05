class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.integer :role_id
      t.integer :user_id
    end  

    remove_column :users, :role_id
  end

  def self.down
    drop_table :roles_users
    add_column :users, :role_id
  end
end
