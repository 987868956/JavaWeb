package com.seecen.teach.dao.impl;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.market.po.Centre;
import com.seecen.system.po.User;
import com.seecen.teach.dao.CourseDao;
import com.seecen.teach.po.Course;

public class Test {
	public static void main(String[] args){
		
		ApplicationContext context=new ClassPathXmlApplicationContext("application*.xml");
		CourseDao dao=(CourseDao) context.getBean("courseDao");
		
		User user = new User();
		user.setUserName("刘伟华");
		//course.setLecturer(user);
		//course.setDevelop(user);
		//course.getDevelop().getUserName();
		//course.setDevelop(user.getUserName());
		Centre centre=new Centre();
		String c=centre.getCname();
		
		Course course=new Course("sc1506", new Date(), 36, user, user, "1905", centre, "NotOper");

		boolean f=dao.addObject(course);
		System.out.println(f);
	}
}
