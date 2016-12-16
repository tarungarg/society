function intiCkeditor() {
  $('.ckeditor').each(function() {;
    CKEDITOR.replace($(this).attr('id'));
  })
};

document.addEventListener("turbolinks:load", function() {
  intiCkeditor();
})
