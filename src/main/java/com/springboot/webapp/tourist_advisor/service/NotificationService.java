package com.springboot.webapp.tourist_advisor.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;



@Service
public class NotificationService {
	@Value("${spring.mail.username}")
	private String mailEmail;
//
//	private final JavaMailSender javaMailSender;
//
//	public NotificationService(JavaMailSender javaMailSender) {
//		this.javaMailSender = javaMailSender;
//	}

	public void sendNotification(String emailTo,String subject,String message) throws MailException {
//		SimpleMailMessage mail = new SimpleMailMessage();
//
//
//		mail.setFrom(mailEmail);
//		mail.setTo(emailTo);
//		mail.setSubject(subject);
//		mail.setText(message);

//		javaMailSender.send(mail);
	}
}
