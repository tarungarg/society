class DashboardController < BaseController
  before_action :authenticate_user!

  def index
    @members_count = current_tenant.users.count
    @mails_count = mailbox.inbox.count
    @complaints_count = current_user.complaints.where(status: 1).count
    @policies_count = Policy.count
    @tasks = current_user.tasks.order('created_at desc')
    @members = current_tenant.users.order('created_at desc').limit(6)

    banner = Banner.where(area: 0).first
    if banner
      @banner_image, @banner_url = banner.desktop_image.url, banner.desktop_url
    end
  end

end
