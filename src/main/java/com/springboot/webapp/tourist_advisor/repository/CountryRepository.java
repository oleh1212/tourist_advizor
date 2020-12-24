package com.springboot.webapp.tourist_advisor.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import com.springboot.webapp.tourist_advisor.entity.Country;

public interface CountryRepository extends CrudRepository<Country, String> {
	Iterable<Country> findAllByOrderByNameAsc();
	List<Country> findAll();
	Page<Country> findAll(Pageable pageable);
}
