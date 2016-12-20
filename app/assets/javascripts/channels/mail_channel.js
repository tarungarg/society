document.addEventListener("turbolinks:load", function() {
  App.mails = App.cable.subscriptions.create({channel: 'MailChannel'}, {

  // Actioncable predefined method to receive data
    received: function(data) {
      var mails_count = $('.mail-count').html();
      $('.mail-count').html(parseInt(mails_count) + 1);
      toastr.info("New Mail From " + data.sender_name);
      return $('#mail-nav-bar').prepend(this.renderMessage(data))
    },
    renderMessage: function(data) {
      return JST["mails"](data);
    }
  });
})
