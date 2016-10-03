

$(document).on 'click', 'form .one_plus', (event) ->
	fld_qty = $(this).prev().prevAll(".qty")
	qtytxt = fld_qty.attr("value") 
	qtytxt = "1" if not qtytxt?
	qtytxt = "1" if qtytxt == "NaN"
	qtytxt = "1" if qtytxt == "" 
	qty = parseInt(qtytxt)
	qty = qty + 1
	fld_qty.attr({"value": qty.toString()})
	event.preventDefault()  


$(document).on 'click', 'form .one_minus', (event) ->
	fld_qty = $(this).prev().prevAll(".qty")
	qtytxt = fld_qty.attr("value") 
	qtytxt = "1" if qtytxt == "NaN"
	qty = parseInt(qtytxt)
	qty = Math.max(qty-1, 0)
	fld_qty.attr({"value": qty.toString()})
	event.preventDefault()  


$(document).on 'click', 'form .speech_input_btn', (event) ->
    # Create input field
    me = $(".speech_input_btn")
   	a = me.nextAll(".speechInput")
   	speech_field = "<input type='text'  id='itemsinput' value='...' class='speechInput' autofocus='autofocus' size='60' placeholder='Start speech input' >"
    me.after(speech_field) if a.length == 0
    a = me.nextAll(".speechInput")
    sayhello(a)
    startspeech("nb-NO",a,a)
    a.focus()
    event.preventDefault()     	




	
  