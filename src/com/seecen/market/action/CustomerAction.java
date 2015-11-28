package com.seecen.market.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.market.dao.CustomerDao;
import com.seecen.market.po.Centre;
import com.seecen.market.po.Channel;
import com.seecen.market.po.Customer;
import com.seecen.market.po.Visited;
import com.seecen.system.po.User;
import com.seecen.utils.City;

public class CustomerAction extends BaseAction implements ModelDriven<Customer> {
	private Customer customer;
	private CustomerDao customerDao;

	@Override
	public String execute() throws Exception {
		List customers = new ArrayList();
		Map<String, String> filter = new HashMap<String, String>();
		this.request.setCharacterEncoding("utf-8");
		this.response.setCharacterEncoding("utf-8");
		String Cname =request.getParameter("Cname");
		String CschoolName = request.getParameter("CschoolName");
		String Cintention = request.getParameter("Cintention");
		if (Cname != null) {
			filter.put("name", Cname.trim());
			this.request.setAttribute("Cname", Cname);
		}
		if (CschoolName != null) {
			filter.put("schoolName", CschoolName.trim());
			this.request.setAttribute("CschoolName", CschoolName);
		}
	
		String currentPage = this.request.getParameter("currentPage");
		int current = 0;
		if (currentPage != null) {
			current = Integer.parseInt(currentPage);
			if (current == 0) {
				current = 1;
			}

		} else {
			current = 1;
		}
		
		Map filter2 = new HashMap();
		filter2.put("status", "1");
		
		
		int size = customerDao.findAll(Customer.class,filter).size();
		customers = customerDao.findAll(Customer.class, filter, current, 5);
		int totalPage=0;
		if(size % 5==0){
			totalPage = (size / 5) ;
		}else{
			totalPage = (size / 5) + 1;
		}
		
		for (Object c : customers) {
			Customer con = new Customer();
			con = (Customer) c;
		}
		List<Channel> channels = customerDao.findAll(Channel.class, filter2);
		List<User> users = customerDao.findAll(User.class, filter2);
		List<Centre> centres = customerDao.findAll(Centre.class, filter2);
		List consulters = customerDao.findUserByRole("咨询师");
		
		this.request.setAttribute("consulters", consulters);
		this.request.setAttribute("centres", centres);
		this.request.setAttribute("channels", channels);
		this.request.setAttribute("users", users);
		this.request.setAttribute("totalPage", totalPage);
		this.request.setAttribute("currentPage", current);
		this.request.setAttribute("size", size);
		this.request.setAttribute("customers", customers);
		return SUCCESS;
	}

	public String add() throws Exception {
		String channel = this.request.getParameter("channelId");
		String centre = this.request.getParameter("centreId");
		String user = this.request.getParameter("userId");
		String locationID = this.request.getParameter("locationID");
		int channelId = Integer.parseInt(channel);
		int centreId = Integer.parseInt(centre);
		int userId = Integer.parseInt(user);
		int locationId = Integer.parseInt(locationID);
		Channel chan = (Channel) customerDao.findObjectById(Channel.class,
				channelId);
		Centre cent = (Centre) customerDao.findObjectById(Centre.class,
				centreId);
		User use = (User) customerDao.findObjectById(User.class, userId);
		City city = (City) customerDao.findObjectById(City.class, locationId);
		customer.setChannel(chan);
		customer.setCentre(cent);
		customer.setUser(use);
		customer.setLocation(city.getCityName());
		customerDao.addObject(customer);
		return "listAll";
	}

	public String update() throws Exception {
		System.out.println(customer);
		String channelID = this.request.getParameter("channelID");
		String centreID = this.request.getParameter("centreID");
		String userID = this.request.getParameter("userID");
		int channelId = Integer.parseInt(channelID);
		int centreId = Integer.parseInt(centreID);
		int userId = Integer.parseInt(userID);
		Channel channel = (Channel) customerDao.findObjectById(Channel.class,
				channelId);
		Centre centre = (Centre) customerDao.findObjectById(Centre.class,
				centreId);
		User user = (User) customerDao.findObjectById(User.class, userId);
//		CustomerVo vo = new CustomerVo();
//		BeanUtils.copyProperties(vo, customer);
//		vo.setCentreId(centreId);
//		vo.setChannelId(channelId);
//		vo.setUserId(userId);
		customer.setCentre(centre);
		customer.setChannel(channel);
		customer.setUser(user);
		customerDao.updateObject(customer);

		return "listAll";

	}

	public String delete() throws Exception {
		String cusID = this.request.getParameter("cusID");
		int customerId = Integer.parseInt(cusID);
		customerDao.deleteObject(Customer.class, customerId);
		return "listAll";

	}
	public String findProvince() throws Exception {
		System.out.println("*******************");
		List provinces = customerDao.findAllProvince();
		PrintWriter out=response.getWriter();
		JSONObject obj=new JSONObject();
		if(provinces!=null){
			obj.element("result", 0);
		}else{
			obj.element("result", 1);
		}
		obj.element("province", provinces);
		out.write(obj.toString());
		System.out.println(obj.toString());
		out.flush();
		return null;
	}
	public String findCity() throws Exception {
		
		String proID = this.request.getParameter("pid");
		int pid = Integer.parseInt(proID);
		List citys = customerDao.findCityByPID(pid);
		PrintWriter out=response.getWriter();
		JSONObject obj=new JSONObject();
		if(citys!=null){
			obj.element("result", 0);
		}else{
			obj.element("result", 1);
		}
		obj.element("citys", citys);
		out.write(obj.toString());
		System.out.println(obj.toString());
		out.flush();
		return null;
	}
	
	
	public String getByID() throws Exception {
		String cuId = this.request.getParameter("cusID");
		int id = Integer.parseInt(cuId);
		Customer cus = (Customer) customerDao
				.findObjectById(Customer.class, id);
		Map filter2 = new HashMap();
		filter2.put("status", "1");
		List channels = customerDao.findAll(Channel.class, filter2);
		List users = customerDao.findAll(User.class, filter2);
		List centres = customerDao.findAll(Centre.class, filter2);
		List consulters = customerDao.findUserByRole("主管2");
		this.request.setAttribute("consulters", consulters);
		this.request.setAttribute("centres", centres);
		this.request.setAttribute("channels", channels);
		this.request.setAttribute("users", users);
		this.request.setAttribute("cus", cus);
		
		//*******************************
		List visiteds = new ArrayList();
		
		String name = this.request.getParameter("CName");
		String address = this.request.getParameter("CAddress");
		
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
		
		Map filters = new HashMap();
		filters.put("customer", cus.getId());
		int size = customerDao.findVisitedByRole(cus.getId(),1,9999).size();
		int totalPage=0;
		if(size % 5==0){
			totalPage = (size / 5) ;
		}else{
			totalPage = (size / 5) + 1;
		}
		Map filter = new HashMap();
		visiteds = customerDao.findVisitedByRole(cus.getId() ,current, 5);
		List newVisited = new ArrayList();
		if(visiteds.size()!=0){
			for(Object object:visiteds){
				Visited vis = new Visited();
				vis  = (Visited) object;
				if(vis.getCustomer().getId()==cus.getId()){
					newVisited.add(vis);
				}
			}
		}else{
		
		}
			System.out.println(visiteds.size());
		this.request.setAttribute("currentPage", current);
		this.request.setAttribute("totalPage", totalPage);
		this.request.setAttribute("size", size);
		this.request.setAttribute("visiteds", newVisited);
		
		return "edit";

	}
	/*
	 * set注入
	 */
	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}

	public Customer getModel() {
		customer = new Customer();
		return customer;
	}

}
