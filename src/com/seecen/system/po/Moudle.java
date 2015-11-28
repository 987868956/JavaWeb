package com.seecen.system.po;

import java.io.Serializable;
import java.util.Set;

// Moudle  系统模块表


@SuppressWarnings("serial")
public class Moudle implements Serializable{
	
//模块与子模块一对多
	
	
	
	private int id;   //模块ID
    private String name;  //模块名称
    private String url;    //模块路径
    private String isson;   //判断是否是子模块  0表示是父模块   1子模块
    private String status="1";   //模块状态
    private Moudle parentMoudle;  //父类模块
    private Set<Moudle> sonMoudles; //子类模块
    private Set<Role>  roles ;  //模块角色
	
    
  
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	public String getIsson() {
		return isson;
	}
	public void setIsson(String isson) {
		this.isson = isson;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Moudle getParentMoudle() {
		return parentMoudle;
	}
	public void setParentMoudle(Moudle parentMoudle) {
		this.parentMoudle = parentMoudle;
	}
	public Set<Moudle> getSonMoudles() {
		return sonMoudles;
	}
	public void setSonMoudles(Set<Moudle> sonMoudles) {
		this.sonMoudles = sonMoudles;
	}
	    
}