class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == "admin"
      can :manage, :all

    else
      can :read, :all    

      can :update, User do |u|
        u == user
      end

      can :follow, User do |u|
        u == user
      end

      can :unfollow, User do |u|
        u == user
      end

    end

  end
end
