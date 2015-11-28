package com.seecen.system.dao;

import java.util.List;

import com.seecen.dao.BaseDao;

public interface MoudleDao extends BaseDao {
	public List findIssonAll(Class clzz,String isson);
	public List findSonMoudle(Class clzz,String isson);
}
