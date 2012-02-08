class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.student?
      can [:index, :show, :edit, :update], Student, uid: user.uid
    else
      can :index, Student
    end
  end

end
