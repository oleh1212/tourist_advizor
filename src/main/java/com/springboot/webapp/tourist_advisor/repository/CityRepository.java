package com.springboot.webapp.tourist_advisor.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import com.springboot.webapp.tourist_advisor.entity.City;
import com.springboot.webapp.tourist_advisor.entity.Country;
import com.springboot.webapp.tourist_advisor.entity.User;

public interface CityRepository extends CrudRepository<City, Long> {
	
	City findByName(String name);
	Iterable<City> findAllByOrderByIdAsc();
	Iterable<City> findAllByOrderByNameAsc();
	Page<City> findAll(Pageable pageable);
	Page<City> findByCountry(Country country,Pageable pageable);
	List<City> findByCountry(Country country);
	Iterable<City> findAllByOrderByPublishdateDesc();
	List<City> findAllByAuthorOrderByPublishdateDesc(User user);
}
