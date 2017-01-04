class MailboxController < BaseController
  def inbox
    @inbox = mailbox.inbox.paginate(page: params[:page], per_page: 20)
    @active = :inbox
  end

  def sent
    @sent = mailbox.sentbox.paginate(page: params[:page], per_page: 20)
    @active = :sent
  end

  def trash
    @trash = mailbox.trash.paginate(page: params[:page], per_page: 20)
    @active = :trash
  end
end
