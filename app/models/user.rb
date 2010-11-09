class User < ActiveRecord::Base
  has_one :contact
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :groups

  accepts_nested_attributes_for :contact

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role_ids

  def role?(role)
    return !!self.roles.find_by_name(role)
  end
end
