class ConversationsController < BaseController
  include ApplicationHelper

  def new
  end

  def create
    recipients = current_tenant.users.where(id: conversation_params[:recipients])
    conversation =
              current_user.send_message(recipients,
                                          conversation_params[:body],
                                          conversation_params[:subject]
                                      ).conversation

    # broadcast messages
    conversation_params[:recipients].each do |recipient_id|
      broadcast_mail_to_recipient(conversation_params, recipient_id, conversation)
    end

    flash[:success] = "Your message was successfully sent!"
    redirect_to conversation_path(conversation)
  end

  def show
    @active = params[:active_page]
    @receipts = conversation.receipts_for(current_user)
    # mark conversation as read
    conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = "Your reply message was successfully sent!"
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end

  private

  def conversation_params
    params[:conversation][:recipients] = params[:conversation][:recipients].reject(&:empty?)
    params.require(:conversation).permit(:subject, :body, recipients:[])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end

  def broadcast_mail_to_recipient(conversation_params, recipient_id, conversation)
    ActionCable.server.broadcast("mail_to_user_#{ recipient_id }",
      sender_name: current_user.name,
      mail_subject: conversation_params[:subject],
      time_sent_at: formatted_time(conversation.created_at),
      id: conversation.id,
      sender_image_url: current_user.avatar.url,
      conversation_show_path: conversation_path(conversation.id, active_page: 'inbox'),
    )
  end

end
