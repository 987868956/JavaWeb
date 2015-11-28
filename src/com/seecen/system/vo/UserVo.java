package com.seecen.system.vo;

import com.seecen.market.po.Centre;
import com.seecen.market.po.Department;
import com.seecen.system.po.Role;

public class UserVo {
	private int id;   //用户ID
	 private String userName;  //用户name
	 private String pass;    //用户密码
	 private String status="1";   //用户状态
	 private String sex;     //用户性别
	 private String userTel;   //用户电话
	 private String qq;     //用户QQ
	 private String email;   //用户Email
	 private int  roleId;    //用户对应的角色
	 private int deptId;  //部门
	 private int centerId;   //中心 

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
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public int getDeptId() {
		return deptId;
	}
	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}
	public int getCenterId() {
		return centerId;
	}
	public void setCenterId(int centerId) {
		this.centerId = centerId;
	}
	

}
