class Ability
  include CanCan::Ability

  def initialize(user = nil)
    @user = user #|| User.new # guest user (not logged in)
    president_privileges if @user.has_role?(:president)
    member_privileges if @user.has_role?(:member)
    instructor_privileges if @user.has_role?('instructor')
  end

  private

  def president_privileges
    can :manage, [Member, Announcement, Policy, VotesController]
  end

  def member_privileges
    can [:show, :index], [Member, Announcement]
    can [:show, :download, :index], Policy
    can [:index, :vote, :detail], VotesController
  end
end
