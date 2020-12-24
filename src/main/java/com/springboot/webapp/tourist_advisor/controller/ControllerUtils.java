package com.springboot.webapp.tourist_advisor.controller;

import java.io.File; 
import java.io.IOException;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.multipart.MultipartFile;

public class ControllerUtils {
	 static String uploadFile(MultipartFile file, String uploadPath) throws IllegalStateException, IOException{
		if( file !=null && !file.getOriginalFilename().isEmpty()) {
			File uploadDir = new File(uploadPath);
			
			if(!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			
			String uuidFile=UUID.randomUUID().toString();
			String resultFileName = uuidFile+"."+file.getOriginalFilename();

			file.transferTo(new File(uploadPath + "/" + resultFileName));
			
			return  resultFileName;
		}
		
		return null;
	}
	 
	 static Map<String,String> getErrors(BindingResult bindingResult){
	        Collector<FieldError, ? , Map<String,String>> collector = Collectors.toMap(
	                fieldError -> fieldError.getField() + "Error",
	                FieldError::getDefaultMessage
	        );
	        return bindingResult.getFieldErrors().stream().collect(collector);
	    }

}
