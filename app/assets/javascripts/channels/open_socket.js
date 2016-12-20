document.addEventListener("turbolinks:load", function() {
  initChatObj();
});

$(window).on('beforeunload', function(){
  if (App.mails)
    App.mails.unsubscribe();
  if (App.notifications)
    App.notifications.unsubscribe();
});
