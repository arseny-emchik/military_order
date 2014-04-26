class Ability
  # See the wiki for details:
  # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  include CanCan::Ability

  def initialize(user)
       user ||= User.new # guest user (not logged in)

       if user.admin?
         can :manage, :all
       elsif user.member?
         can :read, :all
       end
  end
end
