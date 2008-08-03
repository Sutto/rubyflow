var id_pattern = /item_wrapper_for_(\d+)/i;

function star(item_id, is_starred) {
	if(is_starred) {
		var url = "/items/" + item_id + "/star/remove"; 
		var jsOptions = "false";
	} else {
		var url = "/items/" + item_id + "/star/add"
		var jsOptions = "true";
	}                          
	
	// Send the data to the server
	
	$.get(url, {}, function(data) {
		$("#item_wrapper_for_" + item_id + " .star a").toggleClass("starred").html((jsOptions == "false" ? "" : "un") + "star this post");
		$("#item_" + item_id + "-star-count").html(data);
	}, "text");
	
}

function setupAdminAreaToggles() {
  $(".admin-actions").each(function(){
    var current = $(this);
    var parent  = current.parent();
    parent.mouseover(function() {
      current.show();
    });
    parent.mouseout(function() {
      current.hide();
    });
  }).hide();
}

// Someone might want to refactor / rewrite this to make it nicer.
function setupItemAjaxSubmit() {
  var posts = $(".post");
  posts.each(function() {
    var post = $(this);
    setStarFor(post);
  });
}

function setStarFor(post) {
  var match   = id_pattern.exec(post.attr("id"));
  // Check if we can extract the id.
  if(match != null) {
    var item_id   = parseInt(match[1], 10);
    var star_link = post.find(".star a");
    star_link.click(function(){
      star(item_id, !(star_link.html().match(/un/) == null));
      return false;
    });
  }
}

// Set jQuery to automatically use the correct
// accepts header so that we can use respond_to
// with js.
jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept",
    "text/javascript")} 
})  


// Make all JS behaviour unobtrusive.
$(function() {
  setupAdminAreaToggles();
  setupItemAjaxSubmit();
});