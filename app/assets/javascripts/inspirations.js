App.inspirations = {
  index: function () {
    this.show();
  },
  show: function () {
    var helpers = App.helpers,
      gallery = $(".gallery-list");
    helpers.adjustImagesToGallery($(".gallery-item img"), $(".gallery-list"));
    $(".gallery-list").gallerize({items: "li.gallery-item"});

    $(window).load(function () {
      gallery.css("left", "0px");
      $(".loading").hide();
      helpers.preLoadImages($(".gallery-item"));
      $("li.left-arrow").click(function () {
        gallery.gallerize("moveLeft");
      });
      $("li.right-arrow").click(function () {
        gallery.gallerize("moveRight");
      });
    });

  }
}