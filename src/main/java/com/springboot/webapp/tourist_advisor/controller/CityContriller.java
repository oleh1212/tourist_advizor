package com.springboot.webapp.tourist_advisor.controller;

import java.io.File; 
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.webapp.tourist_advisor.entity.City;
import com.springboot.webapp.tourist_advisor.entity.Country;
import com.springboot.webapp.tourist_advisor.entity.Pov;
import com.springboot.webapp.tourist_advisor.entity.PovPhotos;
import com.springboot.webapp.tourist_advisor.entity.User;
import com.springboot.webapp.tourist_advisor.service.CategoryService;
import com.springboot.webapp.tourist_advisor.service.CityService;
import com.springboot.webapp.tourist_advisor.service.CountryService;
import com.springboot.webapp.tourist_advisor.service.PovPhotosService;
import com.springboot.webapp.tourist_advisor.service.PovService;


 
@Controller
@RequestMapping("/cities")
public class CityContriller {
	
	@Value("${upload.path}")
	private String uploadPath;
	
	@Autowired
	private CityService cityService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private CountryService countryService;
	@Autowired
	private PovService povService;
	@Autowired 
	private PovPhotosService povPhotosService;
	
	
	@GetMapping
	public String cityList(Model model,
						@PageableDefault(sort = {"id"},direction = Direction.DESC) Pageable pageable) {
		
		model.addAttribute("page",cityService.findAll(pageable));
		model.addAttribute("url","cities");
		
		return "city/cities";
	}
	
	@GetMapping("/add")
	public String cityAdd(@RequestParam(name = "country_id",required = false,defaultValue = "")String cnt_code,Model model) {
		
		if(!cnt_code.equals("")) {
			model.addAttribute("country",countryService.findById(cnt_code));
		}
		model.addAttribute("countries",countryService.findAllByOrderByNameAsc());
		
		return "city/addCity";
	}
	
	@PostMapping("/add")
	public String addCity(@Valid City city,
						BindingResult bindingResult,
						Model model,
						@RequestParam("file")MultipartFile file,
						@RequestParam(name = "countryId")String cnt_code,
						@AuthenticationPrincipal User user)throws IOException {
		
		boolean FileSizeError = false;
		
		if(file.getSize()>1024*1024*5) {
			model.addAttribute("fileError","Error");
			
			 FileSizeError = true;
		}
		
		if(bindingResult.hasErrors() || FileSizeError) {
			 Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
			 
			
			model.addAttribute("country",countryService.findById(cnt_code));
			model.mergeAttributes(errors);
			model.addAttribute("countries",countryService.findAllByOrderByNameAsc());
			
			return "city/addCity";
		}
		Country country = countryService.findById(cnt_code);

		String resultFileName = ControllerUtils.uploadFile(file,uploadPath + "/" + country.getCnt_code()+"/"+city.getName()); 
		
		if(resultFileName!=null) {
			city.setMain_photo(resultFileName);
		}
		
		city.setAuthor(user);
		city.setCountry(country);
		city.setEmpty(false);
		if(!cityService.save(city)) {
			
			model.addAttribute("ErrorExists","Error");
			model.addAttribute("country",country);
			
			return "countryView/"+city.getCountry().getCnt_code();
		}
		
		return "redirect:/countries/"+city.getCountry().getCnt_code();
	}

	@GetMapping("/{city}")
	public String cityView(City city,Model model,
							@PageableDefault(sort = {"id"},direction = Direction.DESC) Pageable pageable) {
		
		model.addAttribute("categories",categoryService.findAll());
		model.addAttribute("city",city);
		model.addAttribute("url","");
		model.addAttribute("page",povService.findByCity(city,pageable));
		
		return "city/cityView";
	}
	
		
	@GetMapping("/{city}/edit")
	public String editCity(@PathVariable City city,Model model) {
		
		model.addAttribute("city",city);
		
		return "city/cityEdit";
	}
	
	@PostMapping("/{city}/edit")
	public String updateCity(@Valid City cityUpdate,
							BindingResult bindingResult,
							Model model,
							@RequestParam("file")MultipartFile file,
							@PathVariable City city)throws IOException {
		
		Boolean error =false ;
		
		if(file.getSize()>5*1048*1048) {
			error = true;
			model.addAttribute("fileError","Error");
		}
		
		if(bindingResult.hasErrors() || error) {
			Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
			
			model.mergeAttributes(errors);
			model.addAttribute("city",city);
			
			return "city/cityEdit";
		}
		
		
			File dir = new File(uploadPath + "/" + city.getCountry().getCnt_code()+"/"+cityUpdate.getName());
        	File newDir = new File(uploadPath + "/" + city.getCountry().getCnt_code()+"/"+cityUpdate.getName());
        	if(dir.exists()) {
        		dir.renameTo(newDir);
        	}
		
		
		city.setName(cityUpdate.getName());
		city.setDescription(cityUpdate.getDescription());
		
		
		if( file !=null && !file.getOriginalFilename().isEmpty()) {
			File fileToDelete = new File ("upload/" +city.getCountry().getCnt_code() + "/" + city.getName()+"/"+city.getMain_photo());
			fileToDelete.delete();

			String resultFileName = ControllerUtils.uploadFile(file,uploadPath + "/" + city.getCountry().getCnt_code()+"/"+city.getName());

			if(resultFileName!=null) {
				city.setMain_photo(resultFileName);
			}
		}
		
		if(!city.getDescription().equals("")&&!city.getDescription().isEmpty()) {
			city.setEmpty(false);
		}
		
		cityService.update(city);


		return "redirect:/cities/"+city.getId(); 
	}
	
