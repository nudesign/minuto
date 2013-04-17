// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
App.home = {};

App.home.index = function () {
  var that = this,
  	  helpers = App.helpers,
  	  ITEM_HEIGHT = 352;

	$(window).load(function () {
		App.home.homeRiver.init();
		$(".arrow").click(function (e){
			var $e = $(e.target),
			    url =  $("#paginate").attr('href');
			that.paginate = $("#paginate");
			if ($e.hasClass("left-arrow")) {
				index = App.home.homeRiver.moveToLeft("l");
			}
			else if ($e.hasClass("right-arrow")) {
				index = App.home.homeRiver.moveToLeft("r");
			}
			if (that.paginate.length < 1) {
        return false;
      }
			if (that.last_url !== url) {
			  that.paginate.text("loading...");
        that.last_url = url;
        $.getScript(url);
        document_height = $(document).height();
			}
		});
	});
	helpers.bindUpdatePreview();
};

App.home.homeRiver = ({
		init: function () {
			this.right_arrow = $(".home-river.right-arrow");
			this.left_arrow = $(".home-river.left-arrow");
			this.gallery_list = $(".gallery-list");
			this.gallery_list_items = $(".gallery-list-item");
			this.river_lefts = [];
      		this.curr_index = 0;
      		this.creator_preview = $(".creator-preview");

			$("ul.gallery-list").css("width", this.calcRiverWidth());
			this.setRiverLefts();
			this.left_arrow.hide();
		},
		calcRiverWidth: function () {
			var width = 0;
			this.gallery_list_items.each(function () {
				width += $(this).outerWidth(true);
			});
			return width;
		},
		setRiverLefts: function () {
			var container_width = $(".river-window").width(),
				items_width = this.gallery_list_items.filter(":first").outerWidth(true),
				numb_visbl_ele = Math.ceil(container_width / items_width),
				numb_ele = this.gallery_list_items.length,
				numb_pages = Math.ceil(numb_ele / numb_visbl_ele);
				sum = 0,
				that = this,
				i;
			for(i = 0; i < numb_pages; i++) {
				if (i==0)  {
					that.river_lefts[i] = 0;
				}
				else {
					sum -= items_width * numb_visbl_ele;
					that.river_lefts[i] = sum;
				}
			};
			this.river_lefts_length = this.river_lefts.length;
		},
		moveToLeft: function (direction) {
			var that = this;
			if (direction == "r" ) {
			  ++this.curr_index;
			}
			else {
			  --this.curr_index;
			}
			if (this.curr_index <= 0) {
				this.curr_index = 0;
				this.left_arrow.hide();
			}
			else {
				this.left_arrow.show();
			}
			if (this.curr_index >= this.river_lefts_length - 1) {
				this.curr_index = this.river_lefts_length - 1;
				this.right_arrow.hide();
			}
			else {
				this.right_arrow.show();
			}
			this.gallery_list.stop(true).animate({"margin-left": that.river_lefts[that.curr_index] + "px"}, 1000);
		}
});
