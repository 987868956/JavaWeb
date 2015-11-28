package com.seecen.system.po;

import java.io.Serializable;
import java.util.Date;
//日志表
@SuppressWarnings("serial")
public class Log implements Serializable{
	
	private int id;
	private User user;
	private String event;
	private Date logDate = new Date();
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public Date getLogDate() {
		return logDate;
	}
	public void setLogDate(Date logDate) {
		this.logDate = logDate;
	}
	
}
