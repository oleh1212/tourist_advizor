package com.springboot.webapp.tourist_advisor.repository;

import org.springframework.data.repository.CrudRepository;

import com.springboot.webapp.tourist_advisor.entity.Category;


public interface CategoryRepository extends CrudRepository<Category, Long> {
	Category findByType(String type);
	Iterable<Category> findAllByOrderByTypeAsc();
}
