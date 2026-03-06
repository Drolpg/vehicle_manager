class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a?(Admin)
      can :manage, :all
    else
      can :read, Car
      can :read, Motorcycle
      can :read, Rental

      cannot :create, Car
      cannot :create, Motorcycle
      can :create, Rental

      cannot :update, Car
      cannot :update, Motorcycle

      cannot :destroy, Car
      cannot :destroy, Motorcycle
    end
  end
end
