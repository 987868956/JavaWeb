package com.seecen.student.po;

import java.util.Date;

import com.seecen.system.po.User;

/*
 * 考勤表
 */
public class Attendance {
	private int id;
	private User userId; // 考勤人ID
	private Student sid; // 学生ID
	private Date createDate; // 考勤日期
	private String result = "正常";// 考勤结果

	public Attendance() {}

	public Attendance(User userId, Student sid, Date createDate,
			String result) {
		this.userId = userId;
		this.sid = sid;
		this.createDate = createDate;
		this.result = result;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUserId() {
		return userId;
	}

	public void setUserId(User userId) {
		this.userId = userId;
	}

	public Student getSid() {
		return sid;
	}

	public void setSid(Student sid) {
		this.sid = sid;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

}
