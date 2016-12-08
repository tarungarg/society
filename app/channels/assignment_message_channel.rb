class AssignmentMessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "assignmentresponse_messages_#{params[:id]}"
  end
end
