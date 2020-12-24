package com.springboot.webapp.tourist_advisor.entity;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotBlank;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "city")
public class City {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	
	@NotBlank(message = "City name cannot be empty")
	@Column(length = 2048,name = "name" )
	private String name;
	
	@NotBlank(message = "Description cannot be empty")
	@Column(length = 2048,name = "description" )
	private String description;
	

	@Column(length = 2048,name = "main_photo" )
	private String main_photo;
	
	@Column(name = "empty" )
	private Boolean empty;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User author;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "country_code")
	private Country country;
	
	@OneToMany(mappedBy = "city",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
	private Set<Pov> povs;
	
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "publishDate" )
	private java.util.Date publishdate;

	public City() {
		// TODO Auto-generated constructor stub
	}
	


	public City( String name, String description,  User author, Country country) {
		this.name = name;
		this.description = description;
		this.author = author;
		this.country = country;
	}



	
	public Set<Pov> getPovs() {
		return povs;
	}



	public void setPovs(Set<Pov> povs) {
		this.povs = povs;
	}



	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User user) {
		this.author = user;
	}

	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	public Boolean getEmpty() {
		return empty;
	}



	public void setEmpty(Boolean empty) {
		this.empty = empty;
	}



	@Override
	public String toString() {
		return "City [id=" + id + ", name=" + name + ", description=" + description + ", main_photo=" + main_photo
				+ ", author=" + author + ", country=" + country + "]";
	}



	public java.util.Date getPublishdate() {
		return publishdate;
	}



	public void setPublishdate(java.util.Date publishdate) {
		this.publishdate = publishdate;
	}
	
	
	

}
