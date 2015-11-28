package com.seecen.teach.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.market.dao.CentreDao;
import com.seecen.market.po.Centre;
import com.seecen.student.po.Student;
import com.seecen.system.dao.UserDao;
import com.seecen.system.po.User;
import com.seecen.teach.dao.CourseDao;
import com.seecen.teach.po.Course;

public class CourseAction extends BaseAction implements ModelDriven<Course> {
	private Course course;
	private CourseDao courseDao;
	private CentreDao centredao;
	
	public CourseDao getCourseDao() {
		return courseDao;
	}

	public void setCentredao(CentreDao centredao) {
		this.centredao = centredao;
	}

	public void setCourseDao(CourseDao courseDao) {
		this.courseDao = courseDao;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String execute() throws Exception {
		String isShow=request.getParameter("isShow");
		Map filter = new HashMap();
		String className=request.getParameter("courName");		//班级名
		String manager=request.getParameter("manager");			//讲师
		String profession=request.getParameter("profession");	//职业发展
		String centreName=request.getParameter("core");			//中心
		String classroom=request.getParameter("room");			//教室
		String section=request.getParameter("section");			//阶段
		if(className!=null&&!"".equals(className)){
			filter.put("className", className);		//根据班级名进行模糊查询
		}
		if(manager!=null&&!"".equals(manager)){
			int lid=Integer.parseInt(manager);		//根据讲师
			filter.put("lecturer.id",lid);
		}
		if(profession!=null&&!"".equals(profession)){
			int did=Integer.parseInt(profession);
			filter.put("develop.id", did);		//根据职业顾问
		}
		if(centreName!=null&&!"".equals(centreName)){
			int cid=Integer.parseInt(centreName);
			filter.put("centre.id", cid);		//根据中心
		}
		if(classroom!=null&&!"".equals(classroom)){
			filter.put("classroom", classroom);		//根据教室
		}
		if(section!=null&&!"".equals(section)){
			filter.put("status", section);			//根据阶段
		}
		/*
		 * 分页
		 */
		String currentPage = this.request.getParameter("currentPage");
		int current=1;
		if(currentPage!=null&&!"".equals(currentPage)){
			current = Integer.parseInt(currentPage);
		}
		int totalPage=0;
		int size=courseDao.findAll(Course.class,filter).size();
		if(size%5==0){
			totalPage=size/5;
		}else{
			totalPage=size/5+1;
		}
		if(totalPage<=current){
			totalPage=current;
		}
		
		
		
		
		List<Course> css = courseDao.findAll(Course.class, filter, current, 5);	//班级
		List<User> us = courseDao.findAll(User.class);							//用户
		List<Centre> ces = courseDao.findAll(Centre.class);		//中心
		
		Map filter110=new HashMap();
		String afid=this.request.getParameter("afid");
		int studentid=1;
		if(afid!=null){
			studentid=Integer.parseInt(afid);
			filter110.put("classId.id", studentid);
		}
		List<Student> stus=courseDao.findAll(Student.class, filter110);	
		//循环通过班级id拿到班级list集合，用一个int数组接受
		//
	
		for(Course cc:css){
			Map filter2=new HashMap();
			filter2.put("classId.id", cc.getId());
			List<Student> stues=courseDao.findAll(Student.class, filter2);	
			cc.setCount(stues.size());
		}
			//学生
		
		int count=courseDao.findAll(Student.class, filter110).size();
		course.setCount(count);
		this.request.setAttribute("className", className);
		this.request.setAttribute("manager", manager);
		this.request.setAttribute("profession", profession);
		this.request.setAttribute("centreName", centreName);
		this.request.setAttribute("classroom", classroom);
		this.request.setAttribute("section", section);
		
		this.request.setAttribute("count", count);
		this.request.setAttribute("ces", ces);
		//获取讲师角色的用户名单
		List JavaTeacher = courseDao.findUserByRole("讲师");
		//获取职业发展顾问的用户名单
		List jobDeveloper  = courseDao.findUserByRole("职业发展");
		this.request.setAttribute("JavaTeacher", JavaTeacher);
		this.request.setAttribute("jobDeveloper", jobDeveloper);
		this.request.setAttribute("us", us);
		this.request.setAttribute("css", css);
		this.request.setAttribute("stus", stus);
		this.request.setAttribute("currentPage", current);		//当前页
		this.request.setAttribute("totalSize",size);			//总记录条数
		this.request.setAttribute("totalPage", totalPage);		//总页数
		
		this.request.setAttribute("isShow", isShow);
		return SUCCESS;
	}

	public String add() throws Exception {
		String lecid = request.getParameter("lid");
		String devid = request.getParameter("did");
		String cenid = request.getParameter("cid");
		int lid = 1;
		int did = 1;
		int cid = 1;
		if (lecid != null && devid != null && cenid != null) {
			lid = Integer.parseInt(lecid);
			did = Integer.parseInt(devid);
			cid = Integer.parseInt(cenid);
		}
		User l = (User) courseDao.findObjectById(User.class, lid);
		User d = (User) courseDao.findObjectById(User.class, did);
		Centre c = (Centre) courseDao.findObjectById(Centre.class, cid);
		course.setLecturer(l);
		course.setDevelop(d);
		course.setCentre(c);

		boolean f = courseDao.addObject(course);
		if (f) {
			return "listAll";
		} else {
			return ERROR;
		}
	}

	public String findById() throws Exception {
		String id = this.request.getParameter("id");
		int cid = 1;
		if (id != null) {
			cid = Integer.parseInt(id);
		}
		Course c = (Course) courseDao.findObjectById(Course.class, cid);
		JSONObject jobj = new JSONObject();
		jobj.element("id", c.getId());
		jobj.element("className", c.getClassName());
		jobj.element("lecid", c.getLecturer().getId());
		jobj.element("devid", c.getDevelop().getId());
		jobj.element("centre", c.getCentre().getCid());
		jobj.element("count", c.getCount());
		jobj.element("open", c.getOpenTime().toString().substring(0, 10));
		jobj.element("classroom", c.getClassroom());
		jobj.element("status", c.getStatus());
		PrintWriter out = response.getWriter();
		out.write(jobj.toString());
		out.flush();
		out.close();

		return INPUT;
	}

	public String update() throws Exception {
		String id = this.request.getParameter("id");
		System.out.println(id);
		int cid = 1;
		if (id != null) {
			cid = Integer.parseInt(id);
		}
		course.setId(cid);

		String lecid = request.getParameter("lid");
		String devid = request.getParameter("did");
		String cenid = request.getParameter("cid");
		int lid = 1;
		int did = 1;
		int aid = 1;
		if (lecid != null && devid != null && cenid != null) {
			lid = Integer.parseInt(lecid);
			did = Integer.parseInt(devid);
			aid = Integer.parseInt(cenid);
		}
		User l = (User) courseDao.findObjectById(User.class, lid);
		User d = (User) courseDao.findObjectById(User.class, did);
		Centre c = (Centre) courseDao.findObjectById(Centre.class, aid);
		course.setLecturer(l);
		course.setDevelop(d);
		course.setCentre(c);
		boolean f = courseDao.updateObject(course);
		if (f) {
			return "listAll";
		} else {
			return ERROR;
		}
	}

	public Course getModel() {
		course = new Course();
		return course;
	}

}
