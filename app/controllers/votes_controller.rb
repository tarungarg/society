class VotesController < BaseController
  load_and_authorize_resource class: VotesController

  before_action :set_user, only: [:vote, :visible]
  before_action :list_users, only: [:index, :detail, :declare]

  def index
  end

  def vote
    respond_to do |format|
      if current_tenant.user_setting.voting_visible
        unless current_user.has_voted?
          if @user.vote_by :voter => current_user, vote_scope: 'elect'
            format.js
          else
            format.js {  render status: 200, js: "Please Contact Support" }
          end
        else
            format.js {  render status: 200 }
        end
      else
        format.js {  render status: 200, js: "toastr.info('Voting has closed. Please refresh page ')" }
      end
    end
  end

  def visible
    respond_to do |format|
      if current_tenant.user_setting.update(voting_visible: params[:visible])
        if params[:visible] == 'true'
          Announcement.create(
            title: 'Voting has been started. Please see tab in sidebar.',
            desc: 'Voting has been started. Please see tab in sidebar.'
            )
        else
          Announcement.create(
            title: 'Voting has been end.',
            desc: 'Voting has been end. Please wait for result in sidebar.'
            )
        end
        format.js {  render status: 200, js: "location.reload();" }
      else
        format.js {  render status: 200, js: "toastr.info('Please contact support')" }
      end
    end
  end

  def detail
    hash = Hash.new
    @users.each do |user|
      hash[user.id] = user.calculate_votes_size
    end
    id = largest_hash_key(hash)
    @user = User.find(id) unless id.blank?
  end

  def declare
    hash = Hash.new
    @users.each do |user|
      hash[user.id] = user.votes.size
    end

    user = @users.find(largest_hash_key(hash))
    
    election = Election.last
    election.update(win_user: user.id, win_by: user.calculate_votes_size)

    @users.where(candidate: true).each do |user|
      votes =  user.find_votes_for(:vote_scope => 'elect')
      votes.destroy_all if votes
    end

    @users.update_all(candidate: false)

    Announcement.create(
            title: "Hurry!! #{user.name} win",
            desc: "#{user.name} is winner and elected as president"
            )

    respond_to do |format|
      format.js {  render status: 200, js: "toastr.info('Declared')" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.where(id: params[:candidate_id], tenant_id: current_tenant.id).first
    end

    def list_users
      @users = User.where(candidate: true, tenant_id: current_tenant.id)
    end

end
