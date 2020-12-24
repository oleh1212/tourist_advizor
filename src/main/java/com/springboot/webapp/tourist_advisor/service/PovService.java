package com.springboot.webapp.tourist_advisor.service;

import java.util.List; 
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.springboot.webapp.tourist_advisor.entity.Category;
import com.springboot.webapp.tourist_advisor.entity.City;
import com.springboot.webapp.tourist_advisor.entity.Pov;
import com.springboot.webapp.tourist_advisor.entity.User;
import com.springboot.webapp.tourist_advisor.repository.PovRepository;

@Service
public class PovService {
	@Autowired
	private PovRepository povRepository;
	
	public Iterable<Pov> findAll() {
		return povRepository.findAll(); 
	}
	
	public Pov findById(Long id) {
		
		Optional<Pov> result = povRepository.findById(id);
		
		Pov pov = null;
		
		if(result.isPresent()) {
			pov = result.get();
		}else {
			throw new RuntimeException("Point of view is not found - " + id);
		}
		return pov;
	}
	
	public void save(Pov pov) {
		povRepository.save(pov);
	}
	
	public void deleteById(Long id) {
		povRepository.deleteById(id);
	}
	
	public List<Pov> findByCategory(Category category) {
			return povRepository.findByCategory(category);
		
	}
	public Page<Pov> findByCategoryAndCity(Category category,City city,Pageable pageable) {
		return povRepository.findByCategoryAndCity(category,city,pageable);
	}
	
	public Page<Pov> findByCity(City city,Pageable pageable) {
		return povRepository.findByCity(city,pageable);
	}
	public Iterable<Pov> findAllByOrderByPublishdateDesc() {
		return povRepository.findAllByOrderByPublishdateDesc();
	}
	public List<Pov> findAllByAuthorOrderByPublishdateDesc(User user) {
		return povRepository.findAllByAuthorOrderByPublishdateDesc(user);
	}
	
}
