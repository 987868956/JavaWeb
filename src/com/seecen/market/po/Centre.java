package com.seecen.market.po;

import java.util.Date;

/*
 *  教学中心
 */
public class Centre {
	private int cid;
	private String cname;
	private String caddress;
	private String ctelephone;
	private String status="1";
	private String homePage;
	private Date modifyTime = new Date();
	public Centre() {
		
	}
	
	
	public Centre(String cname, String caddress, String ctelephone,
			String status, String homePage, Date modifyTime) {
		super();
		this.cname = cname;
		this.caddress = caddress;
		this.ctelephone = ctelephone;
		this.status = status;
		this.homePage = homePage;
		this.modifyTime = modifyTime;
	}


	public Date getModifyTime() {
		return modifyTime;
	}


	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}


	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCaddress() {
		return caddress;
	}
	public void setCaddress(String caddress) {
		this.caddress = caddress;
	}
	public String getCtelephone() {
		return ctelephone;
	}
	public void setCtelephone(String ctelephone) {
		this.ctelephone = ctelephone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getHomePage() {
		return homePage;
	}
	public void setHomePage(String homePage) {
		this.homePage = homePage;
	}


	@Override
	public String toString() {
		return "Centre [cid=" + cid + ", cname=" + cname + ", caddress="
				+ caddress + ", ctelephone=" + ctelephone + ", status="
				+ status + ", homePage=" + homePage + ", modifyTime="
				+ modifyTime + "]";
	}

}
