type = $("#type").find(":selected").text();
if(type == "landmark"){
	type="LANDMARK_GROUP";
}else if(type == "hotel"){
	type="HOTEL_GROUP";
}


function searchlocation(location){
	var settingsForLocation = {
		"async": true,
		"crossDomain": true,
		"url": "https://hotels4.p.rapidapi.com/locations/search?query="+location,
		"method": "GET",
		"headers": {
			"x-rapidapi-host": "hotels4.p.rapidapi.com",
			"x-rapidapi-key": "c97474ed92msh1a05e14d575e6e0p10ef38jsn3116fd8707f4"
		}
	}
	return settingsForLocation;
};



function canupload(param){
	$('#info').empty();
	$("#info").removeClass();
	if(param == false){
		$("#info").addClass("alert alert-success");
        $('#info ').append("We can upload photos from other sites");
	}else{
		$("#info").addClass("alert alert-warning");
        $('#info ').append("You should upload photos");
	}

	$("#loading").removeClass();
	$("#loading").addClass("spinner-border text-white");
}
function failFunc(){
	
	$('#info').empty();
	$("#info").removeClass();
	$("#info").addClass("alert alert-warning");
	   
    $('#info ').append('We cannot connect to the rest server but you can upload your own photos <button type="button" onclick="checkGeo()" class="btn btn-primary ml-3 mr-3">Try agine</button>');
	
	$("#loading").removeClass();
	$("#loading").addClass("spinner-border text-white");
}

function checkGeo(){
	
	$("#loading").addClass("spinner-border text-primary");

	var location = $("#povName").val();
	var lat = $("#lat").val();
	var lng = $("#lng").val();
	$.ajax(searchlocation(location)).done(function (response) {
		canupload(response.misspellingfallback);

		$(response.suggestions).each(function(index,suggest){
			if(type== "LANDMARK_GROUP" || type== "HOTEL_GROUP"){
				if(suggest.group == type && suggest.entities.length!=0){
					if(lat==0 && lng==0){
						if( type== "HOTEL_GROUP"){
						}
							$("#restApiHotelId").val(suggest.entities[0].destinationId);
							$("#lat").val(suggest.entities[0].latitude);
							$("#lng").val(suggest.entities[0].longitude);
					}else{
						var latRest = suggest.entities[0].latitude;
						var lngRest = suggest.entities[0].longitude;
						if( type== "HOTEL_GROUP"){
						}
						if(!(( lat<=latRest+0.4 && lat>=latRest-0.4 )&&(lng>=lngRest-0.4 && lng<=lngRest+0.4))){
							$("#lat").val(suggest.entities[0].latitude);
							$("#lng").val(suggest.entities[0].longitude);
						}
					}
				}	
			}
		})	
	}).fail(function() {
		failFunc();
	});

}
$( document ).ready(function() {
	
	$("#povName" ).change(function() {
		checkGeo();
	});
	$("#map" ).click(function() {
    	checkGeo();
	});
	$("#type" ).change(function() {
		type = $("#type").find(":selected").text();
		if(type == "landmark"){type="LANDMARK_GROUP";}else if(type == "hotel"){type="HOTEL_GROUP";}  
    	checkGeo();
	});
	$("#cityId" ).change(function() {
    	checkGeo();
	});
	$("#countryId" ).change(function() {
    	checkGeo();
	});

});


