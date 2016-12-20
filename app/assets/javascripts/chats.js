/**
 * @name openChatConnections
 *
 * @params
 * @message_channel {str} actioncable message channel name
 * @reply_channel {str} actioncable reply channel name
 * @delete_channel {str} actioncable delete_channel name
 * @obj_id {str} model id of any object like lesson, course
 * @chat_box_id {str} html attribute id name to append messages via js
 *
 * @description
 * This method creates websockets and open channels for communication
 * Some defined set function by actioncable
 * 
 * @example_params
 * message_channel = "LessonMessagesChannel", reply_channel = "LessonMessagesReplyChannel",
 * delete_channel = "DeleteMessageChannel", obj_id = "19",
 * chat_box_id = "lesson-chat-box"
 *
 * Reference doc
 * https://github.com/rails/actioncable/tree/archive#passing-parameters-to-channel
 */

function openChatConnections(message_channel, reply_channel, delete_channel, obj_id, chat_box_id){
  // Unsubscribe events
  unsubscribeChatEvents();
  // Subscribe channel for main messages, passing id as for unique channel
  App.snippets = App.cable.subscriptions.create({channel: message_channel, id: obj_id}, {

  // Actioncable predefined method to receive data
    received: function(data) {
      if ($(".message_form")[0])
        $(".message_form")[0].reset();

      switch(chat_box_id) {
        case 'course-chat-box':
          render_obj = this
          initCourseChat(chat_box_id, data, render_obj);
          return true
          break;
        case 'assignmentresponse-chat-box':
          $(".assignment-chat-form .message_form")[0].reset();
          $(".file-list").html('');
        default:
          return $('#'+chat_box_id).prepend(this.renderMessage(data));
      }
    },
    renderMessage: function(data) {
      return JST["messages"](data);
    }
  });

  // Subscribe channel for reply messages, passing id as for unique channel
  App.replies = App.cable.subscriptions.create({channel: reply_channel, id: obj_id}, {
    received: function(data) {
      $('.form-group textarea').val('');

      switch(chat_box_id) {
        case 'course-chat-box':
          render_obj = this
          initCourseReply(data, render_obj);
          return true
          break;
        default:
          return $('.replydiv'+data.model_name+data.message_id+'_'+data.model_id).append(this.renderMessage(data));
      }

    },
    renderMessage: function(data) {
      return JST["reply"](data);
    }
  });

  if (App.messages == undefined) {
    App.messages = App.cable.subscriptions.create({channel: delete_channel}, {
      received: function(data) {
        return $('.'+data.module_name+'_'+data.message_id).remove();
      }
    });
  }
}

// on reload/close window close all connections
$(window).on('beforeunload', function(){
  unsubscribeChatEvents();
  if (App.messages)
    App.messages.unsubscribe();
});

function initCourseChat(chat_box_id, data, render_obj){
  $(".file-list").html('');
  var chatbox = $('#'+chat_box_id);
  chatbox.prepend(render_obj.renderMessage(data));
  toolTipHandler(chatbox.find('.user_popup'));
}

function initCourseReply(data, render_obj){
  $('.form-group textarea').val('');
  var reply = $('.replydiv'+data.model_name+data.message_id+'_'+data.model_id);
  reply.prepend(render_obj.renderMessage(data));
  toolTipHandler(reply.find('.user_popup'));
}

function unsubscribeChatEvents(){
  if (App.snippets)
    App.snippets.unsubscribe();
  if (App.replies)
    App.replies.unsubscribe();
}
