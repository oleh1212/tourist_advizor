package com.springboot.webapp.tourist_advisor.dto;

import com.springboot.webapp.tourist_advisor.entity.City;

public class CityDto {
	private Long id;
	private String name;
	private String description;
	public CityDto(City city) {
		this.id = city.getId();
		this.name = city.getName();
		this.description = city.getDescription();
	}
	public Long getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getDescription() {
		return description;
	}
	
	
}
