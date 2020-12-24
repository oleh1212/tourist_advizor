package com.springboot.webapp.tourist_advisor.controller;

import java.io.File; 
import java.io.IOException;


import java.sql.*;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.format.annotation.DateTimeFormat;
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
import com.springboot.webapp.tourist_advisor.entity.Comment;
import com.springboot.webapp.tourist_advisor.entity.Pov;
import com.springboot.webapp.tourist_advisor.entity.PovPhotos;
import com.springboot.webapp.tourist_advisor.entity.User;
import com.springboot.webapp.tourist_advisor.service.CategoryService;
import com.springboot.webapp.tourist_advisor.service.CommentService;
import com.springboot.webapp.tourist_advisor.service.PlaceScoreCategoryService;
import com.springboot.webapp.tourist_advisor.service.PovPhotosService;
import com.springboot.webapp.tourist_advisor.service.PovService;


@Controller
@RequestMapping("/cities/{city}/povs")
public class PovController {
	@Autowired
	private PovService povService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private PlaceScoreCategoryService placeScoreCategoryService;
	@Autowired
	private PovPhotosService povPhotosService;
	
	@Value("${upload.path}")
	private String uploadPath;
	
	@GetMapping ("/add")
	String povAdd(Model model,@PathVariable City city) {
		
		model.addAttribute("categories",categoryService.findAll());
		model.addAttribute("scoreCategories",placeScoreCategoryService.findAll());
		model.addAttribute("city",city);
		return "pov/povAdd";
	}
	
	
	@PostMapping("/add")
	public String addPov(@PathVariable City city,
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
			
			
			model.addAttribute("Error",true);
			model.mergeAttributes(errors);
			model.addAttribute("categories",categoryService.findAll());
			
			return "pov/povAdd";
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
		pov.setRestApiHotelId(restApiHotelId);
		pov.setVisible(user.isAdmin()?true:false);
		povService.save(pov);
		
		for(MultipartFile f:files) {
			
			String resultName = ControllerUtils.uploadFile(f,uploadPath + "/" + city.getCountry().getCnt_code()+"/"+city.getName()+"/"+pov.getName());
			if(resultName!=null) {
				povPhotosService.save(new PovPhotos(resultName,pov));
			}
		}
		
		
		return "redirect:/cities/"+city.getId();
	}
	
	
	@GetMapping
	public String showPovs(@RequestParam(required = false,defaultValue = "")String type,
							Model model,@PathVariable City city,
							@PageableDefault(sort = {"name"},direction = Direction.ASC) Pageable pageable) {
		
		model.addAttribute("categories",categoryService.findAll());
		model.addAttribute("city",city);
		
		if(!type.equals("")){
			model.addAttribute("page",povService.findByCategoryAndCity(categoryService.findByType(type),city,pageable));
			model.addAttribute("category",type);
		}else {
			model.addAttribute("page",povService.findByCity(city,pageable));
			model.addAttribute("category","All");
			
		}
		model.addAttribute("url","");
		return "pov/pov_list";
	}
	
	@GetMapping("/{pov}")
	public String povView(@PathVariable Pov pov,Model model) {
		
		model.addAttribute("pov",pov);
		model.addAttribute("comments",commentService.findAllByPovOrderByPublishDate(pov));
		
		
		return "pov/povView";
	}
	

	@PostMapping("/{pov}/delete")
	public String povDelete(@PathVariable Pov pov) {
		
		File fileToDelete = new File ("upload/" + pov.getCity().getCountry().getCnt_code()+"/"+pov.getCity().getName()+"/"+pov.getName()+"/"+pov.getMain_photo());
		fileToDelete.delete();
	
		Set<PovPhotos> povPhotos = pov.getPhotos();
			for(PovPhotos povPhoto : povPhotos) {
				fileToDelete = new File ("upload/" + pov.getCity().getCountry().getCnt_code()+"/"+pov.getCity().getName()+"/"+pov.getName()+"/"+povPhoto.getFile_name());
				fileToDelete.delete();
			}
		
		povService.deleteById(pov.getId());
		
		return "redirect:/cities/"+pov.getCity().getId()+"/povs?type="+pov.getCategory();
	}
	
