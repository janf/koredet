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
    speech_field = "<input type='text'  id='itemsinput' value='...' class='speechInput' autofocus='autofocus' size='60' placeholder='Start speech input' >";
    if (a.length === 0) {
      me.after(speech_field);
    }
    a = me.nextAll(".speechInput");
    sayhello(a);
    startspeech("nb-NO", a, a);
    a.focus();
    return event.preventDefault();
  });

}).call(this);
