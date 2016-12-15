class DashboardController < BaseController
  # before_action :authenticate_user!

  def index
    @inbox = mailbox.inbox
    @active = :inbox
  end
end
