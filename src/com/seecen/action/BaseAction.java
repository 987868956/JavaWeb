package com.seecen.action;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements ServletRequestAware {
	public HttpServletRequest request;
	public HttpServletResponse response;

	public void setServletRequest(HttpServletRequest request) {
		this.request = (HttpServletRequest) request;
		this.response = ServletActionContext.getResponse();
		try {
			this.request.setCharacterEncoding("utf-8");
			this.response.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			
		}
	}

}
