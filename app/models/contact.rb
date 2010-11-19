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

end
