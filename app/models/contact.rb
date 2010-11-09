class Contact < ActiveRecord::Base
  has_one :user
  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups

  def full_name
    return self.firstname + " " + self.lastname
  end
end
