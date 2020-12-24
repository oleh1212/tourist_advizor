package com.springboot.webapp.tourist_advisor.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.springboot.webapp.tourist_advisor.entity.Comment;
import com.springboot.webapp.tourist_advisor.entity.Pov;

public interface CommentRepository extends CrudRepository<Comment, Long> {
	Iterable<Comment> findByPov(Pov pov);
	List<Comment> findAllByPovOrderByPublishDate(Pov pov);
	
}
