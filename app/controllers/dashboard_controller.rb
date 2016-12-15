class DashboardController < BaseController
  before_action :authenticate_user!

  def index
    @members_count = current_tenant.users.count
    @mails_count = mailbox.inbox.count
    @complaints_count = current_user.complaints.where(status: 1).count
    @policies_count = Policy.count
    @tasks = Task.order('created_at desc')
  end
end
