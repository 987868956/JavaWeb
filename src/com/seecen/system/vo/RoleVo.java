package com.seecen.system.vo;

public class RoleVo {
	
	private int id;  //角色ID
	 private String name;  //角色名称（比如经理   ，讲师）
	 private String status="1";  //角色状态    默认值为一
	 private int  moudleId;   //角色对应的模块id
	 
	 
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getMoudleId() {
		return moudleId;
	}
	public void setMoudleId(int moudleId) {
		this.moudleId = moudleId;
	}
	

}
