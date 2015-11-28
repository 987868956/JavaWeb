package com.seecen.teach.vo;



public class CourseVo {
	private int id;				//班级序号
	private String className;	//班级名称
	private String openTimestr;		//开班时间
	private int count;			//人数
	private int lecturerid;		//讲师
	private int developid;		//职业发展老师
	private String classroom;	//教室
	private int centreid;		//所属中心
	private String status;		//阶段状态
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
	public String getOpenTimestr() {
		return openTimestr;
	}
	public void setOpenTimestr(String openTimestr) {
		this.openTimestr = openTimestr;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getLecturerid() {
		return lecturerid;
	}
	public void setLecturerid(int lecturerid) {
		this.lecturerid = lecturerid;
	}
	public int getDevelopid() {
		return developid;
	}
	public void setDevelopid(int developid) {
		this.developid = developid;
	}
	public String getClassroom() {
		return classroom;
	}
	public void setClassroom(String classroom) {
		this.classroom = classroom;
	}
	public int getCentreid() {
		return centreid;
	}
	public void setCentreid(int centreid) {
		this.centreid = centreid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
