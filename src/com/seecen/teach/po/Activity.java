package com.seecen.teach.po;

import java.util.Date;
/*
 * 班级活动类
 */
public class Activity {			
	private int id;					//序号
	private Course className;		//班级名称
	private String theme;			//活动主题
	private Date activityTime;		//活动时间
	private String place;			//活动地点

	public Activity() {}
	public Activity(Course className, String theme, Date activityTime,
			String place) {
		super();
		this.className = className;
		this.theme = theme;
		this.activityTime = activityTime;
		this.place = place;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Course getClassName() {
		return className;
	}
	public void setClassName(Course className) {
		this.className = className;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public Date getActivityTime() {
		return activityTime;
	}
	public void setActivityTime(Date activityTime) {
		this.activityTime = activityTime;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	
}
