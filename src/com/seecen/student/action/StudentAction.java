package com.seecen.student.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.student.dao.StudentDao;
import com.seecen.student.po.Interview;
import com.seecen.student.po.Student;
import com.seecen.student.vo.StudentVo;
import com.seecen.teach.po.Course;

public class StudentAction extends BaseAction implements ModelDriven<Student> {
	private Student student;
	private StudentDao studentDao;

	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String execute() throws Exception {
		Map filter=new HashMap();
		
		String theclassId=this.request.getParameter("theclassId");
		if(theclassId!=null){
			System.out.println(Integer.parseInt(theclassId));
			filter.put("classId.id", Integer.parseInt(theclassId));
		}
		int CurrentPage=1;
		int pageSize=3;
		
		String currentP=this.request.getParameter("currentPage");
		int totalSize=studentDao.findAll(Student.class).size();
		if(currentP!=null){
			CurrentPage=Integer.parseInt(currentP);
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
		}
		
		List<Student> ss=studentDao.findAll(Student.class, filter, CurrentPage, pageSize);
		
		
		List<Course> cs=studentDao.findAll(Course.class);
		this.request.setAttribute("cs", cs);
		
		this.request.setAttribute("students", ss);
		
		this.request.setAttribute("currentPage", CurrentPage);
		this.request.setAttribute("count", totalSize);
		
		return "list";
	}

	public String add() throws Exception {

		return "add";
	}
	
	public String findById() throws Exception {
		String id=this.request.getParameter("id");
		int cid=1;
		if(id!=null){
			cid=Integer.parseInt(id);
		}
		Student s=(Student) studentDao.findObjectById(Student.class, cid);
		
		JSONObject jobj=new JSONObject();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		
		StudentVo svo=new StudentVo();
		try {
			BeanUtils.copyProperties(svo, s);
			svo.setClassId(s.getClassId().getId());
			svo.setBirthDateStr(sdf.format(s.getBirthDate()));
			svo.setAdmissionDateStr(sdf.format(s.getAdmissionDate()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		jobj.element("student", svo);
		
		PrintWriter out=this.response.getWriter();
		out.write(jobj.toString());
		
		out.flush();
		out.close();
		
		return null;
	}
	
	public String update() throws Exception {
		String id=this.request.getParameter("cid");
		System.out.println(id);
		int cid=1;
		if(id!=null){
			cid=Integer.parseInt(id);
		}
		student.setId(cid);
		
		String courid=this.request.getParameter("course");
		int coid=1;
		if(courid!=null){
			coid=Integer.parseInt(courid);
		}
		Course c=(Course) studentDao.findObjectById(Course.class, coid);
		student.setClassId(c);
		
		Student s=(Student) studentDao.findObjectById(Student.class, cid);
		student.setSex(s.getSex());
		student.setBirthDate(s.getBirthDate());
		
		boolean f=studentDao.updateObject(student);
		if(f){
			return "listAll";
		}else{
			return ERROR;
		}
	}
	
	public String delete() throws Exception {
		
		return "listAll";
	}
	


	public Student getModel() {
		student = new Student();
		return student;
	}

}
