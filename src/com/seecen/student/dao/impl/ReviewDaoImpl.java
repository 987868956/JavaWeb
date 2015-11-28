package com.seecen.student.dao.impl;

import org.hibernate.Query;

import com.seecen.dao.impl.BaseDaoImpl;
import com.seecen.student.dao.ReviewDao;
import com.seecen.student.po.Student;

public class ReviewDaoImpl extends BaseDaoImpl implements ReviewDao {

	public boolean getByName(String name) {
		String sql = " from Student where sid.name=?";
		Query query = super.getSession().createQuery(sql);
		int size = query.setParameter(0, name).list().size();
		if (size > 0) {
			return true;
		} else {
			return false;
		}
	}

}
