package com.seecen.teach.po;

import java.util.Date;

import com.seecen.market.po.Centre;
import com.seecen.system.po.User;
/*
 * 班级类
 */
public class Course {			
	private int id;				//班级序号
	private String className;	//班级名称
	private Date openTime;		//开班时间
	private int count;			//人数
	private User lecturer;		//讲师
	private User develop;		//职业发展老师
	private String classroom;	//教室
	private Centre centre;		//所属中心
	private String status;		//阶段状态
	

	public Course() {}
	public Course(String className, Date openTime, int count, User lecturer,
			User develop, String classroom, Centre centre, String status) {
	
		this.className = className;
		this.openTime = openTime;
		this.count = count;
		this.lecturer = lecturer;
		this.develop = develop;
		this.classroom = classroom;
		this.centre = centre;
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public Date getOpenTime() {
		return openTime;
	}
	public void setOpenTime(Date openTime) {
		this.openTime = openTime;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public User getLecturer() {
		return lecturer;
	}
	public void setLecturer(User lecturer) {
		this.lecturer = lecturer;
	}
	public User getDevelop() {
		return develop;
	}
	public void setDevelop(User develop) {
		this.develop = develop;
	}
	public String getClassroom() {
		return classroom;
	}
	public void setClassroom(String classroom) {
		this.classroom = classroom;
	}
	
	public Centre getCentre() {
		return centre;
	}
	public void setCentre(Centre centre) {
		this.centre = centre;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}