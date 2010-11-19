class User < ActiveRecord::Base
  belongs_to :contact
  has_and_belongs_to_many :roles
  has_many :relationships
  has_many :contacts, :through => :relationships
  has_and_belongs_to_many :groups

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role_ids, :admin, :name, :contact_id

  def role?(role)
    return !!self.roles.find_by_name(role)
  end

  def all_roles
    if self.admin?
      return "Admin, " + self.roles.collect{|r| r.name}.join(", ")
    else
      return self.roles.collect{|r| r.name}.join(", ")
    end
  end
end
