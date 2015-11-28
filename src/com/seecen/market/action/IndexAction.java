package com.seecen.market.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

import com.seecen.action.BaseAction;
import com.seecen.market.dao.CustomerDao;
import com.seecen.market.po.Customer;

public class IndexAction extends BaseAction{
	private CustomerDao customerDao;
	
	

	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}



	@Override
	public String execute() throws Exception {
		List list = new ArrayList();
		List list2 = new ArrayList();
		list = customerDao.findFirst(1, 1, 5, 4);
		list2 = customerDao.findMonth(1, 1, 5, 4);
		this.request.setAttribute("items", list);
		this.request.setAttribute("Mitems", list2);
		//待跟进
		Map filter1 = new HashMap();
		filter1.put("status", "1");
		int readySize = customerDao.findAll(Customer.class, filter1).size();
		this.request.setAttribute("readySize", readySize);
		//已上门
		Map filter2 = new HashMap();
		filter2.put("status", "3");
		int doorSize = customerDao.findAll(Customer.class, filter1).size();
		this.request.setAttribute("doorSize", doorSize);
	
		return SUCCESS;
	}
	public String picture() throws Exception {
		
		List list = new ArrayList();
		List list2 = new ArrayList();
		list = customerDao.findFirst(1, 1, 5, 4);
		list2 = customerDao.findMonth(1, 1, 5, 4);
		this.request.setAttribute("items", list);
		this.request.setAttribute("Mitems", list2);
		//待跟进
		Map filter1 = new HashMap();
		filter1.put("status", "1");
		int readySize = customerDao.findAll(Customer.class, filter1).size();
		//已上门
		Map filter2 = new HashMap();
		filter2.put("status", "3");
		int doorSize = customerDao.findAll(Customer.class, filter2).size();
		//未上门
		Map filter3 = new HashMap();
		filter3.put("status", "2");
		int outDoor = customerDao.findAll(Customer.class, filter3).size();
		//已报名
		Map filter4 = new HashMap();
		filter4.put("status", "4");
		int report = customerDao.findAll(Customer.class, filter4).size();
		System.out.println(" ================ index picture() ================ ");
		DefaultPieDataset data=new DefaultPieDataset();
		
		data.setValue("未跟进", readySize);
		data.setValue("未上门", outDoor);
		data.setValue("已上门", doorSize);
		data.setValue("已报名", report);
		JFreeChart chart=ChartFactory.createPieChart("班级人员分布图", data, true, false, false);
		try {
			ChartUtilities.writeChartAsJPEG(ServletActionContext.getResponse().getOutputStream(), chart, 350, 250);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
		
	}


}
