class BaseController < ApplicationController
  layout 'dashboard-j'
  before_action :authenticate_user!
  include PublicActivity::StoreController
  before_action :get_navbar_data

  helper_method :mailbox, :conversation


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def get_navbar_data
    if current_user
      @mails = mailbox.inbox({unread: true}).order('created_at desc').limit(5)
      @activities_nav = PublicActivity::Activity.order("created_at desc").where(recipient_id: current_user.id, recipient_type: "User").limit(10)
    end
  end

  def set_advertisement(area)
    banner = Banner.where(area: Banner.areas[area]).first
    if banner
      @banner_image, @banner_url = banner.desktop_image.url, banner.desktop_url
    end
  end

  private

    def mailbox
      @mailbox ||= current_user.mailbox if current_user
    end

    def conversation
      @conversation ||= mailbox.conversations.find(params[:id]) if params[:id]
    end
end
