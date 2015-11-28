package com.seecen.iterceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.apache.bcel.classfile.Constant;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.seecen.system.dao.LogDao;
import com.seecen.system.po.Log;
import com.seecen.system.po.User;

@SuppressWarnings("serial")
public class LogInterceptor implements Interceptor {

	private LogDao logDao;

	public LogDao getLogDao() {
		return logDao;
	}

	public void setLogDao(LogDao logDao) {
		this.logDao = logDao;
	}

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void init() {
		// TODO Auto-generated method stub

	}

	public String intercept(ActionInvocation invocation) throws Exception {
		String actionName = invocation.getProxy().getActionName();
		String actionMethod = invocation.getProxy().getMethod();
		System.out.println(actionMethod);
		System.out.println(actionName);
		String event ="";
		
		Log log = new Log();
		Map<?, ?> session = ActionContext.getContext().getSession();
		User CurrentLoginUser = (User) session.get("CurrentLoginUser");
		log.setUser(CurrentLoginUser);
		
		if("auth".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了权限操作";
		}else if("role".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了角色操作";
		}else if("log".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了日志查看";
		}else if("moudle".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了模块操作";
		}else if("centre".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了中心操作";
		}else if("customer".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"查看了客户信息";
		}else if("channel".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了渠道管理操作";
		}else if("student".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了学员信息查询操作";
		}else if("review".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了项目评审操作";
		}else if("consult".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了学员面谈情况添加";
		}else if("attendance".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行考勤管理操作";
		}else if("employment".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了就业情况查询";
		}else if("interview".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了模拟面试管理";
		}else if("activity".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了班级活动管理";
		}else if("course".equals(actionName)){
			event=CurrentLoginUser.getUserName()+"进行了班级详情查看";
		}
		else{
			event=CurrentLoginUser.getUserName()+"进入查看了首页";
		}	
		log.setEvent(event);
		logDao.addObject(log);
		//event = CurrentLoginUser.getUserName()+" "+actionMethod +actionName;
		System.out.println(event);
		
		return invocation.invoke();
	}

}
