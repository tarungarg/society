class BaseController < ApplicationController
  layout 'dashboard-j'
  before_action :authenticate_user!
  include PublicActivity::StoreController
  # load_and_authorize_resource
  before_action :get_navbar_data

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def get_navbar_data
    @mails = mailbox.inbox.order('created_at desc').limit(6)
    @activities = PublicActivity::Activity.order("created_at desc").where(recipient_id: current_user.id, recipient_type: "User")
  end
end
