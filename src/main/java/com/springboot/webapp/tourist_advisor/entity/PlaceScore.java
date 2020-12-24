package com.springboot.webapp.tourist_advisor.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "place_score")
public class PlaceScore {
	@Id
	@GeneratedValue(strategy  = GenerationType.IDENTITY)
	private Long id;
	
	@Column(length = 2048,name = "description")
	private String description;
	
	@Column(name = "score")
	private Integer score;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "pov")
	private Pov pov;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category")
	private PlaceScoreCategory category;
	
	public PlaceScore() {
		// TODO Auto-generated constructor stub
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	
	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Pov getPov() {
		return pov;
	}

	public void setPov(Pov pov) {
		this.pov = pov;
	}

	public PlaceScoreCategory getCategory() {
		return category;
	}

	public void setCategory(PlaceScoreCategory category) {
		this.category = category;
	}
	
	
	
}
