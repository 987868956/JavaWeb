package com.seecen.student.po;

import java.util.Date;

import com.seecen.teach.po.Course;

/*
 * 学员信息表
 */
public class Student {
	private int id;
	private String name; // 学生姓名
	private Course classId; // 所属班级
	private String sex; // 性别
	private Date birthDate; // 出生日期
	private String college; // 毕业院校
	private String education; // 学历
	private String major; // 专业
	private String origin; // 籍贯
	private String telephone; // 联系电话
	private Date admissionDate; // 入学时间
	private String IDCard; // 身份证号
	private String note; // 备注

	public Student() {}

	public Student(String name, Course classId, String sex, Date birthDate,
			String college, String education, String major, String origin,
			String telephone, Date admissionDate, String iDCard, String note) {
		this.name = name;
		this.classId = classId;
		this.sex = sex;
		this.birthDate = birthDate;
		this.college = college;
		this.education = education;
		this.major = major;
		this.origin = origin;
		this.telephone = telephone;
		this.admissionDate = admissionDate;
		this.IDCard = iDCard;
		this.note = note;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Course getClassId() {
		return classId;
	}

	public void setClassId(Course classId) {
		this.classId = classId;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public String getCollege() {
		return college;
	}

	public void setCollege(String college) {
		this.college = college;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public Date getAdmissionDate() {
		return admissionDate;
	}

	public void setAdmissionDate(Date admissionDate) {
		this.admissionDate = admissionDate;
	}

	public String getIDCard() {
		return IDCard;
	}

	public void setIDCard(String iDCard) {
		IDCard = iDCard;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
