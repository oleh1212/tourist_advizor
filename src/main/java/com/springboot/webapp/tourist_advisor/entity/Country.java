package com.springboot.webapp.tourist_advisor.entity;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;



@Entity
@Table(name = "country")
public class Country {
	
	@Id
	@Column(length = 255 )
	@NotBlank(message = "Country code  cannot be empty")
	private String cnt_code;
	
	@Column(length = 2048,name = "name" )
	@NotBlank(message = "Country name cannot be empty")
	private String name;
	
	@Column(length = 2048,name = "description" )
	@NotBlank(message = "Description  cannot be empty")
	private String description;
	

	@Column(length = 2048,name = "main_photo" )
	private String main_photo;

	@OneToMany(mappedBy = "country",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
	private Set<City> cities;
	
	public Country() {
		// TODO Auto-generated constructor stub
	}
	
	

	public Country(String cnt_code, String name, String description, String main_photo) {
		this.cnt_code = cnt_code;
		this.name = name;
		this.description = description;
		this.main_photo = main_photo;
	}

 
	

	public Set<City> getCities() {
		return cities;
	}



	public void setCities(Set<City> cities) {
		this.cities = cities;
	}



	public String getCnt_code() {
		return cnt_code;
	}

	public void setCnt_code(String cnt_code) {
		this.cnt_code = cnt_code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getMain_photo() {
		return main_photo;
	}

	public void setMain_photo(String main_photo) {
		this.main_photo = main_photo;
	}
	

	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	@Override
	public String toString() {
		return "Country [cnt_code=" + cnt_code + ", description=" + description + ", main_photo=" + main_photo + "]";
	}

	
}
