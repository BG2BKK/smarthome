
$(document).ready(function(){

$("#led_close").bind("click", function(event) { 
	$("#led_status").html("关闭"); 
});

$("#led_open").bind("click", function(event) { 
	$("#led_status").html("打开"); 
});

$("#led_open").bind("click", function(event) { 
	$("#led_status").html("打开"); 
});

 	$("#btn_tellme").click(function() {
 		smarthome.tellme();
 	});


});
