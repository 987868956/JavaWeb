package com.seecen.system.po;

import java.util.Set;

import com.seecen.market.po.Centre;
import com.seecen.market.po.Department;

//用户表


public class User {
	
	private int id;   //用户ID
	 private String userName;  //用户name
	 private String pass;    //用户密码
	 private String status="1";   //用户状态
	 private String sex;     //用户性别
	 private String userTel;   //用户电话
	 private String qq;     //用户QQ
	 private String email;   //用户Email
	 private Role  role;    //用户对应的角色
	 private Department depts;  //部门
	 private Centre centers;   //中心 
	 
	 
	
	public User(String userName, String pass, String sex, String userTel,
			String qq, String email, Role role, Department depts, Centre centers) {
		super();
		this.userName = userName;
		this.pass = pass;
		this.sex = sex;
		this.userTel = userTel;
		this.qq = qq;
		this.email = email;
		this.role = role;
		this.depts = depts;
		this.centers = centers;
	}
	
	 
	
	public User() {
		
	}
   
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
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
	
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public Department getDepts() {
		return depts;
	}
	public void setDepts(Department depts) {
		this.depts = depts;
	}
	public Centre getCenters() {
		return centers;
	}
	public void setCenters(Centre centers) {
		this.centers = centers;
	}
	
	@Override
	public String toString() {
		return "User [centers=" + centers + ", depts=" + depts + ", email="
				+ email + ", id=" + id + ", pass=" + pass + ", qq=" + qq
				+ ", role=" + role + ", sex=" + sex + ", status=" + status
				+ ", userName=" + userName + ", userTel=" + userTel + "]";
	}
	 
	 
	 
	 
	 

}