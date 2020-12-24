package com.springboot.webapp.tourist_advisor.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import com.springboot.webapp.tourist_advisor.entity.Category;
import com.springboot.webapp.tourist_advisor.entity.City;
import com.springboot.webapp.tourist_advisor.entity.Pov;
import com.springboot.webapp.tourist_advisor.entity.User;


public interface PovRepository extends CrudRepository<Pov, Long> {
	List<Pov> findByCategory(Category  category);
	Page<Pov> findByCategoryAndCity(Category  category,City city,Pageable pageable);
	Page<Pov> findByCity(City city,Pageable pageable);
	Iterable<Pov> findAllByOrderByPublishdateDesc();
	List<Pov> findAllByAuthorOrderByPublishdateDesc(User user);
}
