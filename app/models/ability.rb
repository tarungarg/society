class Ability
  include CanCan::Ability

  def initialize(user = nil)
    @user = user
    president_privileges if @user.has_role?(:president)
    member_privileges if @user.has_role?(:member)
    member_privileges if @user.has_role?('instructor')
  end

  private

  def president_privileges
    can :manage, [Member, Announcement, Policy, VotesController]
    can [:update, :destroy], [Job, Suggestion, Product], user_id: @user.id
    can [:index, :show, :create], [Job, Suggestion, Product]
  end

  def member_privileges
    can [:show, :index], [Member, Announcement]
    can [:show, :download, :index], Policy
    can [:index, :vote, :detail], VotesController
    can [:update, :destroy], [Job, Suggestion, Product], user_id: @user.id
    can [:index, :show, :create], [Job, Suggestion, Product]
  end
end
