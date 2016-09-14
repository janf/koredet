# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

	
jQuery ->
$("form").bind("keypress", function (e) {
	alert('Pressed key')
    if (e.keyCode == 13) {
        $("#btnSearch").attr('value');
        //add more buttons here
        return false;
    }
});
