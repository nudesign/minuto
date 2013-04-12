// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree ../../../vendor/assets/javascripts
//= require_self
//= require_tree .

App = {};

$(document).ready(function(){
  $(".attachmentUploader").pluploadIt();

  $(".creator.steppable_form").steppable_form({
    priority_field: 'creator_name',
    parent_class: '.field'
  });

  $(".gallery.steppable_form").steppable_form({
    priority_field: 'gallery_title',
    parent_class: '.field'
  });
});

