package com.springboot.webapp.tourist_advisor.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "pov_photos")
public class PovPhotos {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "pov_id")
	private Pov pov;
	
	private String file_name;

	public PovPhotos() {
		// TODO Auto-generated constructor stub
	}
	
	 
	public PovPhotos( String file_name,Pov pov) {
		this.file_name = file_name;
		this.pov = pov;
	}


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Pov getPov() {
		return pov;
	}

	public void setPov(Pov pov) {
		this.pov = pov;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	
	
}
