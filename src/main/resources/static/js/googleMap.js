function setPos(lat,lng){
	$("#lat").val(lat);
	$("#lng").val(lng);
}

function initMapWithPosition(posLat,posLng,posZoom){
	var pos = {lat:posLat,lng:posLng};
	var opt = {
		center:pos,
		zoom:posZoom,
		
	};

	var myMap = new google.maps.Map(document.getElementById("map"),opt);
	var marker = new google.maps.Marker({
		position:pos,
		map:myMap
	});

}

function initMap(){
	var pos = {lat:0,lng:0};
	var opt = {
		center:pos,
		zoom:7,
		
	};

	var map = new google.maps.Map(document.getElementById("map"),opt);
	var marker = new google.maps.Marker({
		position:pos,
		map:map
	});


	var request = {
    	query: document.getElementById("firstCity").value,
    	fields: ['geometry']
	};
	
	

  	var service = new google.maps.places.PlacesService(map);

  	service.findPlaceFromQuery(request, function(results, status) {
		setPos(results[0].geometry.location.lat(),results[0].geometry.location.lng());
    	if (status === google.maps.places.PlacesServiceStatus.OK) {
			map.setCenter(results[0].geometry.location);
			marker.setPosition(map.getCenter());
			
    	}
  	});

	map.addListener('click', function(e) {
    	placeMarkerAndPanTo(e.latLng);
	});
	  
	function placeMarkerAndPanTo(latLng) {
		 marker.setPosition(latLng)
		 setPos(marker.getPosition().lat(),marker.getPosition().lng());
	}
	
	setPos(marker.getPosition().lat(),marker.getPosition().lng());

	
}
//////////
function initMapByCountryName(cityName) {

	var sydney = new google.maps.LatLng(0, 0);

	
	
  	var map = new google.maps.Map(
		document.getElementById('map'), {center: sydney, zoom: 7}
	);
	
	var marker = new google.maps.Marker({
		position:sydney,
		map:map
	});

  	var request = {
    	query: cityName,
    	fields: ['geometry'],
  	};

  	var service = new google.maps.places.PlacesService(map);

  	service.findPlaceFromQuery(request, function(results, status) {
    	if (status === google.maps.places.PlacesServiceStatus.OK) {
      		map.setCenter(results[0].geometry.location);
			marker.setPosition(map.getCenter());
			
    	}
  	});

	map.addListener('click', function(e) {
    	placeMarkerAndPanTo(e.latLng);
	});

	function placeMarkerAndPanTo(latLng) {
		 marker.setPosition(latLng)
		 document.getElementById("lat").value = marker.getPosition().lat();
		 document.getElementById("lng").value = marker.getPosition().lng();
	}

	document.getElementById("lat").value = marker.getPosition().lat();
	document.getElementById("lng").value = marker.getPosition().lng();
	
}

$( document ).ready(function() {
	$("#cityId").change(function() {
		var city = $(this).find(":selected").text();
		initMapByCountryName(city);
		setPos(0,0);
	});
});








