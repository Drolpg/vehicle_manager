class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can :read, Car
      can :read, Motorcycle

      can :create, Car
      can :create, Motorcycle

      cannot :update, Car
      cannot :update, Motorcycle

      cannot :destroy, Car
      cannot :destroy, Motorcycle
    end
  end
end
