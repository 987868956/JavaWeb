package com.seecen.market.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.market.dao.VisitedDao;
import com.seecen.market.po.Customer;
import com.seecen.market.po.Visited;
import com.seecen.system.po.User;

public class VisitedAction extends BaseAction implements ModelDriven<Visited> {
	private Visited visited;
	private VisitedDao visitedDao;
	@Override
	public String execute() throws Exception {
		List visiteds = new ArrayList();
		Map filter = new HashMap();
		String name = this.request.getParameter("CName");
		String address = this.request.getParameter("CAddress");
		if(name!=null){
			filter.put("cname", name.trim());
		}
		if(address!=null){
			filter.put("caddress", address.trim());
		}
		String currentPage = this.request.getParameter("currentPage");
		int current = 0;
		if(currentPage!=null){
			current = Integer.parseInt(currentPage);
			if(current==0){
				current = 1;
			}
			System.out.println(current);
		}else{
			current = 1;
		}
		int size = visitedDao.findAll(Visited.class).size();
		visiteds = visitedDao.findAll(Visited.class, filter, current, 5);
		System.out.println(visiteds.size());
		this.request.setAttribute("currentPage", current);
		this.request.setAttribute("size", size);
		this.request.setAttribute("visiteds", visiteds);
		return SUCCESS;

	}

	public String add() throws Exception {
		String customerId = this.request.getParameter("customerId");
		String consulterId = this.request.getParameter("consulterId");
		int customerID = Integer.parseInt(customerId);
		int consulterID = Integer.parseInt(consulterId);
		Customer cus = (Customer) visitedDao.findObjectById(Customer.class, customerID);
		User user = (User) visitedDao.findObjectById(User.class, consulterID);
		visited.setCustomer(cus);
		visited.setUser(user);
		visitedDao.addObject(visited);
		return "listAll";

	}










	public void setVisitedDao(VisitedDao visitedDao) {
		this.visitedDao = visitedDao;
	}












	public Visited getModel() {
		visited = new Visited();
		return visited;
	}

}
