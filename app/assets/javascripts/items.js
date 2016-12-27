
jQuery.fn.removeItemOnClick = function () {
	$(this).click(function(e){
		//alert("Click")
		e.preventDefault();
		$(".item_edit_form").remove();
		$('.fixed-table-toolbar').show();
	});
	return this;
};


(function() {
  	//alert("Loading items page");

  	$(document).on('turbolinks:load', function() {
  		$("#items_datatable").bootstrapTable();

	  	$('#btn-add-item').click( function(event) {
	   		//alert("Add item");
	   		if(  $('#new_item').length == 0 ) {
	   			$.ajax({url: '/items/new', dataType: "script"});
	   		}
	    });


  	});

	$("#item_edit_back").click(function(e){
		e.preventDefault();
		//$('#new_item').remove();
	});



}).call(this);