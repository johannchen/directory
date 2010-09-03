class CreateContactGroupJoinTable < ActiveRecord::Migration
  def self.up
    create_table :contacts_groups, :id => false do |t|
      t.integer :contact_id
      t.integer :group_id
    end
  end

  def self.down
    drop_table :contacts_groups
  end
end
