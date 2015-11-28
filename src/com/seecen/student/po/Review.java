package com.seecen.student.po;

import java.util.Date;

import com.seecen.system.po.User;

/*
 * 项目评审情况表
 */
public class Review {
	private int id;
	private User userId; // 评审人ID
	private Student sid;// 学生ID
	private Date createDate;// 评审日期
	private String projectName;// 项目名称
	private String projectPhase;// 项目阶段
	private Double suitEtiquetteScore;// 着装礼仪得分
	private Double explainScore;// 项目讲解得分
	private Double replyScore;// 问答得分

	public Review() {}

	public Review(User userId, Student sid, Date createDate,
			String projectName, String projectPhase, Double suitEtiquetteScore,
			Double explainScore, Double replyScore) {
		super();
		this.userId = userId;
		this.sid = sid;
		this.createDate = createDate;
		this.projectName = projectName;
		this.projectPhase = projectPhase;
		this.suitEtiquetteScore = suitEtiquetteScore;
		this.explainScore = explainScore;
		this.replyScore = replyScore;
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

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectPhase() {
		return projectPhase;
	}

	public void setProjectPhase(String projectPhase) {
		this.projectPhase = projectPhase;
	}

	public Double getSuitEtiquetteScore() {
		return suitEtiquetteScore;
	}

	public void setSuitEtiquetteScore(Double suitEtiquetteScore) {
		this.suitEtiquetteScore = suitEtiquetteScore;
	}

	public Double getExplainScore() {
		return explainScore;
	}

	public void setExplainScore(Double explainScore) {
		this.explainScore = explainScore;
	}

	public Double getReplyScore() {
		return replyScore;
	}

	public void setReplyScore(Double replyScore) {
		this.replyScore = replyScore;
	}

}
