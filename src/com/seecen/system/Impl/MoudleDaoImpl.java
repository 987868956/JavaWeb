package com.seecen.system.Impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import com.seecen.dao.impl.BaseDaoImpl;
import com.seecen.system.dao.MoudleDao;

public class MoudleDaoImpl extends BaseDaoImpl implements MoudleDao{

	public List findIssonAll(Class clzz, String isson) {
		// TODO Auto-generated method stub
		List list = new ArrayList();
		Criteria criteria = super.getSession().createCriteria(clzz);
		
		criteria.add(Restrictions.eq("isson", "0"));
		
		list=criteria.list();
		return list;
	}

	public List findSonMoudle(Class clzz, String isson) {
		List list = new ArrayList();
   Criteria criteria = super.getSession().createCriteria(clzz);
		
		criteria.add(Restrictions.eq("isson", "1"));
		
		list=criteria.list();
		return list;
	}

}
