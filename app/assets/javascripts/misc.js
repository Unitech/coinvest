var rdy;
rdy = 1;

function set_auto_text(el, str_cmt)
{
    el.val(str_cmt);
    el.focus(function(){
        if(this.value == str_cmt) {
            this.value = '';
        }
    });
    el.blur(function(){
        if (this.value == '') {
            this.value = str_cmt;
        }
    });
}

function notify(str, time){
    if (rdy == 1){
	rdy = 0;
	time = typeof(time) != 'undefined' ? time : 2200;
	var note = $('#notificator');
	note.html(str);
	note.slideDown().delay(time).slideUp(function(){rdy=1});
    }
    return false;
}

