package com.seecen.system.action;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.system.dao.UserDao;
import com.seecen.system.po.Moudle;
import com.seecen.system.po.Role;
import com.seecen.system.po.User;

public class LoginAction  extends BaseAction  implements ModelDriven<User> {
	private User user;
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	public User getModel() {
		user=new User();
		return user;
	}
	/**
	 * 验证用户    当用户的登录时,将该用户放到  CurrentLoginUser 的session中
	 */
	@Override
	public String execute() throws Exception {
		user=userDao.findUserLogin(user.getUserName(), user.getPass());
		if(user!=null){
		   	System.out.println("进入验证");
			System.out.println("密码验证成功");
			System.out.println("密码邮箱是"+user.getEmail());
			//查找该角色的所有模块
			Role role = user.getRole();
			Role role2 = (Role) userDao.findObjectById(Role.class, role.getId());
			Set<Moudle> moudles=role.getMoudles();
			//查找该角色的父模块,子模块可以在页面中遍历
			Set<Moudle> parentMoudles = new HashSet<Moudle>();
			Iterator<Moudle> its = moudles.iterator();
			while(its.hasNext()) {
				Moudle m = its.next();
				parentMoudles.add(m.getParentMoudle());
			}
			this.request.getSession().setAttribute("parentMoudles", parentMoudles);
			this.request.getSession().setAttribute("CurrentLoginUser", user);
			return SUCCESS;
		}else{
			return ERROR;
		}
		 	
		
	}
	public String exit() throws Exception {
		this.request.getSession().removeAttribute("user");
		this.request.getSession().removeAttribute("parentMoudles");
		return "login";
	
		
	}
	
	
	
	

}
