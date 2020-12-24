package com.springboot.webapp.tourist_advisor.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.springboot.webapp.tourist_advisor.entity.Country;
import com.springboot.webapp.tourist_advisor.repository.CountryRepository;

@Service
public class CountryService {
	@Autowired
	private CountryRepository countryRepository;
	
	public Page<Country> countryList(Pageable pageable) {
		return  countryRepository.findAll(pageable);
	}
	public Iterable<Country> findAllByOrderByNameAsc() {
		return  countryRepository.findAllByOrderByNameAsc();
	}
	
	
	public void save(Country country) {
		countryRepository.save(country);
	}
	
	public void deleteById(String Id) {
		countryRepository.deleteById(Id);
	}
	public Country findById(String id) {
		
		Optional<Country> result = countryRepository.findById(id);
		
		Country country = null;
		
		if(result.isPresent()) {
			country = result.get();
		}else {
			throw new RuntimeException("Country is not found - " + id);
		}
		return country;
	}
	public List<Country> findAll() {
		return countryRepository.findAll();
	}
}
