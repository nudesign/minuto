App.helpers = {
  
   adjustImagesToGallery: function (img, gallery_window) {
         var gW = $(gallery_window).outerWidth(true),
             gH = $(gallery_window).outerHeight(true),
             gRatio = gW / gH;
         img.each(function () {
           
            var json = $(this).parent().data("gallery"),
                iW = json.large_width,
                iH = json.large_height,
                iRatio = iW / iH,
                wRatio,
                nW,
                nH,
                left = 0,
                top = 0;                
            if (iW == 0 || iH == 0) return;
            if (gRatio > iRatio) {
              nH = gH;
              nW = Math.round(nH * iRatio);
            }
            else {
              nW = gW;
              nH = Math.round(nW / iRatio);
            }
            if (nW < gW ) {
              left = Math.floor( (gW - nW) / 2);
            }
            if (nH < gH) {
              top = Math.floor( (gH - nH) / 2);
            }
            $(this).css({'width': nW, 'height': nH, 'left': left, 'top': top, 'position': 'absolute'});
            $(this).parent().data("css", { width: nW + "px", height: nH + "px", left: left + "px", top: top + "px" });   
         });
    },
    
  preLoadImages: function (img) {
      $(img).each(function () {
        var json = $(this).data("gallery"),
            src = json.large_src,
            image = new Image(),
            self = this;
        image.src = src;
        image.onload = function () {
          var css = $(self).data("css");
          image.style.left = css.left;
          image.style.top = css.top;
          image.style.height = css.height;
          image.style.width = css.width;
          image.style.position = "absolute";
          image.style.zIndex = $(self).children("img").css("z-index");
          $(self).children("img").replaceWith(image);
        }
      });
    },

    bindUpdatePreview: function (item_height) {
      var preview = $(".creator-preview"),
          nickname = $(".creator-preview .profile-name"),
          location = $(".creator-preview .profile-location"),
          occupation = $(".creator-preview .profile-occupation"),
          release = $(".creator-preview .creator-release .creator-release-text"),
          avatar = $(".creator-preview .profile-avatar");
      $(".creators-list").on("mouseover.update-preview", function (e) {
          var selector = $(e.target).parents(".creators-list-item"),
              element = selector.data("preview");
          if (selector.hasClass("creators-list-item")) {
            nickname.html(element.name);
            location.html(element.location);
            occupation.html(element.occupation);
            release.html(element.release);
            if (element.avatar == undefined) { avatar.attr("src", "/assets/avatar.jpg"); }
            else { avatar.attr("src", element.avatar); }
            if (item_height) { preview.css({"top": selector.position().top + item_height}); }
          }
      });
  },

  setSortable: function () {
    var creators_lst = $(".creators-list"),
        preview = $(".creator-preview");
    $('#list-sortable').sortable({

      items: '> li.sortable',

      start: function () {
        $(this).removeClass("opa-effect-container");
        preview.removeClass("is-on");
      },

      update: function(event, ui) {
        var resource_class = $(this).data('resource_class');
        var resources_ids  = [];

        $('.sortable').each(function(index) {
          resources_ids.push($(this).data('id'));
        });

        $.ajax({
           url: '/sortable/update_order',
           type: 'PUT',
           data: {resources_ids: resources_ids, resource_class: resource_class}
        }); 
      },

      stop: function() {
        $(this).addClass("opa-effect-container");
        preview.addClass("is-on");
      },

    }).disableSelection();
  },

};
