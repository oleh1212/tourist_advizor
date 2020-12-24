package com.springboot.webapp.tourist_advisor.entity;

import java.sql.Date; 
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.hibernate.annotations.CreationTimestamp;
 
@Entity
@Table(name = "povs")
public class Pov {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(length = 2048,name = "name" )
	@NotBlank(message = "Point of view name cannot be empty")
	private String name;
	
	@Column(length = 2048,name = "description" )
	@NotBlank(message = "Description name cannot be empty")
	private String description;
	

	@Column(length = 2048,name = "main_photo" )
	private String main_photo;
	

	@Column(length = 2048,name = "phone_number" )
	private String phone_number;
	
	@Column(length = 2048,name = "web_site" )
	private String web_site;
	
	@Column(name = "start_date" )
	//@Past(message = "This date has to be in the past")
	private Date start_date;
	
	@Column(name = "end_date")
	//@Past(message = "This date has to be in the past")
	private Date end_date; 
	
	@Column(name = "lat" )
	private Float lat;
	
	@Column(name = "lng" )
	private Float lng;
	
	@Column(name = "visible" )
	private Boolean visible;
	
	@Column(name = "restApiHotelId" )
	private String restApiHotelId;
	
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "publishDate" )
	private java.util.Date publishdate;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category")
	private Category category;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "cityId")
	private City city;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User author;
	
	@OneToMany(mappedBy = "pov",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
	private Set<Comment> comments;
	
	@OneToMany(mappedBy = "pov",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
	private Set<PovPhotos> photos;
	
	@OneToMany(mappedBy = "pov",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
	private Set<PlaceScore> placeScores;

	public Pov() {
		// TODO Auto-generated constructor stub
	}
	
	

	public Boolean getVisible() {
		return visible;
	}



	public void setVisible(Boolean visible) {
		this.visible = visible;
	}



	public String getRestApiHotelId() {
		return restApiHotelId;
	}



	public void setRestApiHotelId(String restApiHotelId) {
		this.restApiHotelId = restApiHotelId;
	}



	public Float getLat() {
		return lat;
	}



	public void setLat(Float lat) {
		this.lat = lat;
	}



	public Float getLng() {
		return lng;
	}



	public void setLng(Float lng) {
		this.lng = lng;
	}



	public Set<PovPhotos> getPhotos() {
		return photos;
	}


	public void setPhotos(Set<PovPhotos> photos) {
		this.photos = photos;
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

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	

	public String getWeb_site() {
		return web_site;
	}



	public void setWeb_site(String web_site) {
		this.web_site = web_site;
	}



	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getEnd_date() {
		return end_date;
	}

	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}

	

	

	
	public java.util.Date getPublishdate() {
		return publishdate;
	}



	public void setPublishdate(java.util.Date publishdate) {
		this.publishdate = publishdate;
	}



	public Category getCategory() {
		return category;
	}


	public void setCategory(Category category) {
		this.category = category;
	}


	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}


	public Set<Comment> getComments() {
		return comments;
	}


	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}



	public Set<PlaceScore> getPlaceScores() {
		return placeScores;
	}



	public void setPlaceScores(Set<PlaceScore> placeScores) {
		this.placeScores = placeScores;
	}
	
	
	
	
	
	
}
