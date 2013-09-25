function displayMessage(msg, id, time, type) {
  if (time==null) time = 8000; 
  if (type==null) type = "error"; 
  if ($('#'+id).size()==0) {
      var div = $('<div class="alert alert-'+type+' hide" id="'+id+'">'+msg+'</div>');
      $('section.container').prepend(div);
      div.fadeIn().delay(time).fadeOut();
      setTimeout(function(){ div.remove(); }, time+500);
    }
}

function showMessage(message_content) {
  displayMessage(message_content, "showMessage", "warning");
  $(document).scrollTop();
}