	@PostMapping("/{city}/delete")
	public String deleteCity(@PathVariable City city){
		
		File fileToDelete = new File ("upload/" +city.getCountry().getCnt_code() + "/" + city.getName()+"/"+city.getMain_photo());
		fileToDelete.delete();
		
		cityService.deleteById(city.getId());
	
		return "redirect:/countries/"+city.getCountry().getCnt_code();
	}
	
	///////////////////////////////////////////////////////////////////
	
	@GetMapping ("/pov/add")
	String povAdd(Model model) {
		List<Country> countries = (List<Country>) countryService.findAllByOrderByNameAsc();
		model.addAttribute("categories",categoryService.findAll());	
		model.addAttribute("countries",countryService.findAllByOrderByNameAsc());
		model.addAttribute("cities", countries.get(0).getCities());
		return "pov/povAdd";
	}
	
	
	@PostMapping("/pov/add")
	public String addPov(@RequestParam String countryId,
						@RequestParam(name = "cityId") String cityStr,
						@AuthenticationPrincipal User user,
						@Valid Pov pov,
						BindingResult bindingResult,
						Model model,
						@RequestParam("file")MultipartFile file,
						@RequestParam("files")List<MultipartFile> files,
						@RequestParam(name = "type")String type,
						@RequestParam Float lat ,@RequestParam Float lng,
						@RequestParam String restApiHotelId)throws IOException {
		
		
		
		boolean error = false;
		
		if(cityStr.isEmpty()) {
			model.addAttribute("cityNameError","City name cannt be empty");
			error = true;
		}
		if(file.getSize()>1024*1024*5) {
			model.addAttribute("fileError","Error");
			error = true;
		}
		for(MultipartFile f:files) {
			if(f.getSize()>1024*1024*5) {
				model.addAttribute("filesError","Error");
				error = true;
				break;
			}
		}
		if(pov.getStart_date()==null || pov.getEnd_date()==null) {
			
			model.addAttribute("start_dateError","Error");
			model.addAttribute("end_dateError","Error");
			
		}else if(pov.getStart_date()!=null && pov.getEnd_date()!=null){
			if(pov.getStart_date().after(pov.getEnd_date())) {
				model.addAttribute("end_dateWrongError","Error");
				error = true;
			}
		}
		
		if(bindingResult.hasErrors() || error) {
			Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
			
			
			
			model.mergeAttributes(errors);
			List<Country> countries = (List<Country>) countryService.findAllByOrderByNameAsc();
			model.addAttribute("Error",true);
			model.addAttribute("date",pov.getEnd_date());
			model.addAttribute("countries",countries);
			model.addAttribute("cities",countries.get(0).getCities());
			model.addAttribute("categories",categoryService.findAll());
			
			return "pov/povAdd";
		}
		
		Country country = countryService.findById(countryId);
		City city = new City();
		
		try {
			city = cityService.findById(Long.parseLong(cityStr));
		} catch (NumberFormatException e) {
			city = new City(cityStr,"Empty",user,country);
			city.setEmpty(true);
			File uploadDir = new File(uploadPath+"/"+country.getCnt_code()+"/"+cityStr);
			
			if(!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			cityService.save(city);
		}
		
		
		String resultFileName = ControllerUtils.uploadFile(file,uploadPath + "/" + city.getCountry().getCnt_code()+"/"+city.getName()+"/"+pov.getName());
		
		if(resultFileName!=null) {
			pov.setMain_photo(resultFileName);
		}

		pov.setCategory(categoryService.findByType(type));
		pov.setAuthor(user);
		pov.setCity(city);
		pov.setLat(lat);
		pov.setLng(lng);
		pov.setVisible(user.isAdmin()?true:false);
		pov.setRestApiHotelId(restApiHotelId);
		povService.save(pov);
		
		for(MultipartFile f:files) {
			
			String resultName = ControllerUtils.uploadFile(f,uploadPath + "/" + city.getCountry().getCnt_code()+"/"+city.getName()+"/"+pov.getName());
			if(resultName!=null) {
				povPhotosService.save(new PovPhotos(resultName,pov));
			}
		}
		
		
		return "redirect:/cities/"+city.getId()+"/povs/"+pov.getId();
	}
	

	
}
