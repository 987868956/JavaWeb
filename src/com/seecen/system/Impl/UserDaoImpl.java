package com.seecen.system.Impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.seecen.dao.impl.BaseDaoImpl;
import com.seecen.system.dao.UserDao;
import com.seecen.system.po.User;

public class UserDaoImpl extends BaseDaoImpl implements UserDao{
	
	

	public User findUserLogin(String userName, String pass) {
		User user=new User();
		Session session=super.getSession();
		String hql=" from User u where u.userName=? and u.pass=?";
		user = (User) super.getSession().createQuery(hql).setParameter(0, userName).setParameter(1, pass).uniqueResult();
		return user;
		}
	}
	 
	
			
		
	

