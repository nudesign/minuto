(function($) {
  var data_pages  = $('#master-menu').attr('data-pages'),
      split_names = data_pages.split(",");

  if(data_pages) {
    $('a[href*="'+split_names[0]+'"]').addClass('active');
  }

})(jQuery);