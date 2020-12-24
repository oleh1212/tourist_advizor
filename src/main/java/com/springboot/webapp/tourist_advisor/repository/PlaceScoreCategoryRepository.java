package com.springboot.webapp.tourist_advisor.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.springboot.webapp.tourist_advisor.entity.PlaceScoreCategory;

public interface PlaceScoreCategoryRepository extends CrudRepository<PlaceScoreCategory, Long>{
	List<PlaceScoreCategory> findAllOrderBy();
}
