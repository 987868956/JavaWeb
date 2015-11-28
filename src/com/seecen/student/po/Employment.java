package com.seecen.student.po;

import java.util.Date;

/*
 * 就业情况表
 */
public class Employment {
	private int id;
	private Student sid; // 学员ID
	private String workUnit; // 工作单位
	private String post; // 职位
	private String workAddress; // 工作地址
	private Date workDate; // 就业日期
	private Double salary; // 就业薪资

	public Employment() {}

	public Employment(Student sid, String workUnit, String post,
			String workAddress, Date workDate, Double salary) {
		super();
		this.sid = sid;
		this.workUnit = workUnit;
		this.post = post;
		this.workAddress = workAddress;
		this.workDate = workDate;
		this.salary = salary;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Student getSid() {
		return sid;
	}

	public void setSid(Student sid) {
		this.sid = sid;
	}

	public String getWorkUnit() {
		return workUnit;
	}

	public void setWorkUnit(String workUnit) {
		this.workUnit = workUnit;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getWorkAddress() {
		return workAddress;
	}

	public void setWorkAddress(String workAddress) {
		this.workAddress = workAddress;
	}

	public Date getWorkDate() {
		return workDate;
	}

	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

}
