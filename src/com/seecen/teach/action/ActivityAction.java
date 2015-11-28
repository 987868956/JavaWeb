package com.seecen.teach.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.teach.dao.ActivityDao;
import com.seecen.teach.po.Activity;
import com.seecen.teach.po.Course;

public class ActivityAction extends BaseAction implements ModelDriven<Activity>{
	private Activity activity;
	private ActivityDao acDao;
	public void setAcDao(ActivityDao acDao) {
		this.acDao = acDao;
	}
	
	@Override
	public String execute() throws Exception {
		Map filter=new HashMap();
		String currentPage = this.request.getParameter("currentPage");
		int current=1;
		if(currentPage!=null&&!"".equals(currentPage)){
			current = Integer.parseInt(currentPage);
		}
		int totalPage=0;
		int size=acDao.findAll(Activity.class,filter).size();
		if(size%5==0){
			totalPage=size/5;
		}else{
			totalPage=size/5+1;
		}
		if(totalPage<=current){
			totalPage=current;
		}
		
		List<Activity> as=acDao.findAll(Activity.class, filter, current, 5);
		List<Course> cs=acDao.findAll(Course.class, filter, current, 5);
		this.request.setAttribute("currentPage", current);		//当前页
		this.request.setAttribute("totalSize",size);
		this.request.setAttribute("as", as);
		this.request.setAttribute("cs", cs);
		return SUCCESS;
	}
	public String add() throws Exception{
		String couid=request.getParameter("cid");
		int cid=1;
		if(couid!=null){
			cid=Integer.parseInt(couid);
		}
		Course c=(Course) acDao.findObjectById(Course.class, cid);
		activity.setClassName(c);
		boolean f=acDao.addObject(activity);
		if(f){
			return "add";
		}else{
			return ERROR;
		}
	}
	public String findById() throws Exception{
		String id=this.request.getParameter("id");
		int aid=1;
		if(id!=null){
			aid=Integer.parseInt(id);
		}
		Activity a=(Activity) acDao.findObjectById(Activity.class, aid);
		JSONObject jo=new JSONObject();
		jo.element("id", a.getId());
		jo.element("couid", a.getClassName().getId());
		jo.element("theme", a.getTheme());
		jo.element("activityTime", a.getActivityTime().toString().substring(0, 10));
		jo.element("place", a.getPlace());
		PrintWriter out=response.getWriter();
		out.write(jo.toString());
		out.flush();
		out.close();
		return INPUT;
	}
	public String update() throws Exception{
		String id=this.request.getParameter("id");
		int aid=1;
		if(id!=null){
			aid=Integer.parseInt(id);
		}
		activity.setId(aid);
		
		String couid=request.getParameter("cid");
		int cid=1;
		if(couid!=null){
			cid=Integer.parseInt(couid);
		}
		Course c=(Course) acDao.findObjectById(Course.class, cid);
		activity.setClassName(c);
		
		boolean f=acDao.updateObject(activity);
		if(f){
			return "listAll";
		}else{
			return ERROR;
		}
	}
	
	public Activity getModel() {
		activity=new Activity();
		return activity;
	}
}
