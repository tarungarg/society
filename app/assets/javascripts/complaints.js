function updateComplaintStatus(){
  $('.resolve-complaint-btn').bind('ajax:complete', function() {
    if ($(this).text()  == 'Open'){
      $(this).text('Mark As Resolve');
      $(this).attr('href', 
                    Routes.mark_as_resolve_complaint_path(
                      $('#complaint_id').val()
                    )
                  );
    } else {
      $(this).text('Open');
      $(this).attr('href', 
                    Routes.mark_as_unresolve_complaint_path(
                      $('#complaint_id').val()
                    )
                  );
    }
  });
}

document.addEventListener("turbolinks:load", function() {
  updateComplaintStatus();
    $('.check:button').toggle(function(){
      $('input:checkbox').attr('checked','checked');
      $(this).val('uncheck all')
  },function(){
      $('input:checkbox').removeAttr('checked');
      $(this).val('check all');        
  })
})
