package com.seecen.utils;

public class City {
	private int cid;
	private String cityName;
	private Province proId;

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public Province getProId() {
		return proId;
	}

	public void setProId(Province proId) {
		this.proId = proId;
	}

	@Override
	public String toString() {
		return "City [cId=" + cid + ", cityName=" + cityName + ", proId="
				+ proId + "]";
	}

}
