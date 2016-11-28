(function() {
  $(document).on('click', 'form .one_plus', function(event) {
    var fld_qty, qty, qtytxt;
    fld_qty = $(this).prev().prevAll(".qty");
    qtytxt = fld_qty.attr("value");
    if (qtytxt == null) {
      qtytxt = "1";
    }
    if (qtytxt === "NaN") {
      qtytxt = "1";
    }
    if (qtytxt === "") {
      qtytxt = "1";
    }
    qty = parseInt(qtytxt);
    qty = qty + 1;
    fld_qty.attr({
      "value": qty.toString()
    });
    return event.preventDefault();
  });

  $(document).on('click', 'form .one_minus', function(event) {
    var fld_qty, qty, qtytxt;
    fld_qty = $(this).prev().prevAll(".qty");
    qtytxt = fld_qty.attr("value");
    if (qtytxt === "NaN") {
      qtytxt = "1";
    }
    qty = parseInt(qtytxt);
    qty = Math.max(qty - 1, 0);
    fld_qty.attr({
      "value": qty.toString()
    });
    return event.preventDefault();
  });

  $(document).on('click', 'form .speech_input_btn', function(event) {
    var a, me, speech_field;
    me = $(".speech_input_btn");
    a = me.nextAll(".speechInput");
    speech_field = "<input type='text'  id='itemsinput' onfocus='blur();' value='...' class='speechInput' autofocus='autofocus' size='60' placeholder='Start speech input' >";
    if (a.length === 0) {
      me.after(speech_field);
    }
    a = me.nextAll(".speechInput");
    startspeech("nb-NO", a, a);
    a.focus();
    return event.preventDefault();
  });

  $(document).on('new-text-available', '', function(event) {
    var a, fs, item_fld, item_name, regexp, time;
    a = $("#itemsinput");
    item_name = a.val();
    item_name = item_name.trim();
    item_name = item_name.charAt(0).toUpperCase() + item_name.slice(1);
    a.val(item_name);
    if (item_name === "Remove") {
      fs = $(".speech").nextAll("fieldset").first();
      fs.remove();
    } else {
      time = new Date().getTime();
      regexp = new RegExp($(".add_fields").data('id'), 'g');
      $(".speech").after($(".add_fields").data('fields').replace(regexp, time));
      fs = $(".speech").nextAll("fieldset").first();
      item_fld = fs.children().first();
      item_fld.val(item_name);
    }
    return event.preventDefault();
  });

}).call(this);
