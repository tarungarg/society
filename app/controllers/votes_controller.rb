class VotesController < BaseController
  load_and_authorize_resource class: VotesController

  before_action :set_user, only: [:vote, :visible]
  before_action :list_users, only: [:index, :detail, :declare]

  def index
  end

  def vote
    respond_to do |format|
      if current_tenant.user_setting.voting_visible
        if current_user.has_voted?
          format.js { render status: 200 }
        else
          if @user.vote_by voter: current_user, vote_scope: 'elect'
            format.js
          else
            format.js { render status: 200, js: 'Please Contact Support' }
          end
        end
      else
        format.js { render status: 200, js: "toastr.info('Voting has closed. Please refresh page ')" }
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
        format.js {  render status: 200, js: 'location.reload();' }
      else
        format.js {  render status: 200, js: "toastr.info('Please contact support')" }
      end
    end
  end

  def detail
    hash = {}
    @users.each do |user|
      hash[user.id] = user.calculate_votes_size
    end
    @max_hash = largest_hash_key(hash)
    @user = User.find(@max_hash.keys[0]) if @max_hash && @max_hash.length == 1
  end

  def declare
    hash = {}
    @users.each do |user|
      hash[user.id] = user.votes.size
    end

    max_hash = largest_hash_key(hash)
    user_id = ''
    user_id = if max_hash && max_hash.length == 1
                max_hash.keys[0]
              else
                Hash[max_hash.to_a.shuffle].keys[0]
              end

    user = User.find(user_id)

    current_tenant.user_setting.update(voting_visible: false)

    election = Election.last
    election.update(win_user: user.id, win_by: user.calculate_votes_size)

    @users.where(candidate: true).each do |user|
      votes = user.find_votes_for(vote_scope: 'elect')
      votes.destroy_all if votes
    end

    @users.where(candidate: true).update_all(candidate: false)

    Announcement.create(
      title: "Hurry!! #{user.name} win",
      desc: "#{user.name} is winner and elected as president"
    )

    respond_to do |format|
      format.js { render status: 200, js: "toastr.info('Declared'); location.reload();" }
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
