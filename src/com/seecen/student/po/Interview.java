package com.seecen.student.po;

import java.util.Date;

import com.seecen.system.po.User;

/*
 * 模拟面试情况表
 */
public class Interview {
	private int id;
	private User userId;// 面试官ID
	private Student sid;// 学生ID
	private Date createDate;// 模拟面试日期
	private String situation;// 面试情况
	private String result;// 面试得分

	public Interview() {}

	public Interview(User userId, Student sid, Date createDate,
			String situation, String result) {
		super();
		this.userId = userId;
		this.sid = sid;
		this.createDate = createDate;
		this.situation = situation;
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

	public String getSituation() {
		return situation;
	}

	public void setSituation(String situation) {
		this.situation = situation;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

}
