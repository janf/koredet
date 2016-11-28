glyph_opts = {
	map: {
	  doc: "glyphicon glyphicon-file",
	  docOpen: "glyphicon glyphicon-file",
	  checkbox: "glyphicon glyphicon-unchecked",
	  checkboxSelected: "glyphicon glyphicon-check",
	  checkboxUnknown: "glyphicon glyphicon-share",
	  dragHelper: "glyphicon glyphicon-play",
	  dropMarker: "glyphicon glyphicon-arrow-right",
	  error: "glyphicon glyphicon-warning-sign",
	  expanderClosed: "glyphicon glyphicon-menu-right",
	  expanderLazy: "glyphicon glyphicon-menu-right",  // glyphicon-plus-sign
	  expanderOpen: "glyphicon glyphicon-menu-down",  // glyphicon-collapse-down
	  folder: "glyphicon glyphicon-folder-close",
	  folderOpen: "glyphicon glyphicon-folder-open",
	  loading: "glyphicon glyphicon-refresh glyphicon-spin"
	}
};

jQuery.fn.removeOnClick = function () {
	$(this).click(function(e){
		e.preventDefault();
		$('#new_location').remove();
		$(".location_edit_form").remove();
		//$('#new_link').show();
		//alert("RemoveOnClick")
	});
	//alert("Will remove");
	return this;
};

function showLocationData(node) {
	//alert("custom node data: " + JSON.stringify(node.data));
	$.ajax({url: '/locations/'+ node.key, format: "js", dataType: "script"});
}


