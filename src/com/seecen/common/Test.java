package com.seecen.common;

import java.util.Calendar;
import java.util.Date;
/**
 * 对当前时间+1  或者-1
 * @author Administrator
 *
 */
public class Test {
	public static void main(String[] args) {
		Date d1 = new Date();
		Calendar c= Calendar.getInstance();
		c.add(c.DATE, -1);
		Date d2 = c.getTime();
		System.out.println(d1);
		System.out.println(d2);
		
		//创建日历类
		Calendar cal = Calendar.getInstance();
		cal.add(cal.DATE, 1);
		Date date = cal.getTime();
		System.out.println(date);
	}
}



