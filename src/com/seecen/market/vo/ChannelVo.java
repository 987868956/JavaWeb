package com.seecen.market.vo;



public class ChannelVo {
	private int id;                  //	id
	private String name;             //	渠道名称
	private int  parentChannel;    //	父渠道ID
	private String parentName;
	private String status="1";           //	状态
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
	
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public int getParentChannel() {
		return parentChannel;
	}
	public void setParentChannel(int parentChannel) {
		this.parentChannel = parentChannel;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "ChannelVo [id=" + id + ", name=" + name + ", parentChannel="
				+ parentChannel + ", status=" + status + "]";
	}
	
}
