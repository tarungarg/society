document.addEventListener("turbolinks:load", function() {
  if (App.notifications == undefined){
    App.notifications = App.cable.subscriptions.create({channel: 'NotificationChannel'}, {

    // Actioncable predefined method to receive data
      received: function(data) {
        var noti_count = $('.notification-count').html();
        $('.notification-count').html(parseInt(noti_count) + 1);
        return $('.activity-list-nav').prepend(this.renderMessage(data))
      },
      renderMessage: function(data) {
        if (data.type == 'Like'){
          toastr.info("Like From " + data.sender_name);
          return JST["public_activity/likes"](data);
        }
        if (data.type == 'Comment'){
          toastr.info("New Comment From " + data.sender_name);
          return JST["public_activity/comments"](data);
        }
      }
    });
  }
})
