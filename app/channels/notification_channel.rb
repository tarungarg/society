class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_for_user_#{current_user.id}"
  end
end
