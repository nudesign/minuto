var content = $("#paginate"),
    creator_html = ("<%= j render partial: 'creators/creators_list', collection: @creators, as: :creator %>");
content.replaceWith(creator_html);
$(".creators-list-item:last").after('<%= j link_to_next_page @creators, "", :id => "paginate" %>');
App.home.homeRiver.init();