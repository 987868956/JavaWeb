package com.seecen.student.po;

import java.util.Date;

import com.seecen.system.po.User;

/*
 * 面谈记录表
 */
public class Consult {
	private int id;
	private User userId;// 面谈职业发展老师ID
	private Student sid;// 学生ID
	private Date createDate;// 面谈日期
	private String content;// 面谈内容及情况

	public Consult() {}

	public Consult(User userId, Student sid, Date createDate, String content) {
		super();
		this.userId = userId;
		this.sid = sid;
		this.createDate = createDate;
		this.content = content;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
