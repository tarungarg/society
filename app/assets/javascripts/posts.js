$(document).ready(function(){
  viewUploadImage("desktop_image_preview", "post_attachment");
});

$(document).on('ready page:load', function() {
  viewUploadImage("desktop_image_preview", "post_attachment");
});


document.addEventListener("turbolinks:load", function() {
  viewUploadImage("desktop_image_preview", "post_attachment");
})

function viewUploadImage(viewClass, fileId){
  var preview = $("."+viewClass);

  $("#"+fileId).change(function(event){
    $('.preview-image').removeClass('hide');
    $('.preview-image').addClass('show');
    var input = $(event.currentTarget);
    var file = input[0].files[0];
    var reader = new FileReader();
    reader.onload = function(e){
       image_base64 = e.target.result;
       preview.attr("src", image_base64);
    };
    reader.readAsDataURL(file);
  });
}
