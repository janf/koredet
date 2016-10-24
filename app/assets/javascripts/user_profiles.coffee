# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load' , ->
  	$(edit_user_1).find(":text").css("border", "none")
	#alert("page loaded")

	
$(document).on 'click', 'form .update_user_profile', (event) ->
	#alert("Clicked button")
	btn_value  = $(update_user).val()
	if btn_value == "Edit user info"
		$(update_user).prop("value", "Update user info")
		$(edit_user_1).find(":text").css("border", "")
		event.preventDefault()
	else 
		$(update_user).prop("value", "Edit user info")
		$(edit_user_1).find(":text").css("border", "none")
		