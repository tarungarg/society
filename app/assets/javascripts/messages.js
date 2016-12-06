$(document).ready(function(){
  $('.chosen-it').chosen();
});

$(document).on('ready page:load', function() {
  $('.chosen-it').chosen();
});


document.addEventListener("turbolinks:load", function() {
  $('.chosen-it').chosen();
})
