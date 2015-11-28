package com.seecen.market.po;

import java.util.Date;
import java.util.Set;

import com.seecen.system.po.User;


/*
 * 部门表
 */
public class Department {
	private int deptid;
	private String deptname;    //部门名称
	private String deptAddress;   //部门地址
	private String status="1";        //部门状态
	private Centre centre;        //所属中心
	private Date modifyTime = new Date();
	
	
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public Department() {
		super();
	}
	
	public Department(String deptname, String deptAddress, String status,
			Centre centre, Date modifyTime) {
		super();
		this.deptname = deptname;
		this.deptAddress = deptAddress;
		this.status = status;
		this.centre = centre;
		this.modifyTime = modifyTime;
	}
	public int getDeptid() {
		return deptid;
	}
	public void setDeptid(int deptid) {
		this.deptid = deptid;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getDeptAddress() {
		return deptAddress;
	}
	public void setDeptAddress(String deptAddress) {
		this.deptAddress = deptAddress;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Centre getCentre() {
		return centre;
	}
	public void setCentre(Centre centre) {
		this.centre = centre;
	}
	@Override
	public String toString() {
		return "Department [deptid=" + deptid + ", deptname=" + deptname
				+ ", deptAddress=" + deptAddress + ", status=" + status
				+ ", centre=" + centre + ", modifyTime=" + modifyTime + "]";
	}
	
	
	
}
