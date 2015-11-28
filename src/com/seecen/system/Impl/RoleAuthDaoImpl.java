package com.seecen.system.Impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import com.opensymphony.xwork2.Result;
import com.seecen.dao.impl.BaseDaoImpl;


import com.seecen.system.dao.RoleAuthDao;
import com.seecen.system.po.RoleAuth;


public class RoleAuthDaoImpl extends BaseDaoImpl implements RoleAuthDao {

	public boolean deleteRoleAuthByroleId(int roleId) {
		RoleAuth roleAuth;
		Session session=super.getSession();
		
		String sql="delete from T5_CRM_roleAuth where roleId="+roleId;
		
		SQLQuery query =super.getSession().createSQLQuery(sql);
		query.executeUpdate();
		
		
		System.out.println("执行删除操作");
		return true; 
          
				}
        }
	

