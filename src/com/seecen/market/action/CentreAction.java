package com.seecen.market.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.market.dao.CentreDao;
import com.seecen.market.po.Centre;

/*
 * 动作层,做页面跳转
 */
public class CentreAction extends BaseAction implements ModelDriven<Centre> {
	private CentreDao marketDao;
	private Centre centre;

	public void setMarketDao(CentreDao marketDao) {
		this.marketDao = marketDao;
	}

	@Override
	public String execute() throws Exception {
		System.out.println("******************88");
		List centres = new ArrayList();
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
		int size = marketDao.findAll(Centre.class, filter).size();
		centres = marketDao.findAll(Centre.class, filter, current, 5);
		System.out.println(centres.size());
		for (Object c : centres) {
			Centre cent = new Centre();
			cent = (Centre) c;
			System.out.println(cent);
		}
		this.request.setAttribute("currentPage", current);
		this.request.setAttribute("size", size);
		this.request.setAttribute("centres", centres);
		System.out.println("************");
		return SUCCESS;

	}

	/*
	 * 添加中心
	 */
	public String add() throws Exception {
		System.out.println("*************8" + centre.toString());

		marketDao.addObject(centre);
		return "listAll";

	}

	// 通过id查找Centre
	public String getByName() throws Exception {
		String centreName = this.request.getParameter("cname");
		System.out.println(centreName);
		boolean flag = marketDao.getCentreByName(centreName.trim());
		JSONObject obj = new JSONObject();
		if (flag) {
			obj.element("tips", "该中心名已经存在,请重新输入");
		} else {
			obj.element("tips", "该中心名可以使用");
			
		}
		PrintWriter out = this.response.getWriter();
		out.write(obj.toString());
		System.out.println(obj.toString());
		out.flush();

		return null;

	}

	/*
	 * 通过ID查找Centre对象
	 */
	public String getByID() throws Exception {
		System.out.println("通过ID查找对象");
		String cid = this.request.getParameter("cid");
		int id = Integer.parseInt(cid);
		System.out.println(id);
		Centre cen = (Centre) marketDao.findObjectById(Centre.class, id);
		System.out.println(cen);
		JSONObject obj = new JSONObject();
		obj.element("cen", cen);
		PrintWriter out = this.response.getWriter();
		out.write(obj.toString());
		System.out.println(obj.toString());
		out.flush();

		return null;

	}

	public String update() throws Exception {
		System.out.println(centre);
		marketDao.updateObject(centre);
		return "listAll";

	}

	public String listAll() throws Exception {
		System.out.println("******************88");
		Map filter = new HashMap();
		filter.put("cname", "中心");
		List centres = new ArrayList();

		centres = marketDao.findAll(Centre.class, filter, 1, 5);
		System.out.println(centres.size());
		JSONObject object = new JSONObject();
		object.element("centres", centres);
		System.out.println(object.toString());
		PrintWriter out = this.response.getWriter();
		out.write(object.toString());
		out.flush();

		return SUCCESS;

	}
	/**
	 *  删除
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception {
		System.out.println("*************8" + centre.toString());
		System.out.println(this.request.getParameter("cid"));
		marketDao.deleteObject(Centre.class, centre.getCid());
		return "listAll";

	}
	public Centre getModel() {
		centre = new Centre();
		return centre;
	}

}
