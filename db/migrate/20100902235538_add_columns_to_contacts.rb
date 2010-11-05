class AddColumnsToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :gender, :string
    add_column :contacts, :second_email, :string
    add_column :contacts, :cell_phone, :string
    add_column :contacts, :home_phone, :string
    add_column :contacts, :birthday, :date
    add_column :contacts, :address, :string
    add_column :contacts, :hometown, :string
    add_column :contacts, :came_through, :string
    add_column :contacts, :note, :string
    add_column :contacts, :status_id, :integer
  end

  def self.down
    remove_column :contacts, :gender 
    remove_column :contacts, :second_email
    remove_column :contacts, :cell_phone
    remove_column :contacts, :home_phone
    remove_column :contacts, :birthday
    remove_column :contacts, :address
    remove_column :contacts, :hometown
    remove_column :contacts, :came_through
    remove_column :contacts, :note
    remove_column :contacts, :status_id
  end
end
