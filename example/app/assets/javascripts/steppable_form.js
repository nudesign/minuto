(function($, window){

  $.fn.steppable_form = function(options) {
    if (this.length > 1){
      this.each(function(){
        $(this).steppable_form();
      });
    }

    var timeout;
    var $container = $(this);

    var prepareToSubmit = function() {
      clearTimeout(timeout);
      timeout = setTimeout(submitForm, 500);
    }

    var secondStepConfig = function(data){
      var step_link = $container.find('.actions a.step');

      if (step_link.exists()) {
        var step_href = step_link.attr('href'),
            slash     = step_href.lastIndexOf('/') + 1,
            step_path = step_href.substring(0, slash) + data._id;

        step_link.attr('href', step_path);
        step_link.fadeIn();
      }
    }

    var attachmentUploaderConfig = function(data){
      var attachment = $('.attachmentUploader');
      attachment.attr('data-id', data._id);
    }

    var formConfig = function(data) {
      var action  = $container.attr('action'),
          id      = data._id,
          slug    = data._slugs[0],
          path    = action + '/' + id;

      if (!$container.find('input[name="_method"]').exists()) {
        if (action.indexOf(id) == -1 && action.indexOf(slug) == -1){
          var input_hidden = $('<input>',
            {name: '_method', type: 'hidden', value: 'put'}
          )

          $container.attr('action', path);
          $container.prepend(input_hidden);
        }
      }
    }

    var submitForm = function() {
      var action  = $container.attr('action'),
          method  = $container.attr('method');

      $.ajax({
        url:      action,
        data:     $container.serialize(),
        type:     method,
        dataType: 'json',

        success: function(data){
          attachmentUploaderConfig(data);
          formConfig(data);
          secondStepConfig(data);
        }
      });
    }

    $(this).find('input[type="text"], textarea').not('.attachmentVideoUploaderField').on('keypress', prepareToSubmit);
    $(this).find('input[type="text"], textarea').not('.attachmentVideoUploaderField').on('click', prepareToSubmit);
    $(this).find('input[type="checkbox"], input[type="radio"]').on('click', submitForm);

    return this;
  }
})(jQuery, window)
