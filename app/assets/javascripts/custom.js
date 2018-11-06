$(document).ready(function() {
  $('.autohide').delay(5000).slideUp('slow');
  $(document).on('change', '.check-box', function (){
    this.form.submit();
  });
});
