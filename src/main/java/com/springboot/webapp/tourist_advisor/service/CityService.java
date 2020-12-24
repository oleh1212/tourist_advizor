package com.springboot.webapp.tourist_advisor.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.springboot.webapp.tourist_advisor.dto.CityDto;
import com.springboot.webapp.tourist_advisor.entity.City;
import com.springboot.webapp.tourist_advisor.entity.Country;
import com.springboot.webapp.tourist_advisor.entity.Pov;
import com.springboot.webapp.tourist_advisor.entity.User;
import com.springboot.webapp.tourist_advisor.repository.CityRepository;

@Service
public class CityService {
		
	@Autowired
	private CityRepository cityRepository;
	
	public City findByName(String name) {
		return cityRepository.findByName(name);
	}
	public boolean save(City city) {
		
		if(findByName(city.getName())!=null) {
			return false;
		}
		
		cityRepository.save(city);
		
		return true;
	}
	
	public void update(City city) {
		
		cityRepository.save(city);

	}
	
	public void deleteById(Long id) {
		cityRepository.deleteById(id);
	}
	
	public City findById(Long id) {
		
		Optional<City> result = cityRepository.findById(id);
		
		City city = null;
		
		if(result.isPresent()) {
			city = result.get();
		}else {
			throw new RuntimeException("City is not found - " + id);
		}
		return city;
	}
	public Page<City> findAll(Pageable pageable) {
		return cityRepository.findAll(pageable);
	}
	public Iterable<City> findAllByOrderByIdAsc() {
		return cityRepository.findAllByOrderByIdAsc();
	}
	public Iterable<City> findAllByOrderByNameAsc() {
		return cityRepository.findAllByOrderByNameAsc();
	}
	public Page<City> findByCountry(Country country,Pageable pageable) {
		return cityRepository.findByCountry(country,pageable);
	}
	public List<City> findByCountry(Country country) {
		return cityRepository.findByCountry(country);
	}
	
	public Iterable<City> findAllByOrderByPublishdateDesc() {
		return cityRepository.findAllByOrderByPublishdateDesc();
	}
	public List<City> findAllByAuthorOrderByPublishdateDesc(User user) {
		return cityRepository.findAllByAuthorOrderByPublishdateDesc(user);
	}
	public CityDto findDtoById(Long id) {
		CityDto cityDto = new CityDto(findById(id));
		return cityDto;
	}
	public List<CityDto> findDtoByCountry(Country country) {
		List<City> cityList = findByCountry(country); 
		List<CityDto> cityDtoList = new ArrayList<CityDto>();
		
		for(City city : cityList) {
			cityDtoList.add(new CityDto(city));
		}
		return cityDtoList;
	}
}
