var ready;

ready = function() {
  $('.ckeditor').each(function() {;
    return CKEDITOR.replace($(this).attr('id'));
  })
};

$(document).ready(ready);
$(document).on('page:load', ready);
