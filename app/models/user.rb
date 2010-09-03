class User < ActiveRecord::Base
  belongs_to :role
  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :groups

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

end
