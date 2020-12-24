package com.springboot.webapp.tourist_advisor.service;

import java.util.Optional; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.webapp.tourist_advisor.entity.Category;
import com.springboot.webapp.tourist_advisor.repository.CategoryRepository;

@Service
public class CategoryService {
	@Autowired
	CategoryRepository categoryRepository;
	
	public Category findById(Long id) {
		Optional<Category> result = categoryRepository.findById(id);
		Category category = null;
		
		if(result.isPresent()) {
			category= result.get();
		}else {
			throw new RuntimeException("Category is not found - "+id);
		}
		
		return category;
	}
	
	public Category findByType(String type) {
		return categoryRepository.findByType(type);
	}
	
	public Iterable<Category> findAll() {
		return categoryRepository.findAll();
	}
	public Iterable<Category> findAllByOrderByTypeAsc() {
		return categoryRepository.findAllByOrderByTypeAsc();
	}
	public void save(Category category) {
		categoryRepository.save(category);
	}
	public void deleteById(Long id) {
		categoryRepository.deleteById(id);
	}
}
