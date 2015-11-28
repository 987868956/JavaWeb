package com.seecen.common;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import com.opensymphony.xwork2.ActionSupport;

public class ExportExcel extends ActionSupport{

	@Override
	public String execute() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("Content-disposition", "attachment; filename=exportInfo.xls");
		response.setContentType("application/vnd.ms-excel");
		try {
			WritableWorkbook work= Workbook.createWorkbook(response.getOutputStream());
			WritableSheet sheet = work.createSheet("新生名单", 0);
			Label lab1 = new Label(0,0,"EmpNO");
			Label lab2 = new Label(1,0,"ENAME");
			Label lab3 = new Label(2,0,"JOB");
			Label lab4 = new Label(3,0,"MGR");
			Label lab5 = new Label(4,0,"HIREDATE");
			Label lab6 = new Label(5,0,"SAL");
			Label lab7 = new Label(6,0,"COMM");
			Label lab8 = new Label(7,0,"DEPTNO");
			sheet.addCell(lab8);
			sheet.addCell(lab7);
			sheet.addCell(lab6);
			sheet.addCell(lab5);
			sheet.addCell(lab4);
			sheet.addCell(lab3);
			sheet.addCell(lab2);
			sheet.addCell(lab1);
			for(int i=0;i<1000;i++){
				Label lablea = new Label(0,i+1,""+(i+1000));
				Label lableb = new Label(1,i+1,"Eason"+(1000+i));
				Label lablec = new Label(2,i+1,"Tencent"+(i*1000+1));
				Label labled = new Label(3,i+1,""+(i+9000));
				Label lablee = new Label(4,i+1,"HIREDATE"+(i*1000+1));
				Label lablef = new Label(5,i+1,"SAL"+(i*1000+1));
				Label lableg = new Label(6,i+1,"COMM"+(i*1000+1));
				Label lableh = new Label(7,i+1,"DEPTNO"+(i*1000+1));
				 sheet.addCell(lableh);
				 sheet.addCell(lableg);
				 sheet.addCell(lablef);
				 sheet.addCell(lablee);
				 sheet.addCell(labled);
				 sheet.addCell(lablec);
				 sheet.addCell(lableb);
				 sheet.addCell(lablea);
			}
			work.write();
			work.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RowsExceededException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
}
