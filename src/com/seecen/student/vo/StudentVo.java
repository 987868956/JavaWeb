package com.seecen.student.vo;

/*
 * StudentVo是Student类的值对象
 * 			VO(Value Object)是值对象，精确点讲它是业务对象，是存活在业务层的，是业务逻辑使用的，它存活的目的就是为数据提供一个生存的地方
 * 			PO(Persisent Object)则是有状态的，每个属性代表其当前的状态。它是物理数据的对象表示。
 * 				使用它，可以使我们的程序与物理数据解耦，并且可以简化对象数据与物理数据之间的转换
 */
public class StudentVo {
	private int id;
	private String name; // 学生姓名
	private int classId; // 所属班级
	private String sex; // 性别
	private String birthDateStr; // 出生日期
	private String college; // 毕业院校
	private String education; // 学历
	private String major; // 专业
	private String origin; // 籍贯
	private String telephone; // 联系电话
	private String admissionDateStr; // 入学时间
	private String IDCard; // 身份证号
	private String note; // 备注

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

	public int getClassId() {
		return classId;
	}

	public void setClassId(int classId) {
		this.classId = classId;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirthDateStr() {
		return birthDateStr;
	}

	public void setBirthDateStr(String birthDateStr) {
		this.birthDateStr = birthDateStr;
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

	public String getAdmissionDateStr() {
		return admissionDateStr;
	}

	public void setAdmissionDateStr(String admissionDateStr) {
		this.admissionDateStr = admissionDateStr;
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
