package com.seecen.system.po;

import java.io.Serializable;

@SuppressWarnings("serial")
public class RoleAuthDoublePk implements Serializable{
	
	 private int moduleId;
	 private int roleId;
	 
	public RoleAuthDoublePk(int moduleId, int roleId) {
		super();
		this.moduleId = moduleId;
		this.roleId = roleId;
	}
	
	public RoleAuthDoublePk() {
		
	}


	
	
	public int getModuleId(){
		return moduleId;
	}
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	 
	 
}
