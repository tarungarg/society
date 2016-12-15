$(document).ready(function() {
   $('.checkbox-task').change(function() {
      var id = $(this).attr('data-id');
      var value = false;
      $(this).next().removeClass('completed');
      if($(this).is(":checked")) { 
        $(this).next().addClass('completed')
        value = true 
      }
      $.ajax({
        type : 'PUT',
        dataType: 'script',
        url : Routes.change_status_task_path(id, {value: value})
      });
    });
})