	@PostMapping("/{pov}/visible")
	public String povChangeVisible(@PathVariable Pov pov) {
		pov.setVisible(pov.getVisible()?false:true);
		povService.save(pov);
		return "redirect:/cities/"+pov.getCity().getId()+"/povs/"+pov.getId();
	}
	
	@GetMapping("/{pov}/edit")
	public String povEdit(@PathVariable Pov pov,Model model) {
		
		model.addAttribute("categories",categoryService.findAll());
		model.addAttribute("pov",pov);
		
		return"pov/povEdit";
	}
	
	@PostMapping("/{pov}/edit")
	public String povUpdate(@PathVariable Pov pov,
			Pov povUpdate,@RequestParam(name = "type")String type,
			@RequestParam(name = "start",required = false)String start_date,
			@RequestParam(name = "end",required = false)String end_date,
			@RequestParam("file")MultipartFile file)throws IOException {

		if( file !=null && !file.getOriginalFilename().isEmpty()) {
			File fileToDelete = new File ("upload/" + pov.getCity().getCountry().getCnt_code()+"/"+pov.getCity().getName()+"/"+pov.getName()+"/"+pov.getMain_photo());
			fileToDelete.delete();

			String resultFileName = ControllerUtils.uploadFile(file,uploadPath + "/" + pov.getCity().getCountry().getCnt_code()+"/"+pov.getCity().getName()+"/"+pov.getName()); 

			if(resultFileName!=null) {
				pov.setMain_photo(resultFileName);
			}
		}

		pov.setName(povUpdate.getName());
		pov.setDescription(povUpdate.getDescription());
		pov.setPhone_number(povUpdate.getPhone_number());
		pov.setWeb_site(povUpdate.getWeb_site());
		if(!start_date.isEmpty()) {
			pov.setStart_date(Date.valueOf(start_date));
		}
		if(!end_date.isEmpty()) {
			pov.setEnd_date(Date.valueOf(end_date));
		}
		pov.setCategory(categoryService.findByType(type));
	
		povService.save(pov);	
		
		return "redirect:/cities/"+pov.getCity().getId()+"/povs/"+pov.getId();
	}
	
	
	@PostMapping("/{pov}/addComment")
	public String addComentToPov(@Valid Comment comment,
								BindingResult bindingResult,
								Model model,
								@AuthenticationPrincipal User user,
								@PathVariable Pov pov) {
		
		if(bindingResult.hasErrors()) {
			 Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
			 
			model.mergeAttributes(errors);
			model.addAttribute("pov",pov);
			model.addAttribute("comments",commentService.findAllByPovOrderByPublishDate(pov));
			
			
			return "pov/povView";
		}
		
		comment.setAuthor(user);
		comment.setPov(pov);
		
		commentService.save(comment);
		
		return "redirect:/cities/"+pov.getCity().getId()+"/povs/"+pov.getId();
	}
	
	@PostMapping("/{pov}/addCommentReply")
	public String addComentToComment(@Valid Comment comment,
									BindingResult bindingResult,
									Model model,
									@AuthenticationPrincipal User user,
									@PathVariable Pov pov,@RequestParam Long comment_id) {
		
		if(bindingResult.hasErrors()) {
			 Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
			 
			model.mergeAttributes(errors);
			model.addAttribute("pov",pov);
			model.addAttribute("comments",commentService.findAllByPovOrderByPublishDate(pov));
			
			
			return "pov/povView";
		}
		comment.setAuthor(user);
		comment.setPov(pov);
		comment.setPrnt_comment(commentService.findById(comment_id));
		
		commentService.save(comment);
		
		return "redirect:/cities/"+pov.getCity().getId()+"/povs/"+pov.getId();
	}
	
	@PostMapping("/{pov}/{comment}/delete")
	public String commentDelete(@PathVariable(name = "comment")Long id,@PathVariable Pov pov) {
		commentService.deleteById(id);
		
		return "redirect:/cities/"+pov.getCity().getId();
	}
	
}


