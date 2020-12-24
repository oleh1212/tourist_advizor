package com.springboot.webapp.tourist_advisor.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.webapp.tourist_advisor.entity.Role;
import com.springboot.webapp.tourist_advisor.entity.User;
import com.springboot.webapp.tourist_advisor.service.CityService;
import com.springboot.webapp.tourist_advisor.service.PovService;
import com.springboot.webapp.tourist_advisor.service.UserService;


@Controller
@RequestMapping("/users")
public class UserController {
	@Value("${upload.path}")
	private String uploadPath;
	@Autowired
	private UserService userService;
	@Autowired
	private PovService povService;
	@Autowired
	private CityService cityService;
	
	@GetMapping
	@PreAuthorize("hasAuthority('ADMIN')")
	public String userList(Model model,@RequestParam(required = false, defaultValue = "username") String sort) {
		List<User> users;
		
		if(sort.equals("id"))
			users = userService.findAllByOrderByIdAsc();
		else if(sort.equals("email"))
			users = userService.findAllByOrderByEmailAsc();
		else
			users = userService.findAllByOrderByUsernameAsc();
		
		model.addAttribute("users",users);
		model.addAttribute("sort",sort);
		
		return "user/list-users"; 
	}
	
	@PostMapping("/delete")
	@PreAuthorize("hasAuthority('ADMIN')")
	public String userDelete(@RequestParam String id) {
		
		userService.deleteById(Long.parseLong(id));
		
		return "redirect:/users"; 
	}
	
	@GetMapping("/profile/{user}")
	@PreAuthorize("hasAuthority('ADMIN')")
    public String userEditForm(@PathVariable(name = "user")String id, Model model) {
		
		User user = userService.findById(Long.parseLong(id));
		
        model.addAttribute("user", user);
        
        model.addAttribute("roles", Role.values());

        return "user/userEdit";
    }
	
	@PostMapping("/profile/{user}")
	@PreAuthorize("hasAuthority('ADMIN')")
    public String userUpdate(@PathVariable User user,
    						@RequestParam String username,
    						@RequestParam Map<String, String> form,
    						Model model) {
		
		userService.updateUser(user,username,form);

        return "redirect:/users/"+user.getId();
    }
	@GetMapping("profile")
    public String userProfile(@AuthenticationPrincipal User user, Model model){

        model.addAttribute("user",user);

        return "user/profile";
    }
	
	@PostMapping("profile")
    public String setOwnProfile(@AuthenticationPrincipal User user,@RequestParam String password,
    							@RequestParam String password2,
                                @RequestParam String email,@RequestParam("file")MultipartFile file,
        						Model model)throws IOException
    {

		if(!password.isEmpty() || !password2.isEmpty()) {
			if(!password.equals(password2)) {
				if(password2.isEmpty()) {
					model.addAttribute("password2Error","Error");
				}else {
					model.addAttribute("passwordsError","Error");
				}
				
				model.addAttribute("user",user);
				return "user/profile";
			}
			
		}

		if( file !=null && !file.getOriginalFilename().isEmpty()) {
			File fileToDelete = new File ("upload/user/"+user.getPicture());
			fileToDelete.delete();

			String resultFileName = ControllerUtils.uploadFile(file,uploadPath + "/user");

			if(resultFileName!=null) {
				user.setPicture(resultFileName);
			}
		}
		
        userService.profileUpdate(user,password,email);
        return "redirect:/users/profile";
    }
	@GetMapping("/{user}")
    public String showUserPublications(@PathVariable User user, 
    								@RequestParam(required = false,defaultValue = "Cities")String filter,
    								Model model){
		model.addAttribute("user",user);
		model.addAttribute("filter",filter);
		if(filter.equals("Cities")) {
			model.addAttribute("publications",cityService.findAllByAuthorOrderByPublishdateDesc(user));
		}else {
			model.addAttribute("publications",povService.findAllByAuthorOrderByPublishdateDesc(user));
		}
		return "user/userPublications";
	}
	
	
}
