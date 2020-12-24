package com.springboot.webapp.tourist_advisor.controller;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.webapp.tourist_advisor.entity.Category;
import com.springboot.webapp.tourist_advisor.entity.User;
import com.springboot.webapp.tourist_advisor.service.CategoryService;
import com.springboot.webapp.tourist_advisor.service.CityService;
import com.springboot.webapp.tourist_advisor.service.PovService;
import com.springboot.webapp.tourist_advisor.service.UserService;

@Controller
public class MainController {
	@Autowired
	private CategoryService categoryService;
	@Autowired 
	private UserService userService;
	@Autowired 
	private CityService cityService;
	@Autowired
	private PovService povService;
	
	@GetMapping("/")
	public String hello(@AuthenticationPrincipal User user,Model model) {
		model.addAttribute("cities",cityService.findAllByOrderByPublishdateDesc());
		model.addAttribute("povs",povService.findAllByOrderByPublishdateDesc());
		
		return "main";
	}
	@GetMapping("/categories")
	public String showCategory(Model model) {
		model.addAttribute("categories",categoryService.findAllByOrderByTypeAsc());
		return "category";
	}
	@PostMapping("/categories")
	public String addCategory(Category category) {
		
		categoryService.save(category);
		
		return "redirect:/categories";
	}
	@PostMapping("/categories/{category}")
	public String updateCategory(@RequestParam(name = "type")String type,
								@RequestParam(name = "category")Category category) {
		category.setType(type);
		categoryService.save(category);
		
		return "redirect:/categories";
	}
	@GetMapping("/categories/{category}/delete")
	public String updateCategory(@RequestParam Category category) {
		categoryService.deleteById(category.getId());
		return "redirect:/categories";
	}
	
	@GetMapping("/forgotPassword")
	public String showForgotPassword() {
		return "forgotPassword/forgotForm";
	}
	@PostMapping("/forgotPassword")
	public String sendResetMail(Model model,@RequestParam(required = false,defaultValue = "") String email) {
		User user = userService.findByEmail(email);
		if(user == null) {
			model.addAttribute("wrongEmail","It was wrong email");
			
		}else {
			userService.forgotPassword(user);
			model.addAttribute("rightEmail","We have sent mail via your email");
		}
		
		return "forgotPassword/forgotForm";
	}
	@GetMapping("/forgotPassword/{code}")
	public String showResetPssword() {
		
		return "forgotPassword/switchPassword";
	}
	
	@PostMapping("/forgotPassword/{code}")
	public String resetPssword(Model model,@PathVariable String code,
							@RequestParam String password,@RequestParam String password2) {
		
		
		
		if(!password.isEmpty() && !password2.isEmpty()) {
			if(!password.equals(password2)) {
				model.addAttribute("passwordsError","Passwords are defferrent");
				
				return "forgotPassword/switchPassword";
			}
		}else {
			if(password2.isEmpty()) {
				model.addAttribute("password2Error","Password confirm cannot be empty");
				
			}
			if(password.isEmpty()) {
				model.addAttribute("passwordError","Password  cannot be empty");
			}
			return "forgotPassword/switchPassword";
		}
	
		boolean resetPassword = userService.resetPassword(code,password);
		
		if(!resetPassword) {
			model.addAttribute("unsuccessfulReset", "unsuccessful reset");
		}else{
			model.addAttribute("successfulReset", "successful reset");
		}
		
		return "messagePage";
	}
}
