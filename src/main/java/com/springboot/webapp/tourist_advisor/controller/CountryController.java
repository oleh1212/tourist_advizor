package com.springboot.webapp.tourist_advisor.controller;


import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.webapp.tourist_advisor.entity.Country;
import com.springboot.webapp.tourist_advisor.service.CityService;
import com.springboot.webapp.tourist_advisor.service.CountryService;

@Controller 
@RequestMapping("/countries")
public class CountryController {
	
	@Value("${upload.path}")
	private String uploadPath;
	
	@Autowired
	private CountryService countryService;
	@Autowired
	private CityService cityService;
	
	@GetMapping
	public String country(Model model,
						@PageableDefault(sort = {"name"},direction = Direction.ASC) Pageable pageable) {
		
		Page<Country> page = countryService.countryList(pageable);
		
		model.addAttribute("page",page);
		model.addAttribute("url","countries");
		
		return "country/countries";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping
	public String country(@Valid Country country,BindingResult bindingResult,Model model,
						@RequestParam("file")MultipartFile file)throws IOException{
		boolean error = false;
		
		if(file.getSize()>1024*1024*5) {
			model.addAttribute("fileError","Error");
			
			error = true;
		}
		
		if(bindingResult.hasErrors() || error) {
			 Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
			 
			model.mergeAttributes(errors);
			model.addAttribute("swow",true);
			model.addAttribute("countries",countryService.findAllByOrderByNameAsc());
			
			return "country/countries";
		}
		
		String resultFileName = ControllerUtils.uploadFile(file,uploadPath + "/" + country.getCnt_code()); 
		
		if(resultFileName!=null) {
			country.setMain_photo(resultFileName);
		}
		
		
		countryService.save(country);
		
		return "redirect:/countries";
	}
	
	
	@PostMapping("/{country}/delete")
	@PreAuthorize("hasAuthority('ADMIN')")
	public String countryDelete(Country country) {
		
		
		File fileToDelete = new File ("upload/" +country.getCnt_code() + "/" + country.getMain_photo());
		fileToDelete.delete();
		
		countryService.deleteById(country.getCnt_code());
		
		return "redirect:/countries"; 
	}

	@GetMapping("/{country}")
	public String viewCountry(@PathVariable(name = "country") String id,Model model,
							@PageableDefault(sort = {"id"},direction = Direction.DESC) Pageable pageable) {
		
		Country country = countryService.findById(id);
		
		model.addAttribute("country",country);
		model.addAttribute("page",cityService.findByCountry(country,pageable));
		model.addAttribute("url","");
		
		
		return "country/countryView";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@GetMapping("/{country}/edit")
	public String showEditCountry(@PathVariable Country country,Model model) {
		
		model.addAttribute("country",country);
		
		return "country/countryEdit";
	}
	
	@PreAuthorize("hasAuthority('ADMIN')")
	@PostMapping("/{country}/edit")
	public String editCountry(@PathVariable(name = "country") Country country,
							@Valid Country countryUpdate,
							BindingResult bindingResult,Model model,
							@RequestParam("file")MultipartFile file)throws IOException {
		boolean error = false;
		
		if(file.getSize()>1024*1024*5) {
			model.addAttribute("fileError","Error");
			error = true;
		}
		
		if(bindingResult.hasErrors() || error) {
			Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
			
			model.mergeAttributes(errors);
			model.addAttribute("country",country);
			
			return "country/countryEdit";
		}
		
		 
		if( file !=null && !file.getOriginalFilename().isEmpty()) {
			File fileToDelete = new File ("upload/" +country.getCnt_code() + "/" + country.getMain_photo());
			
			fileToDelete.delete();
		
			String resultFileName = ControllerUtils.uploadFile(file,uploadPath + "/" + country.getCnt_code()); 
		
			if(resultFileName!=null) {
				country.setMain_photo(resultFileName);
			}
		}
		
		country.setCnt_code(countryUpdate.getCnt_code());
		country.setDescription(countryUpdate.getDescription());
		country.setName(countryUpdate.getName());
		
		countryService.save(country);
		
		
		return "redirect:/countries/"+country.getCnt_code(); 
	}
	
	
	
}