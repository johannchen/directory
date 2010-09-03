class CreateEventGroupJoinTable < ActiveRecord::Migration
  def self.up
    create_table :events_groups, :id => false do |t|
      t.integer :event_id
      t.integer :group_id
    end
  end

  def self.down
    drop_table :events_groups
  end
end
