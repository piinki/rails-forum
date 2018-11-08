$(document).ready(function() {
  $('.autohide').delay(5000).slideUp('slow');
  $(document).on('change', '.check-box', function (){
    this.form.submit();
  });

  $('blockquote').addClass('topic topic--answer');

  $(document).on('click','.prevent-load', function(event) {
    event.preventDefault();
  });

  $(document).on('click', '.quote-post', function (){
    let content = $('#'+$(this).data('post-id')).html();
    debugger
    CKEDITOR.instances.reply_form.insertHtml('<blockquote>' + content +'</blockquote>');
  });
});
