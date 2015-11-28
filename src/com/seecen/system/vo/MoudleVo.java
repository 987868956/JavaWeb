package com.seecen.system.vo;



public class MoudleVo {
	
	
	private int id;   //模块ID
    private String name;  //模块名称
    private String url;    //模块路径
    private String isson;   //判断是否是子模块  0表示是父模块   1子模块
    private String status="1";   //模块状态
    private int parentId;  //父类模块id
	
	
	
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
	public String getIsson() {
		return isson;
	}
	public void setIsson(String isson) {
		this.isson = isson;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	
    
    

}
