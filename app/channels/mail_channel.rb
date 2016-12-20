class MailChannel < ApplicationCable::Channel
  def subscribed
    stream_from "mail_to_user_#{current_user.id}"
  end
end
