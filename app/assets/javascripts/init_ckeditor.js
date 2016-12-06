function intiCkeditor() {
  $('.ckeditor').each(function() {;
    CKEDITOR.replace($(this).attr('id'));
  })
};

$(document).ready(function(){
  intiCkeditor();
});

$(document).on('ready page:load', function() {
  intiCkeditor();
});


document.addEventListener("turbolinks:load", function() {
  intiCkeditor();
})
