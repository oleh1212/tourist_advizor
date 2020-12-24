package com.springboot.webapp.tourist_advisor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.webapp.tourist_advisor.entity.PlaceScoreCategory;
import com.springboot.webapp.tourist_advisor.repository.PlaceScoreCategoryRepository;

@Service
public class PlaceScoreCategoryService {
	@Autowired
	private PlaceScoreCategoryRepository  placeScoreCategoryRepository;
	
	public List<PlaceScoreCategory> findAll() {
		return placeScoreCategoryRepository.findAllOrderBy();
	}
}
