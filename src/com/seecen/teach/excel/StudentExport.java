package com.seecen.teach.excel;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.opensymphony.xwork2.ActionSupport;
import com.seecen.action.BaseAction;
import com.seecen.dao.BaseDao;
import com.seecen.student.po.Student;
import com.seecen.teach.dao.CourseDao;

public class StudentExport extends BaseAction{
	private CourseDao courseDao;
	
	public void setCourseDao(CourseDao courseDao) {
		this.courseDao = courseDao;
	}

	@Override
	public String execute() throws Exception {
		String classname= this.request.getParameter("ClassName");
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setHeader("Context-disponsition","attachment;filename=exportInfo.xls");
		response.setContentType("applcation/vnd.ms-excel");
		
		Map filter=new HashMap();
		String classId=request.getParameter("classId");
		if(classId!=null&&"".equals(classId)){
			int courseId=Integer.parseInt(classId);
			filter.put("classId.id", courseId);
		}
		List<Student> stus=courseDao.findAll(Student.class, filter);
		
		try {
			OutputStream out = response.getOutputStream();
			WritableWorkbook book=Workbook.createWorkbook(out);
			WritableSheet sheet=book.createSheet("学员信息表", 0);
			Label lable0=new Label(0,0,"姓名");
			Label lable1=new Label(1,0,"性别");
			Label lable2=new Label(2,0,"出生日期");
			Label lable3=new Label(3,0,"毕业院校");
			Label lable4=new Label(4,0,"学历");
			Label lable5=new Label(5,0,"专业");
			Label lable6=new Label(6,0,"籍贯");
			Label lable7=new Label(7,0,"电话");
			Label lable8=new Label(8,0,"身份证");
			Label lable9=new Label(9,0,"备注");
			sheet.addCell(lable0);
			sheet.addCell(lable1);
			sheet.addCell(lable2);
			sheet.addCell(lable3);
			sheet.addCell(lable4);
			sheet.addCell(lable5);
			sheet.addCell(lable6);
			sheet.addCell(lable7);
			sheet.addCell(lable8);
			sheet.addCell(lable9);
			int i=1;
			for(Student s:stus){
				Label l0=new Label(0,i,s.getName());
				Label l1=new Label(1,i,s.getSex());
				Label l2=new Label(2,i,s.getBirthDate().toString());
				Label l3=new Label(3,i,s.getCollege());
				Label l4=new Label(4,i,s.getEducation());
				Label l5=new Label(5,i,s.getMajor());
				Label l6=new Label(6,i,s.getOrigin());
				Label l7=new Label(7,i,s.getTelephone());
				Label l8=new Label(8,i,s.getIDCard());
				Label l9=new Label(9,i,s.getNote());
				sheet.addCell(l0);
				sheet.addCell(l1);
				sheet.addCell(l2);
				sheet.addCell(l3);
				sheet.addCell(l4);
				sheet.addCell(l5);
				sheet.addCell(l6);
				sheet.addCell(l7);
				sheet.addCell(l8);
				sheet.addCell(l9);
				i++;
			}
			book.write();
			book.close();
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return null;
	}

}
