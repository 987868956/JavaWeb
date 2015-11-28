package com.seecen.market.po;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/*
 * 渠道
 * 更新父模块的status时需要将子模块的status修改
 */
public class Channel {
	private int id;                  //	id
	private String name;             //	渠道名称
	private Channel parentChannel;    //	父渠道ID
	private Set<Channel> sonChannel = new HashSet<Channel>();   //子渠道
	private String status="1";           //	状态
	private Date modifyTime = new Date();
	
	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public Channel() {
	}
	
	

	public Channel(String name, Channel parentChannel, String status,
			Date modifyTime) {
		super();
		this.name = name;
		this.parentChannel = parentChannel;
		this.status = status;
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
	public Channel getParentChannel() {
		return parentChannel;
	}
	public void setParentChannel(Channel parentChannel) {
		this.parentChannel = parentChannel;
	}
	public Set<Channel> getSonChannel() {
		return sonChannel;
	}
	public void setSonChannel(Set<Channel> sonChannel) {
		this.sonChannel = sonChannel;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "Channel [id=" + id + ", name=" + name + ", parentChannel="
				+ parentChannel + ", sonChannel=" + sonChannel + ", status="
				+ status + ", modifyTime=" + modifyTime + "]";
	}
	
}
