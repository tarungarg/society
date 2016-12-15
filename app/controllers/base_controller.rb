class BaseController < ApplicationController
  layout 'dashboard-j'
  before_action :authenticate_user!
  include PublicActivity::StoreController
  # load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
