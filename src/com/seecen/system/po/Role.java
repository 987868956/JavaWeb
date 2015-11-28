package com.seecen.system.po;

import java.io.Serializable;
import java.util.Set;

//角色表类

@SuppressWarnings("serial")
public class Role implements Serializable{         
	
	
	
	private int id;  //角色ID
	 private String name;  //角色名称（比如经理   ，讲师）
	 private String status="1";  //角色状态    默认值为一
	 private Set<Moudle>  moudles;   //角色对应的模块
	 
	public Role(String name, String status, Set<Moudle> moudles) {
		super();
		this.name = name;
		this.status = status;
		this.moudles = moudles;
	}
	public Role() {
		
	}




	public int getId(){
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
	public Set<Moudle> getMoudles() {
		return moudles;
	}
	public void setMoudles(Set<Moudle> moudles) {
		this.moudles = moudles;
	}
	 

	@Override
	public String toString() {
		return "Role [id=" + id + ", name=" + name + ", status=" + status + "]";
	}
	 
}
