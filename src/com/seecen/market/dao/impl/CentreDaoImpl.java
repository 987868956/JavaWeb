package com.seecen.market.dao.impl;

import org.hibernate.Query;

import com.seecen.dao.impl.BaseDaoImpl;
import com.seecen.market.dao.CentreDao;
import com.seecen.market.po.Centre;

public class CentreDaoImpl extends BaseDaoImpl implements CentreDao {

	/**
	 * 根据中心名字查找出中心的信息
	 */
	public boolean getCentreByName(String centreName) {
		String sql = "from Centre where cname=?";
		Query query = super.getSession().createQuery(sql);
		int size =  query.setParameter(0, centreName).list().size();
		if(size>0){
			return true;
		}else{
			return false;
		}
	}
	
}
