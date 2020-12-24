package com.springboot.webapp.tourist_advisor.service;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.springboot.webapp.tourist_advisor.entity.Role;
import com.springboot.webapp.tourist_advisor.entity.User;
import com.springboot.webapp.tourist_advisor.repository.UserRepository;
import org.springframework.util.StringUtils;


@Service
public class UserService implements UserDetailsService {

	private final UserRepository userRepository;
	
	private final PasswordEncoder passwordEncoder;
	
	private final NotificationService notificationService;

	Logger logger = LoggerFactory.getLogger(UserService.class);

	public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, NotificationService notificationService) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
		this.notificationService = notificationService;
	}

	public PasswordEncoder getPasswordEncoder() {
		return passwordEncoder;
	}

	public List<User> findAll() {
		return userRepository.findAll();
	}
	

	public User findById(Long id) {
		
		Optional<User> result = userRepository.findById(id);
		
		User user = null;
		
		if(result.isPresent()) {
			user = result.get();
		}else {
			throw new RuntimeException("User is not found - "+id);
		}
		return user;
	}


	public void save(User user) {
		userRepository.save(user);

	}
	

	public void deleteById(Long id) {
		userRepository.deleteById(id);
	}


	public boolean addUser(User user) {
		
		User userFromDB = userRepository.findByUsername(user.getUsername());
		
        if(userFromDB!=null){
            return false;
        }
        
        user.setActive(false);
        user.setRoles(Collections.singleton(Role.USER));
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setActiveCode(UUID.randomUUID().toString());
        
        userRepository.save(user);

		logger.info("\n http://192.168.1.18:8080/registration/activate/" + user.getActiveCode() + "\n");
        String message = String.format(
        		"Hello, %s! \n"+
        				"Welcome to Tourist Advisor.Please visit next link to activate your account : http://192.168.1.18:8080/registration/activate/%s", 
        				user.getUsername(),
        				user.getActiveCode()
        );
        notificationService.sendNotification(user.getEmail(), "Activation code", message);

        return true;
	}
	
	
	public boolean activateUser(String code) {
		User user = userRepository.findByActiveCode(code);
		if(user == null) {
			return false;
		}
		user.setActiveCode(null);
		user.setActive(true);
		userRepository.save(user);
		
		
		return true;
	}

	public void forgotPassword(User user) {
		
		user.setActiveCode(UUID.randomUUID().toString());
        
        userRepository.save(user);
        
		String message = String.format(
        		"Hello, %s! \n"+
        				"It is your link to reset  password : http://192.168.1.18:8080/forgotPassword/%s \n"+
        				"If you did not send any request to reset password,do not do anything", 
        				user.getUsername(),
        				user.getActiveCode()
        );
        notificationService.sendNotification(user.getEmail(), "Reset password", message);
	}
	
	public boolean resetPassword(String code,String password) {
		User user = userRepository.findByActiveCode(code);
		if(user == null) {
			return false;
		}
		user.setActiveCode(null);
		user.setPassword(passwordEncoder.encode(password));
		userRepository.save(user);
		
		
		return true;
	}
	
	public List<User> findAllByOrderByUsernameAsc() {
		return userRepository.findAllByOrderByUsernameAsc();
	}
	public List<User> findAllByOrderByEmailAsc() {
		return userRepository.findAllByOrderByEmailAsc();
	}
	public List<User> findAllByOrderByIdAsc(){
		return userRepository.findAllByOrderByIdAsc();
	}

	public User findByEmail(String email) {
		return userRepository.findByEmail(email);
	}
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user =  userRepository.findByUsername(username);

        if(user == null){
            throw  new UsernameNotFoundException("User is not found");
        }
        return user;
	}
	
	public void updateUser(User user, String username, Map<String, String> form) {
		user.setUsername(username);

        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }

        userRepository.save(user);
		
	}
	
	public void profileUpdate(User user,String password,String email) {
		 String userEmail = user.getEmail();

	        boolean isEmailChanged = (email != null && !email.equals(userEmail)) ||
	                (userEmail != null && !userEmail.equals(email));

	        if(isEmailChanged)
	            user.setEmail(email);
	        if(!StringUtils.isEmpty(password))
	            user.setPassword(passwordEncoder.encode(password));

	        userRepository.save(user);
	}
	
	
	
	
	
}
