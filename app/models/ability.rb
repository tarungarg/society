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
    can :manage, [Member, Announcement, Policy, VotesController, Banner, Election, Post]
    can [:update, :destroy], [Job, Suggestion, Product, Carpool, Complaint, Club, Fund, Charge], user_id: @user.id
    can [:index, :show, :create], [Job, Suggestion, Product, Carpool, Complaint, Rent, Club, Fund, Charge]
    can [:create_review, :upvote], Complaint
    can [:mark_as_unresolve, :mark_as_resolve], Complaint, user_id: @user.id
  end

  def member_privileges
    can [:show, :index, :user_profile], [Member, Announcement, Election, Fund, Charge]
    can [:show, :download, :index], Policy
    can [:index, :vote, :detail], VotesController
    can [:update, :destroy], [Job, Suggestion, Product, Carpool, Complaint, Rent, Club, Post], user_id: @user.id
    can [:index, :show, :create, :upvote], [Job, Suggestion, Product, Carpool, Complaint, Rent, Club]
    can [:mark_as_unresolve, :mark_as_resolve], Complaint, user_id: @user.id
  end
end
