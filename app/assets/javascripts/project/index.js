
$(document).ready(function(){

    $('.project-unity').each(function(){
	var self = $(this);
	// $(this).mouseenter(function(ev) {
	//     ev.stopPropagation();
	//     $(this).fadeIn(500).fadeOut(500).fadeIn(500);
	// });v
	$(this).find('.progressbar').progressbar({value : 59});
    });

});