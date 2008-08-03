// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function star (item_id, user_id, is_starred) {
	if(is_starred) {
		var url = "/stars/destroy"; 
		var jsOptions = "false";
	} else {
		var url = "/stars/new"
		var jsOptions = "true";
	}                          
	
	// Send the data to the server
	
	$.post(url, {item_id: item_id, user_id: user_id}, function(data) {
		$("#item_" + item_id + "-star-count").html(data);
		$("#item_wrapper_for_" + item_id + " .star a").toggleClass("starred"); 
		$("#item_wrapper_for_" + item_id + " .star a").attr("onClick", "star(" + item_id + ", "+ user_id +", " + jsOptions +")");
	}, "text");
	
	
	
}
