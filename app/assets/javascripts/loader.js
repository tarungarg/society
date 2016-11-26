$(document).ajaxSend(function(event, request, settings) {
  showSpinner();
});

$(document).ajaxComplete(function(event, request, settings) {
  hideSpinner();
});

function hideSpinner(){
  $("#spinner-cont").addClass('not-display');
}

function showSpinner(){
  $("#spinner-cont").removeClass('not-display');
}
