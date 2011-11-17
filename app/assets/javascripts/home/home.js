
$(document).ready(function() {
    $('.project-min').each(function() {
	var self = $(this);
	self.click(function() {
	    window.location = self.attr('url');
	});
	self.hover(function() {
	    self.find('.image').hide();
	    self.find('.text-i').show();
	}, function() {
	    self.find('.image').show();
	    self.find('.text-i').hide();
	});
    });
    
});