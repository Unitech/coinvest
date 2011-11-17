$(document).ready(function(){
    $("ul.topnav li").hover(function() { //When trigger is clicked...
	$(this).find("ul.subnav").show(); //Drop down the subnav on click
    },  function() {
	$(this).find("ul.subnav").hide();
    });
});

