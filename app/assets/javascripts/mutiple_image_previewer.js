// <article>
//     <label for="files">Select multiple files: </label>
//     <input id="files" type="file" multiple/>
//     <output id="result" />
// </article>
document.addEventListener("turbolinks:load", function() {
        
    //Check File API support
    if(window.File && window.FileList && window.FileReader && document.getElementById("files"))
    {
        var filesInput = document.getElementById("files");
        
        filesInput.addEventListener("change", function(event){
            
            var files = event.target.files; //FileList object
            var output = document.getElementById("result");
            
            for(var i = 0; i< files.length; i++)
            {
                var file = files[i];
                
                //Only pics
                if(!file.type.match('image'))
                  continue;
                
                var picReader = new FileReader();
                
                picReader.addEventListener("load",function(event){
                    
                    var picFile = event.target;
                    
                    var div = document.createElement("span");
                    
                    div.innerHTML = "<img class='thumbnail-custom' src='" + picFile.result + "'" +
                            "title='" + picFile.name + "'/>";
                    
                    output.insertBefore(div,null);            
                
                });
                
                 //Read the image
                picReader.readAsDataURL(file);
            }                               
           
        });
    }
})
