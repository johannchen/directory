class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    

    # default roles: Admin, Staff, Helper (they cannot be modified?)
    if user.admin?
      can :manage, :all
    elsif user.role? "Staff"
      can :manage, :all
    else
      can :read, :all
    end
  end
end
