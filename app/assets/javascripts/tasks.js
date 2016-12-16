document.addEventListener("turbolinks:load", function() {
  changeState();
})

function changeState(){
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
}

function showTask(task_id) {
  $('#task_modal').modal();
  $.ajax({
    type : 'GET',
    dataType: 'script',
    url : Routes.task_path(task_id)
  });
}
