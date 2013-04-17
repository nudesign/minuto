(function ($, window){

  // Menu
  var data_pages  = $('#master-menu').attr('data-pages'),
      split_names = data_pages.split(",");

  if(data_pages) {
    $('a[href*="'+split_names[0]+'"]').addClass('active');
  }

  // Gallery equals home page
    var gallery = $(".gallery-list"),
        cases = $(".case-images-river"),
        cases_children,
        new_cases_width = 0;
    if (gallery.length > 0 ) {
            $(".gallery-list").gallerize({items: "li.gallery-item", paginator: false});
            $("li.left-arrow").click(function () {
              gallery.gallerize("moveLeft");
            });
            $("li.right-arrow").click(function () {
              gallery.gallerize("moveRight");
            });
            $(".paginator-window").click(function(e) {
              var index = parseInt($(e.target).parents("li").index(), 10);
              e.preventDefault();
              gallery.gallerize("moveToSlide", index);
              gallery.gallerize("stopSlideShow");
            });
    }
  if (cases.length > 0 ) {
    cases_children = cases.children();
    $(window).load(function() {
    cases_children.each(function() {
      new_cases_width += $(this).outerWidth(true);

    });
    cases.width(new_cases_width + "px");
    });
  }


  // Gallery equal in case page
  var _width = 0,
      _margin = 16;
  $('.case-images-river figure object').each(function( index, item ) {
    _width += Number(item.width) + _margin;
  });
  $('.case-images-river figure img').each(function( index, item ) {
    _width += Number(item.width) + _margin;
  });
  $('.case-images-river').css("width", _width+10);

})(jQuery);
