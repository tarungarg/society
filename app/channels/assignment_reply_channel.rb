class AssignmentReplyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "assignmentresponse_messages_reply_#{params[:id]}"
  end
end
