package com.springboot.webapp.tourist_advisor.entity;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotBlank;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "comments")
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(length = 2048,name = "text")
	@NotBlank(message = "Text cannot be empty")
	private String text;
	
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "publishDate")
	private java.util.Date publishDate;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "pov_id")
	private Pov pov;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User author;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "prnt_comment")
	private Comment prnt_comment;
	
	@OneToMany(mappedBy = "prnt_comment",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
	private Set<Comment> comments = null;
	
	public Comment() {
		// TODO Auto-generated constructor stub
	}
	
	public boolean noReply() {
		return	comments.size()<1?true:false;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public java.util.Date getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(java.util.Date publishDate) {
		this.publishDate = publishDate;
	}

	public Pov getPov() {
		return pov;
	}

	public void setPov(Pov pov) {
		this.pov = pov;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public Comment getPrnt_comment() {
		return prnt_comment;
	}

	public void setPrnt_comment(Comment prnt_comment) {
		this.prnt_comment = prnt_comment;
	}

	public Set<Comment> getComments() {
		return comments;
	}

	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}
	
	
	
	
}
