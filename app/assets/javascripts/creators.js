App.creators = {
  index: function() {
    var ITEM_HEIGHT = 352,
        helpers = App.helpers;
    helpers.bindUpdatePreview(ITEM_HEIGHT);
    var window_height = $(window).height(),
        document_height = $(document).height(),
        offset = 50,
        that = this;
    $(window).scroll(function () {
      that.paginate = $("#paginate");
      var url = $("#paginate").attr('href');

      if (that.paginate.length < 1) {
        return false;
      }
      if ($(this).scrollTop() >= document_height - window_height - offset && that.last_url !== url ) {
        that.paginate.text("loading...");
        that.last_url = url;
        $.getScript(url);
        document_height = $(document).height();
      }

    });
    $("#category-filter").click(function (e) {
      if ($(e.target).is("a")) {
        return;
      }
      $(".dropdown-menu").toggle();
    });

    helpers.setSortable();
  },
  show: function () {
    var helpers = App.helpers,
        galleries_list_item = $(".galleries-list-item"),
        gallery_wrapper = $(".gallery-list-wrapper"),
        active_item = galleries_list_item.filter(function(){
          return galleries_list_item.hasClass("active") == true;
        });
    addthis_share.url = window.location;
    addthis.toolbox(".addthis_toolbox");
    $(".galleries-list").click(function (e) {
      var $li = $(e.target).parents("li"),
          url = $li.data("gallery_src"),
          gallery_id = $li.data("id"),
          already_exist,
      already_exist = gallery_wrapper.find(".gallery-list").filter(function(){
        return $(this).attr("id") == gallery_id;
      });
      galleries_list_item.removeClass("active");
      $li.addClass("active");
      if (already_exist.length >= 1) { //check if gallery already exists
        $(".gallery-list").removeClass("is-block").addClass("is-none");
        already_exist.removeClass("is-none").addClass("is-block");
      }
      else {
        App.creators.show["gallery_id"] = $li.data("id");
        $.getScript(url + ".js");
      }
    });

    $(window).load(function () {
      helpers.adjustImagesToGallery($(".gallery-item img"), $(".gallery-list"));
      $(".loading").hide();
      helpers.preLoadImages($(".gallery-item"));
    });

    $(".gallery-list").gallerize({items: "li.gallery-item"});
  }
};