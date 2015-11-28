package com.seecen.student.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.student.dao.EmploymentDao;
import com.seecen.student.po.Employment;
import com.seecen.student.po.Student;

public class EmploymentAction extends BaseAction implements ModelDriven<Employment>{
	private Employment employment;
	private EmploymentDao employmentDao;

	public void setEmploymentDao(EmploymentDao employmentDao) {
		this.employmentDao = employmentDao;
	}

	@Override
	public String execute() throws Exception {
		Map filter=new HashMap();
		int CurrentPage=1;
		int pageSize=5;
		
		String currentP=this.request.getParameter("currentPage");
		if(currentP!=null){
			CurrentPage=Integer.parseInt(currentP);
		}
		int totalSize=employmentDao.findAll(Employment.class).size();
		int totalPage=1;
		if(totalSize%pageSize==0){
			totalPage=totalSize/pageSize;
		}else{
			totalPage=totalSize/pageSize+1;
		}
		if(CurrentPage>totalPage){
			CurrentPage=totalPage;
		}
		if(CurrentPage<=0){
			CurrentPage=1;
		}
		
		List<Employment> cs=employmentDao.findAll(Employment.class, filter, CurrentPage, pageSize);
		List<Student> ss=employmentDao.findAll(Student.class, filter, 1, 998);
		this.request.setAttribute("ss", ss);
		this.request.setAttribute("consults", cs);
		this.request.setAttribute("currentPage", CurrentPage);
		this.request.setAttribute("count", totalSize);
		return "list";
	}
	
	public String add() throws Exception {
		String stuid=this.request.getParameter("student");
		int sid=1;
		if(stuid!=null){
			sid=Integer.parseInt(stuid);
		}
		Student s=(Student) employmentDao.findObjectById(Student.class, sid);
		employment.setSid(s);
		boolean f=employmentDao.addObject(employment);
		if(f){
			return "listAll";
		}else{
			return ERROR;
		}
	}
	
	public String findById() throws Exception {
		String id=this.request.getParameter("id");
		int cid=1;
		if(id!=null){
			cid=Integer.parseInt(id);
		}
		Employment e=(Employment) employmentDao.findObjectById(Employment.class, cid);
		JSONObject jobj=new JSONObject();
		jobj.element("sid", e.getSid().getId());
		jobj.element("unit", e.getWorkUnit());
		jobj.element("time", e.getWorkDate().toString());
		jobj.element("salary", e.getSalary());
		jobj.element("addr", e.getWorkAddress());
		jobj.element("post", e.getPost());
		
		PrintWriter out=response.getWriter();
		out.write(jobj.toString());
		out.flush();
		out.close();
		
		return INPUT;
	}
	
	public String update() throws Exception {
		String id=this.request.getParameter("cid");
		System.out.println(id);
		int cid=1;
		if(id!=null){
			cid=Integer.parseInt(id);
		}
		employment.setId(cid);
		String stuid=this.request.getParameter("student");
		int sid=1;
		if(stuid!=null){
			sid=Integer.parseInt(stuid);
		}
		Student s=(Student) employmentDao.findObjectById(Student.class, sid);
		employment.setSid(s);
		boolean f=employmentDao.updateObject(employment);
		if(f){
			return "listAll";
		}else{
			return ERROR;
		}
	}
	

	public String delete() throws Exception {
		String id=this.request.getParameter("id");
		int cid=1;
		if(id!=null){
			cid=Integer.parseInt(id);
		}
		boolean f=employmentDao.deleteObject(Employment.class, cid);
		if(f){
			return "delete";
		}else{
			return ERROR;
		}
	}

	public Employment getModel() {
		employment=new Employment();
		return employment;
	}

}
