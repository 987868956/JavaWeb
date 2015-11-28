package com.seecen.market.po;

import java.util.Date;

import com.seecen.system.po.User;

/*
 * 回访
 */
public class Visited {
	private int id;	//id;
	private Customer customer;//	客户
	private User user;//	咨询师
	private String content;//	回访内容
	private String title;//	回访主题
	private Date visitedTime;//	本次回访时间
	private Date nextVisitedTime;//	下次回访时间
	
	
	public Visited(Customer customer, User user, String content, String title,
			Date visitedTime, Date nextVisitedTime) {
		super();
		this.customer = customer;
		this.user = user;
		this.content = content;
		this.title = title;
		this.visitedTime = visitedTime;
		this.nextVisitedTime = nextVisitedTime;
	}


	public Visited() {
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public Customer getCustomer() {
		return customer;
	}


	public void setCustomer(Customer customer) {
		this.customer = customer;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public Date getVisitedTime() {
		return visitedTime;
	}


	public void setVisitedTime(Date visitedTime) {
		this.visitedTime = visitedTime;
	}


	public Date getNextVisitedTime() {
		return nextVisitedTime;
	}


	public void setNextVisitedTime(Date nextVisitedTime) {
		this.nextVisitedTime = nextVisitedTime;
	}


	@Override
	public String toString() {
		return "Visited [id=" + id + ", customer=" + customer + ", user="
				+ user + ", content=" + content + ", title=" + title
				+ ", visitedTime=" + visitedTime + ", nextVisitedTime="
				+ nextVisitedTime + "]";
	}
	
}
