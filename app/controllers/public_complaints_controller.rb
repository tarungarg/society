class PublicComplaintsController < BaseController
  # load_and_authorize_resource

  before_action :set_complaint, only: [:show]
  def index
    @filterrific = initialize_filterrific(
        Complaint,
        params[:filterrific]
      ) or return
      @complaints = user_is_president ?
                  @filterrific.find.where(view_publically: true).page(params[:page])
                  :
                  @filterrific.find.where(view_publically: true).where.not(user_id: current_user.id).page(params[:page]) 
    @unread_complain_ids = Complaint.unread_by(current_user).map(&:id)
  end

  def show
    @complaint.mark_as_read! :for => current_user
    @unread_complain_ids = Complaint.unread_by(current_user).map(&:id)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.includes(:user, :reviews).find(params[:id])
    end

end
