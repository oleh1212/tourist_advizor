package com.springboot.webapp.tourist_advisor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.webapp.tourist_advisor.entity.PovPhotos;
import com.springboot.webapp.tourist_advisor.repository.PovPhotosRepository;

@Service
public class PovPhotosService {
	@Autowired
	private PovPhotosRepository povPhotosRepository;
	
	public void save(PovPhotos povPhotos) {
		povPhotosRepository.save(povPhotos);
	}
	public void deleteById(Long id) {
		povPhotosRepository.deleteById(id);
	}
}
