package com.springboot.webapp.tourist_advisor.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.webapp.tourist_advisor.entity.Country;
import com.springboot.webapp.tourist_advisor.service.CategoryService;
import com.springboot.webapp.tourist_advisor.service.CountryService;
import com.springboot.webapp.tourist_advisor.service.PlaceScoreCategoryService;



@Controller
public class TestController {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private PlaceScoreCategoryService placeScoreCategoryService;
	
	@GetMapping("/test")
    public String string(Model model) throws IOException {

		model.addAttribute("categories",placeScoreCategoryService.findAll());	
		return "test";
    }
}
