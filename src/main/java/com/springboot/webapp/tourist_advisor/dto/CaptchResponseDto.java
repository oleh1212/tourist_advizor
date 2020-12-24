package com.springboot.webapp.tourist_advisor.dto;

import java.util.Set;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties
public class CaptchResponseDto {
	private boolean success;
	
	@JsonAlias("error-codes")
	private Set<String> errorCodes;

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Set<String> getErrorCodes() {
		return errorCodes;
	}

	public void setErrorCodes(Set<String> errorCodes) {
		this.errorCodes = errorCodes;
	}
	
	
}
