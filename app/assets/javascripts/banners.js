document.addEventListener("turbolinks:load", function() {
  viewUploadImage("desktop_image_preview", "banner_desktop_image");
  viewUploadImage("mobile_image_preview", "banner_mobile_image");
})

function viewUploadImage(viewClass, fileId){
  var preview = $("."+viewClass);

  $("#"+fileId).change(function(event){
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
