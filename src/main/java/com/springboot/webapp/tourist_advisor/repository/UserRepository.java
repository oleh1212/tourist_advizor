package com.springboot.webapp.tourist_advisor.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.webapp.tourist_advisor.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {
	User findByUsername(String username);
	
	List<User> findAllByOrderByUsernameAsc();
	List<User> findAllByOrderByIdAsc();
	List<User> findAllByOrderByEmailAsc();
	User findByActiveCode(String code);
	User findByEmail(String email);
}
