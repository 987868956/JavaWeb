package com.seecen.market.po;

import java.util.Date;

import com.seecen.system.po.User;

/*
 * 意向客户
 */
public class Customer {
	private int id;            
	private String name;               //客户姓名
	private String sex;               //客户性别
	private Date birthday;             //生日
	private String telephone;          //电话
	private String qq;                 //QQ
	private String email;               //Email
	private String schoolName;          //毕业学校
	private String collegeName;         //毕业学院
	private Date reportTime = new Date();            //报名时间
	private Date createTime = new Date();            //创建时间 
	private String address;             //住址
	private String consultContent;     //咨询内容
	private String major;              //专业
	private User user;  ///咨询师
	private String location;        //所在城市
	private Centre centre;   //CentreID;    所在中心
	private Channel channel ; //channelID;  信息渠道
	private String status="1";               //状态   1未跟进 2已跟进-待上门 3已跟进-已上门 4已跟进-已报名 5已跟进-已就业
	private String intention;      //意向   1积极  2考虑  3拒绝 4
	private Date modifyTime = new Date();                  //修改时间
	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public Customer(){
		
	}
	
	 
	public Customer(String name, String sex, Date birthday, String telephone,
			String qq, String email, String schoolName, String collegeName,
			Date reportTime, Date createTime, String address,
			String consultContent, String major, User user, String location,
			Centre centre, Channel channel, String status, String intention,
			Date modifyTime) {
		super();
		this.name = name;
		this.sex = sex;
		this.birthday = birthday;
		this.telephone = telephone;
		this.qq = qq;
		this.email = email;
		this.schoolName = schoolName;
		this.collegeName = collegeName;
		this.reportTime = reportTime;
		this.createTime = createTime;
		this.address = address;
		this.consultContent = consultContent;
		this.major = major;
		this.user = user;
		this.location = location;
		this.centre = centre;
		this.channel = channel;
		this.status = status;
		this.intention = intention;
		this.modifyTime = modifyTime;
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
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getCollegeName() {
		return collegeName;
	}
	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
	public Date getReportTime() {
		return reportTime;
	}
	public void setReportTime(Date reportTime) {
		this.reportTime = reportTime;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getConsultContent() {
		return consultContent;
	}
	public void setConsultContent(String consultContent) {
		this.consultContent = consultContent;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	public Centre getCentre() {
		return centre;
	}
	public void setCentre(Centre centre) {
		this.centre = centre;
	}
	public Channel getChannel() {
		return channel;
	}
	public void setChannel(Channel channel) {
		this.channel = channel;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIntention() {
		return intention;
	}
	public void setIntention(String intention) {
		this.intention = intention;
	}
	
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	@Override
	public String toString() {
		return "Customer [id=" + id + ", name=" + name + ", sex=" + sex
				+ ", birthday=" + birthday + ", telephone=" + telephone
				+ ", qq=" + qq + ", email=" + email + ", schoolName="
				+ schoolName + ", collegeName=" + collegeName + ", reportTime="
				+ reportTime + ", createTime=" + createTime + ", address="
				+ address + ", consultContent=" + consultContent + ", major="
				+ major + ", user=" + user + ", location=" + location
				+ ", centre=" + centre + ", channel=" + channel + ", status="
				+ status + ", intention=" + intention + ", modifyTime="
				+ modifyTime + "]";
	}
	

}
