var smarthome = new Object();

smarthome.tellme = function() {
	var word = $("#someword").val();
	var path = '/admin/set/' + word;
	$.get(path, function(data, status) {
		console.log(data);
		alert("说成功了");
	});
}
