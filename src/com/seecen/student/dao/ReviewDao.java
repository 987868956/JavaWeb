package com.seecen.student.dao;

import com.seecen.dao.BaseDao;

public interface ReviewDao extends BaseDao{
	public boolean getByName(String name);
}
