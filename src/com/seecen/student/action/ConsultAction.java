package com.seecen.student.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.student.dao.ConsultDao;
import com.seecen.student.po.Consult;
import com.seecen.student.po.Student;
import com.seecen.system.po.User;

public class ConsultAction extends BaseAction implements ModelDriven<Consult>{
	private Consult consult;
	private ConsultDao consultDao;

	public void setConsultDao(ConsultDao consultDao) {
		this.consultDao = consultDao;
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
		int totalSize=consultDao.findAll(Consult.class).size();
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
		
		List<Consult> cs=consultDao.findAll(Consult.class, filter, CurrentPage, pageSize);
		
		List<Student> ss=consultDao.findAll(Student.class, filter, 1, 998);
		List<User> us=consultDao.findAll(User.class, filter, 1, 998);
		this.request.setAttribute("students", ss);
		this.request.setAttribute("users", us);
		
		this.request.setAttribute("consults", cs);
		this.request.setAttribute("currentPage", CurrentPage);
		this.request.setAttribute("count", totalSize);
		return "list";
	}
	
	public String add() throws Exception {
		String stuid=this.request.getParameter("student");
		String userid=this.request.getParameter("user");
		int sid=1;
		int uid=1;
		if(stuid!=null && userid!=null){
			sid=Integer.parseInt(stuid);
			uid=Integer.parseInt(userid);
		}
		Student s=(Student) consultDao.findObjectById(Student.class, sid);
		User u=(User) consultDao.findObjectById(User.class, uid);
		consult.setSid(s);
		consult.setUserId(u);
		boolean f=consultDao.addObject(consult);
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
		Consult c=(Consult) consultDao.findObjectById(Consult.class, cid);
		
		JSONObject jobj=new JSONObject();
		jobj.element("studentID", c.getSid().getId());
		jobj.element("uid", c.getUserId().getId());
		jobj.element("time", c.getCreateDate().toString());
		jobj.element("content", c.getContent());
		
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
		consult.setId(cid);
		String stuid=this.request.getParameter("student");
		String userid=this.request.getParameter("user");
		int sid=1;
		int uid=1;
		if(stuid!=null && userid!=null){
			sid=Integer.parseInt(stuid);
			uid=Integer.parseInt(userid);
		}
		Student s=(Student) consultDao.findObjectById(Student.class, sid);
		User u=(User) consultDao.findObjectById(User.class, uid);
		consult.setSid(s);
		consult.setUserId(u);
		boolean f=consultDao.updateObject(consult);
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
		boolean f=consultDao.deleteObject(Consult.class, cid);
		if(f){
			return "delete";
		}else{
			return ERROR;
		}
	}
	

	public Consult getModel() {
		consult=new Consult();
		return consult;
	}

}
