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
    let author = $(this).data('name');
    let anchor = $(this).data('anchor');
    CKEDITOR.instances.reply_form.insertHtml('\
      <blockquote>\
        <p class="blockquotefrom">[Quote from <a href="#post-bookmark-' + anchor +'"> #'+ anchor +'</a>] writed by ' + author + '</p>' + content +'</blockquote>&nbsp;');
  });
});
