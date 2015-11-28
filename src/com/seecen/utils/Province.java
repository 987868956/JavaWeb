package com.seecen.utils;

public class Province {
	private int proId;
	private String proName;
	public int getProId() {
		return proId;
	}
	public void setProId(int proId) {
		this.proId = proId;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	@Override
	public String toString() {
		return "Province [proId=" + proId + ", proName=" + proName + "]";
	}
	
}
