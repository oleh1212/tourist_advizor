
$(document).ready(function(){
	let spead = 200;
	$("#nextButton1").click(function(){
		$("#first").hide(spead);
		$("#second").show(spead);
	});
	$("#nextButton2").click(function(){
		$("#second").hide(spead);
		$("#third").show(spead);
	});
	$("#nextButton3").click(function(){
		$("#third").hide(spead);
		$("#forth").show(spead);
	});
	$("#previousButton1").click(function(){
		$("#second").hide(spead);
		$("#first").show(spead);
	});
	$("#previousButton2").click(function(){
		$("#third").hide(spead);
		$("#second").show(spead);
	});
	$("#previousButton3").click(function(){
		$("#forth").hide(spead);
		$("#third").show(spead);
	});

});