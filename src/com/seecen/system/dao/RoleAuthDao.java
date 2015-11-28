package com.seecen.system.dao;

import java.io.Serializable;

import org.hibernate.Session;

import com.seecen.dao.BaseDao;

public interface RoleAuthDao extends BaseDao {
	//public boolean deleteAuth(int id); 
	public boolean deleteRoleAuthByroleId( int roleId);
	

}
