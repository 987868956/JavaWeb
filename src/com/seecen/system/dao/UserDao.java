package com.seecen.system.dao;

import java.util.List;

import com.seecen.dao.BaseDao;
import com.seecen.system.po.User;

public interface UserDao extends BaseDao{
	
	public User findUserLogin(String userName,String pass);
}
