(function() {
  $(document).on('turbolinks:load', function() {
    return $(".user_data_fields").find(":text").css("border", "none");
  });

  $(document).on('click', 'form .update_user_profile', function(event) {
    var btn_value;
    btn_value = $(update_user).val();
    if (btn_value === "Edit user info") {
      $(update_user).prop("value", "Update user info");
      $(".user_data_fields").find(":text").css("border", "");
      return event.preventDefault();
    } else {
      $(update_user).prop("value", "Edit user info");
      return $(".user_data_fields").find(":text").css("border", "none");
    }
  });

}).call(this);
