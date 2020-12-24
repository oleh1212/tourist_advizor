package com.springboot.webapp.tourist_advisor.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.springboot.webapp.tourist_advisor.dto.CityDto;
import com.springboot.webapp.tourist_advisor.response.Response;
import com.springboot.webapp.tourist_advisor.service.CityService;
import com.springboot.webapp.tourist_advisor.service.CountryService;

@RestController
public class PovRestController {
	  @Autowired
	  private CountryService countryService;
	  @Autowired
	  private CityService cityService;
	  
	  @GetMapping("/pov/getCityList")
	  public Response getResource(Model model,@RequestParam String countryId) {
		List<CityDto> countyList = cityService.findDtoByCountry(countryService.findById(countryId));
		
	    Response response = new Response("Done", countyList);
	    return response;
	  }
	 
}