(function() {

  	$(document).on('turbolinks:load', function() {
	
	    $("#fancytree-container").fancytree({
			extensions: ["dnd", "edit", "glyph", "wide", "childcounter", "filter"],
			//checkbox: true,
		    dnd: {
		    	autoExpandMS: 400,
        		focusOnClick: true,
        		preventVoidMoves: true, // Prevent dropping nodes 'before self', etc.
        		preventRecursiveMoves: true, // Prevent dropping nodes on own descendants
   
			    dragStart: function(node, data) { return true; },
			    dragEnter: function(node, data) { return true; },
			    dragDrop: function(node, data) { data.otherNode.moveTo(node, data.hitMode); }
		    },
		    glyph: glyph_opts,
		    selectMode: 2,
	    	source: { 
	            url: '/locations/location_tree.json'
	        },
            toggleEffect: { effect: "drop", options: {direction: "left"}, duration: 400 },
	    	//wide: {
	        // 	iconconWidth: "1em",     // Adjust this if @fancy-icon-width != "16px"
	        // 	iconSpacing: "0.5em", // Adjust this if @fancy-icon-spacing != "3px"
	        // 	levelOfs: "1.5em"     // Adjust this if ul padding != "16px"
       		//},
      		icon: function(event, data){
        		if( data.node.data.location_type == "Flow" ) {
        		  return "glyphicon glyphicon-transfer";
        		}
        		if( data.node.data.root == "R" ) {
        		  return "glyphicon glyphicon-home";
        		}
        		if( data.node.hasChildren() ) {
        		  return "glyphicon glyphicon-th";
        		}
        		if( data.node.key == "8" ) {
        		  return "glyphicon glyphicon-briefcase";
        		}
        		return "glyphicon glyphicon-th-large";
      		},
      	    childcounter: {
		        deep: true,
		        hideZeros: false,
		        hideExpanded: true
      		},
      	    filter: {
		        autoApply: true,   // Re-apply last filter if lazy data is loaded
		        autoExpand: false, // Expand all branches that contain matches while filtered
		        counter: true,     // Show a badge with number of matching child nodes near parent icons
		        fuzzy: false,      // Match single characters in order, e.g. 'fb' will match 'FooBar'
		        hideExpandedCounter: true,  // Hide counter badge if parent is expanded
		        hideExpanders: false,       // Hide expanders if all child nodes are hidden by filter
		        highlight: true,   // Highlight matches by wrapping inside <mark> tags
		        leavesOnly: false, // Match end nodes only
		        nodata: true,      // Display a 'no data' status node if result is empty
		        mode: "dimm"       // Grayout unmatched nodes (pass "hide" to remove unmatched node instead)
		    },
            loadChildren: function(event, data) {
        		// update node and parent counters after lazy loading
        		data.node.updateCounters();
      		},
      		// Node events
      		activate: function(event, data) {
      			
		        var node = data.node;
		        // acces node attributes
		        $("#location_name").val(node.title);
		        $("#location_type").val(node.data.location_type);
		        //alert("node type: " + node.data)
		        if( !$.isEmptyObject(node.data) ){
					//alert("custom node data: " + JSON.stringify(node.data));
					showLocationData(node);
		       	}	
		    }
		
	    });


        $("#fancytree-container").contextmenu({
	      delegate: "span.fancytree-title",
			//      menu: "#options",
	      menu: [
	          {title: "Add child", cmd: "add_child", uiIcon: "ui-icon-scissors", disabled: false},
	          {title: "Edit", cmd: "edit", uiIcon: "ui-icon-pencil", disabled: false },
	          {title: "Delete", cmd: "delete", uiIcon: "ui-icon-trash", disabled: false }, 
	          {title: "More", children: [
            		{title: "Do transactions", cmd: "trans"}
            	]}
	          ],
	      beforeOpen: function(event, ui) {
	        var node = $.ui.fancytree.getNode(ui.target);
	        // Modify menu entries depending on node status
	        $("#fancytree-container").contextmenu("enableEntry", "paste", node.isFolder());
	        //alert("ID: " + $(".ui-contextmenu").first().attr("id"));
	        $(".ui-contextmenu").first().css('z-index', 2);
	        // Show/hide single entries
	//            $("#tree").contextmenu("showEntry", "cut", false);

	        // Activate node on right-click
	        node.setActive();
	      },
	      select: function(event, ui) {
	        var node = $.ui.fancytree.getNode(ui.target);
	        //alert("select " + ui.cmd + " on " + node);
	        
	        if(ui.cmd == "add_child") {
		        var params = 'parent_id='+ node.key
		        //alert(params)
	    		$.ajax({url: '/locations/new?'+params, dataType: "script"});
	    	};

	    	if(ui.cmd == "edit") {
		        //var params = 'parent_id='+ node.key
	    		$.ajax({url: '/locations/'+ node.key +"/edit", dataType: "script"});
	    	};
	    	
	    	if(ui.cmd == "delete") {
		        var params = 'id='+ node.key
		        //alert("Deleting")
		        if(node.hasChildren()) {
		        	alert("Cannot delete node with children");
		        	return false;
		        };
		        if( confirm("Are you sure you want to delete " + node.title + "?") ) {
		      		$.ajax({url: '/locations/'+ node.key, type: 'DELETE', dataType: "script" });  	
		      		node.remove();
		        }

	    		//$.ajax({url: '/locations/delete'+params, dataType: "script"});

	    	};
	      }
    	});

          var tree = $("#tree").fancytree("getTree");

    /*
     * Event handlers for our little demo interface
     */
	    $("#search-field").keyup(function(e){
	    	var n,
	    	tree = $.ui.fancytree.getTree(),
		    args = "autoApply autoExpand fuzzy hideExpanders highlight leavesOnly nodata".split(" "),
		    opts = {},
		    filterFunc = $("#branchMode").is(":checked") ? tree.filterBranches : tree.filterNodes,
		    match = $(this).val();

		    //$.each(args, function(i, o) {
		    //	opts[o] = $("#" + o).is(":checked");
		    //});
		    // opts.mode = $("#hideMode").is(":checked") ? "hide" : "dimm";

	      	if(e && e.which === $.ui.keyCode.ESCAPE || $.trim(match) === ""){
	        	$("button#btnResetSearch").click();
	        	return;
	      	}

	      	//if($("#regex").is(":checked")) {
		    //    // Pass function to perform match
		    //    n = filterFunc.call(tree, function(node) {
		    //      return new RegExp(match, "i").test(node.title);
		    //   	}, opts);
	      	//} else {
		    //    // Pass a string to perform case insensitive matching
		    //    n = filterFunc.call(tree, match, opts);
		    //}
		    $("#btnResetSearch").attr("disabled", false);
	    }).focus();

	    $("button#btnResetSearch").click(function(e){
	      $("input[name=search]").val("");
	      $("span#matches").text("");
	      tree.clearFilter();
	    }).attr("disabled", true);

	    
      	$("#expand_tree").click(function(e){
			
			if( $(this).text() != "Collapse" ) {
				$("#fancytree-container").fancytree("getRootNode").visit(function(node){
	        		node.setExpanded(true);
	      		});
				$(this).text("Collapse")
			} else {
				$("#fancytree-container").fancytree("getRootNode").visit(function(node){
	        		node.setExpanded(false);
	      		});
				$(this).text("Expand")
			}
			e.preventDefault();
		});

	});

	
	$("#node_edit_back").click(function(e){
		e.preventDefault();
		$('#new_location').remove();
		$('#new_link').show();
		//alert("Removed data and form")
	});

	


}).call(this);
