class Contact < ActiveRecord::Base
  has_one :user
  has_many :relationships
  has_many :users, :through => :relationships
  has_one :active_lead, :through => :relationships, :class_name => "User", :source => :user, :conditions => ["relationships.relationship = 'lead' and relationships.active = ?", true]
  has_one :active_helper, :through => :relationships, :class_name => "User", :source => :user, :conditions => ["relationships.relationship = 'helper' and relationships.active = ?", true]
  has_and_belongs_to_many :groups

  def full_name
    return self.firstname + " " + self.lastname
  end

  # TODO: make the statement in one line
  def active_lead_name
    if self.active_lead.nil? 
      "Not Assigned" 
    else 
      self.active_lead.name
    end
  end

  def active_helper_name
    if self.active_helper.nil? 
      "Not Assigned" 
    else 
      self.active_helper.name
    end
  end

  # TODO: simply query
  def self.search(search, group, order)
    if search
      if group.nil?
        where('firstname LIKE ?', "%#{search}%").order("#{order}")
      else
        find_by_sql ["SELECT * FROM contacts INNER JOIN contacts_groups ON contacts.id = contacts_groups.contact_id WHERE contacts.firstname LIKE ? AND contacts_groups.group_id = ?", "%#{search}%", "#{group}"]
      end
    else
      if group.nil?
        order("#{order}")
      else
        find_by_sql ["SELECT * FROM contacts INNER JOIN contacts_groups ON contacts.id = contacts_groups.contact_id WHERE contacts_groups.group_id = ?", "#{group}"]
      end
    end
  end
end
