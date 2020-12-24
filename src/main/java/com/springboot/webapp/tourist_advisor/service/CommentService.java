package com.springboot.webapp.tourist_advisor.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.springboot.webapp.tourist_advisor.entity.Comment;
import com.springboot.webapp.tourist_advisor.entity.Pov;
import com.springboot.webapp.tourist_advisor.repository.CommentRepository;

@Service
public class CommentService {
	@Autowired
	private CommentRepository commentRepository;
	
	public Iterable<Comment> findAll() {
		return commentRepository.findAll(); 
	}
	public void save(Comment comment) {
		commentRepository.save(comment);
	}
	public Iterable<Comment> findByPov(Pov pov) {
		return commentRepository.findByPov(pov); 
	}
	public Comment findById(Long id) {
		
		Optional<Comment> result = commentRepository.findById(id);
		
		Comment comment = null;
		
		if(result.isPresent()) {
			comment = result.get();
		}else {
			throw new RuntimeException("Comment is not found - " + id);
		}
		return comment;
	}
	
	public void deleteById(Long id) {
		commentRepository.deleteById(id);
	}
	
	public List<Comment> findAllByPovOrderByPublishDate(Pov pov) {
		return commentRepository.findAllByPovOrderByPublishDate(pov);
	}

}
