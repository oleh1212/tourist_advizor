function searchHotelPhoto(hotel) {
    var settingsForPhotos = {
        "async": true,
        "crossDomain": true,
        "url": "https://hotels4.p.rapidapi.com/properties/get-hotel-photos?id=" + hotel,
        "method": "GET",
        "headers": {
            "Accept": "application/json, text/plain, */*",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7,uk;q=0.6",
            "Connection": "keep-alive",
            "Host": "hotels4.p.rapidapi.com",
            "Origin": "https://rapidapi.com",
            "Referer": "https://rapidapi.com/",
            "Sec-Fetch-Dest": "empty",
            "Sec-Fetch-Mode": "cors",
            "Sec-Fetch-Site": "same-site",
            "useQueryString": "true",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36",
            "x-rapidapi-host": "hotels4.p.rapidapi.com",
            "x-rapidapi-key": "c97474ed92msh1a05e14d575e6e0p10ef38jsn3116fd8707f4",
            "x-rapidapi-ua": "RapidAPI-Playground"
        }

    };
    return settingsForPhotos;
}

var restApiHotelId = $("#restApiHotelId").val();
$.ajax(searchHotelPhoto(restApiHotelId)).done(function (response) {
    console.log(response)
    var imgUrl = response.hotelImages[0].baseUrl;
    imgUrl = imgUrl.replace('{size}', response.hotelImages[0].sizes[0].suffix);
    $("#photo").attr('src', imgUrl);

    var carouselOl = '';
    var carouselDiv = '';
    $(response.hotelImages).each(function (index, img) {

        imgUrl = img.baseUrl;
        imgUrl = imgUrl.replace('{size}', img.sizes[2].suffix);

        if (index == 0) {

            carouselDiv += '<div class="carousel-item active">'
                + '<img  height="300" width="400"   src="' + imgUrl + '" class="d-block h-300  w-400" >'
                + '</div>';
        } else {

            carouselDiv += '<div class="carousel-item">'
                + '<img  height="300" width="400"   src="' + imgUrl + '" class="d-block h-300  w-400" >'
                + '</div>';
        }
        if (index == 5) {
            return false;
        }
    })
    $('#carousel-ol').append(carouselOl);
    $('#carousel-div').append(carouselDiv);

}).fail(function () {
    console.log('FAIL')
    $("#photo").attr('src', '/img/deffault/pov.jpg');
});