package com.seecen.market.dao;

import com.seecen.dao.BaseDao;
import com.seecen.market.po.Centre;

public interface CentreDao extends BaseDao{
	public boolean  getCentreByName(String centreName);
}