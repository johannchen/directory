class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    elsif user.role? :director
      can :manage, :all
    elsif user.role? :staff
      can :manage, :all
    else
      can :read, :all
    end
  end
end
