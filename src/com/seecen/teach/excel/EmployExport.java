package com.seecen.teach.excel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.struts2.ServletActionContext;

import com.seecen.action.BaseAction;
import com.seecen.student.dao.EmploymentDao;
import com.seecen.student.po.Employment;
import com.seecen.teach.dao.CourseDao;

public class EmployExport extends BaseAction{
	private EmploymentDao employmentDao;
	
	
	public void setEmploymentDao(EmploymentDao employmentDao) {
		this.employmentDao = employmentDao;
	}


	@Override
	public String execute() throws Exception {
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setHeader("Context-disponsition","attachment;filename=exportInfo.xls");
		response.setContentType("applcation/vnd.ms-excel");
		
		List<Employment> emp=employmentDao.findAll(Employment.class);
		try {
			WritableWorkbook book=Workbook.createWorkbook(response.getOutputStream());
			WritableSheet sheet=book.createSheet("就业信息表", 0);
			Label lab0=new Label(0,0,"学生姓名");
			Label lab1=new Label(1,0,"工作单位");
			Label lab2=new Label(2,0,"职位");
			Label lab3=new Label(3,0,"工作地点");
			Label lab4=new Label(4,0,"就业日期");
			Label lab5=new Label(5,0,"薪资");
			sheet.addCell(lab0);
			sheet.addCell(lab1);
			sheet.addCell(lab2);
			sheet.addCell(lab3);
			sheet.addCell(lab4);
			sheet.addCell(lab5);
			int i=1;
			for(Employment e:emp){
				Label la0=new Label(0,i,e.getSid().getName());
				Label la1=new Label(1,i,e.getWorkUnit());
				Label la2=new Label(2,i,e.getPost());
				Label la3=new Label(3,i,e.getWorkAddress());
				Label la4=new Label(4,i,e.getWorkDate().toString());
				Label la5=new Label(5,i,e.getSalary().toString());
				sheet.addCell(la0);
				sheet.addCell(la1);
				sheet.addCell(la2);
				sheet.addCell(la3);
				sheet.addCell(la4);
				sheet.addCell(la5);
				i++;
			}
			book.write();
			book.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

}
