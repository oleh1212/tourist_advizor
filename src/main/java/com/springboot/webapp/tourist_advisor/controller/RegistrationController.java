package com.springboot.webapp.tourist_advisor.controller;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;  

import javax.validation.Valid;

import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.springboot.webapp.tourist_advisor.dto.CaptchResponseDto;
import com.springboot.webapp.tourist_advisor.entity.User;
import com.springboot.webapp.tourist_advisor.service.NotificationService;
import com.springboot.webapp.tourist_advisor.service.UserService;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	
	private final static String CAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";
	@Autowired
	private UserService userService;
	@Value("${recaptcha.secret}")
	private String secret;
	@Autowired
	private RestTemplate restTemplate;

	
	@GetMapping
	public String addUser() {
		return "signUp";
	}
	
	
	@PostMapping
	public String createUser(@Valid User user,
							BindingResult bindingResult,
							Model model,
							@RequestParam(required = false,defaultValue = "") String password_conf,
							@RequestParam("g-recaptcha-response") String captchaResponse) 
	{
		String url = String.format(CAPTCHA_URL,secret,captchaResponse);
		CaptchResponseDto response = restTemplate.postForObject(url, Collections.emptyList(),CaptchResponseDto.class);
		
		
		boolean error = false;
		
		if(!response.isSuccess()) {
			model.addAttribute("captchaError","Error");
			
			error = true;
		}
		
		if(password_conf.isEmpty()) {
			model.addAttribute("password2Error","Error");
			
			error = true;
		}
		if(!user.getPassword().equals(password_conf)) {
			model.addAttribute("passwordsError","Error");
			
			error = true;
		}
		
		if(bindingResult.hasErrors() || error) {
			 Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
			 
			model.mergeAttributes(errors);
			
			return "signUp";
		}
		
		if(!userService.addUser(user)) {
			model.addAttribute("usernameError","Username already exists");
			
			return "signUp";
		}
		
		model.addAttribute("successfulRegistr","successful");
		return "messagePage";
	}
	
	@GetMapping("/activate")
	public String showActivate() {
		
		return "messagePage";
	}
	
	@GetMapping("/activate/{code}")
	public String activate(Model model,@PathVariable String code) {
		
		boolean isActivated = userService.activateUser(code);
		
		if(isActivated) {
			model.addAttribute("successful", "successful");
		}else {
			model.addAttribute("unsuccessful", "unsuccessful ");
		}
		return "login";
	}
	
}
