package com.seecen.student.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.student.dao.InterviewDao;
import com.seecen.student.po.Attendance;
import com.seecen.student.po.Interview;
import com.seecen.student.po.Student;
import com.seecen.system.po.User;

public class InterviewAction extends BaseAction implements ModelDriven<Interview>{
	private Interview interview;
	private InterviewDao interviewDao;

	public void setInterviewDao(InterviewDao interviewDao) {
		this.interviewDao = interviewDao;
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
		int totalSize=interviewDao.findAll(Interview.class).size();
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
		
		List<Interview> is=interviewDao.findAll(Interview.class, filter, CurrentPage, pageSize);
		
		List<Student> ss=interviewDao.findAll(Student.class, filter, 1, 998);
		List<User> us=interviewDao.findAll(User.class, filter, 1, 998);
		this.request.setAttribute("ss", ss);
		this.request.setAttribute("us", us);
		
		this.request.setAttribute("interviews", is);
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
		Student s=(Student) interviewDao.findObjectById(Student.class, sid);
		User u=(User) interviewDao.findObjectById(User.class, uid);
		interview.setSid(s);
		interview.setUserId(u);
		boolean f=interviewDao.addObject(interview);
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
		Interview c=(Interview) interviewDao.findObjectById(Interview.class, cid);
		
		JSONObject jobj=new JSONObject();
		jobj.element("sid", c.getSid().getId());
		jobj.element("uid", c.getUserId().getId());
		jobj.element("time", c.getCreateDate().toString());
		jobj.element("situation", c.getSituation());
		jobj.element("content", c.getResult());
		
		PrintWriter out=response.getWriter();
		out.write(jobj.toString());
		out.flush();
		out.close();
		
		return INPUT;
	}
	
	public String update() throws Exception {
		String id=this.request.getParameter("cid");
		int cid=1;
		if(id!=null){
			cid=Integer.parseInt(id);
		}
		interview.setId(cid);
		String stuid=this.request.getParameter("student");
		String userid=this.request.getParameter("user");
		int sid=1;
		int uid=1;
		if(stuid!=null && userid!=null){
			sid=Integer.parseInt(stuid);
			uid=Integer.parseInt(userid);
		}
		Student s=(Student) interviewDao.findObjectById(Student.class, sid);
		User u=(User) interviewDao.findObjectById(User.class, uid);
		interview.setSid(s);
		interview.setUserId(u);
		boolean f=interviewDao.updateObject(interview);
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
		boolean f=interviewDao.deleteObject(Interview.class, cid);
		if(f){
			return "delete";
		}else{
			return ERROR;
		}
	}
	

	public Interview getModel() {
		interview=new Interview();
		return interview;
	}

}
