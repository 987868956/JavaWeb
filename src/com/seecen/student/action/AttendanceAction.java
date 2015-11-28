package com.seecen.student.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.student.dao.AttendanceDao;
import com.seecen.student.po.Attendance;
import com.seecen.student.po.Consult;
import com.seecen.student.po.Student;
import com.seecen.system.po.User;

public class AttendanceAction extends BaseAction implements ModelDriven<Attendance>{
	private Attendance attendance;
	private AttendanceDao attendanceDao;

	public void setAttendanceDao(AttendanceDao attendanceDao) {
		this.attendanceDao = attendanceDao;
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
		int totalSize=attendanceDao.findAll(Attendance.class).size();
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
		
		List<Attendance> as=attendanceDao.findAll(Attendance.class, filter, CurrentPage, pageSize);
		
		List<Student> ss=attendanceDao.findAll(Student.class, filter, 1, 998);
		List<User> us=attendanceDao.findAll(User.class, filter, 1, 998);
		this.request.setAttribute("students", ss);
		this.request.setAttribute("users", us);
		
		this.request.setAttribute("attendances", as);
		this.request.setAttribute("currentPage", CurrentPage);
		this.request.setAttribute("count", totalSize);
		return "list";
	}
	
	public String add() throws Exception {
		String stuid=this.request.getParameter("student");
		System.out.println(stuid);
		String userid=this.request.getParameter("user");
		System.out.println(userid);
		int sid=1;
		int uid=1;
		if(stuid!=null && userid!=null){
			sid=Integer.parseInt(stuid);
			uid=Integer.parseInt(userid);
		}
		Student s=(Student) attendanceDao.findObjectById(Student.class, sid);
		User u=(User) attendanceDao.findObjectById(User.class, uid);
		attendance.setSid(s);
		attendance.setUserId(u);
		boolean f=attendanceDao.addObject(attendance);
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
		Attendance c=(Attendance) attendanceDao.findObjectById(Attendance.class, cid);
		
		JSONObject jobj=new JSONObject();
		jobj.element("studentID", c.getSid().getId());
		jobj.element("uid", c.getUserId().getId());
		jobj.element("time", c.getCreateDate().toString());
		jobj.element("content", c.getResult());
		
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
		attendance.setId(cid);
		String stuid=this.request.getParameter("student");
		String userid=this.request.getParameter("user");
		int sid=1;
		int uid=1;
		if(stuid!=null && userid!=null){
			sid=Integer.parseInt(stuid);
			uid=Integer.parseInt(userid);
		}
		Student s=(Student) attendanceDao.findObjectById(Student.class, sid);
		User u=(User) attendanceDao.findObjectById(User.class, uid);
		attendance.setSid(s);
		attendance.setUserId(u);
		boolean f=attendanceDao.updateObject(attendance);
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
		boolean f=attendanceDao.deleteObject(Attendance.class, cid);
		if(f){
			return "delete";
		}else{
			return ERROR;
		}
	}
	

	public Attendance getModel() {
		attendance=new Attendance();
		return attendance;
	}

}
