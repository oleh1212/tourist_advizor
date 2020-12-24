$( document ).ready(function() {

  $("#countryId").change(function() {
	  
	var countryId = $(this).find(":selected").val();
   
	
    event.preventDefault();
    ajaxGet(countryId);
    
  });
  
  function ajaxGet(countryId){
    $.ajax({
      type : "GET",
      url : "/pov/getCityList",
      data:{"countryId":countryId},
      success: function(result){
        if(result.status == "Done"){
          $('#getResultDiv ').empty();
          var cityList = '<label for="inputGroupSelect02">City name*</label>'
        	  +'<select name="cityId" class="custom-select" id="cityId" >';
          var cityLine = '';
      
          $.each(result.data, function(i, city){
        	  cityLine += '<option  value="'+city.id+'" >'+city.name+'</option>';
            
           });
          cityList += cityLine;
          cityList += '</select>'
            +'<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEoTo2KVSPS9Zt6VBuXUzBjCjXdy_FJ0s&callback=initMap&libraries=places" async defer></script>'
            +' <script src="/static/js/restApiSearchPlaces.js" async ></script>'
            +'<script src="/static/js/googleMap.js"></script>'
        	  +'<script>'
            +'$(document).ready(function() { $("#cityId").select2({tags: true}); });'
            +' $( document ).ready(function() {$("#cityId").change(function() {var city = $(this).find(":selected").text();initMapByCountryName(city);});});'
            +'</script>';
            
          $('#getResultDiv ').append(cityList)

          $('#firstCityDiv ').empty();
          $('#firstCityDiv ').append('<input type="hidden" value="'+result.data[0].name+'"  id="firstCity"/>')
          
        }else{
          $("#getResultDiv").html("<strong>Error</strong>");
          
        }
      },
      error : function(e) {
        $("#getResultDiv").html("<strong>Error</strong>");
        console.log("ERROR: ", e);
      }
    });  
  }
})