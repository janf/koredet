
(function() {
  	//alert("Loading items page");

  	$(document).on('turbolinks:load', function() {
  		$("#transaction_types_datatable").bootstrapTable();
  	});

 }).call(this);