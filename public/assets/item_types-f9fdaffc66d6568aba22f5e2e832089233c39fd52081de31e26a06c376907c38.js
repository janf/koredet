(function() {
  $(document).on('click', 'form .remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('true');
    $(this).closest('fieldset').hide();
    return event.preventDefault();
  });

  $(document).on('click', 'form .add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    $(this).prev('fieldset').children().first().focus();
    return event.preventDefault();
  });

}).call(this);
