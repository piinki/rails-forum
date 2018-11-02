$(document).ready(function(){
  $('.dropdown-btn--open').on('click', function(){
    $(this).siblings('.dropdown').toggle();
  })
});
