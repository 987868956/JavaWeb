package com.seecen.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.seecen.dao.BaseDao;
import com.seecen.market.po.Customer;
import com.seecen.system.po.User;

public class BaseDaoImpl<V, K> extends HibernateDaoSupport implements BaseDao {
	public boolean addObject(Object obj) {
		try {
			super.getHibernateTemplate().save(obj);
			//取消懒加载
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public boolean updateObject(Object obj) {
		try {
			super.getHibernateTemplate().update(obj);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public boolean deleteObject(Class clzz, Serializable id) {
		try {
			super.getHibernateTemplate().delete(super.getHibernateTemplate().load(clzz,id));
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public Object findObjectById(Class clzz, Serializable id) {
		Object obj = null;
		try {
			obj = super.getHibernateTemplate().get(clzz, id);
			obj.toString();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return obj;
	}

	public List findAll(Class clzz,Map filter ,int currentPage,int pageSize) {
		List list = new ArrayList();
		if(filter==null){
			filter = new HashMap();
		}
		Set<Map<K,V>> entrySets=  filter.entrySet();
		Criteria criteria = super.getSession().createCriteria(clzz);
		Iterator its = entrySets.iterator();
		while(its.hasNext()){
			Map.Entry<K, V> m = (Entry<K, V>) its.next();
			if(!(m.getValue() instanceof Integer)){
				criteria.add(Restrictions.like(m.getKey().toString(), "%"+m.getValue()+"%"));
			}else{
				criteria.add(Restrictions.eq(m.getKey().toString(), m.getValue()));
			}
		}
		try{
			System.out.println(clzz.getSimpleName());
			if(clzz.getSimpleName().equals("Centre")){
				list = criteria.addOrder(Order.desc("cname")).setFirstResult((currentPage-1)*pageSize).setMaxResults(pageSize).list();
			}else if(clzz.getSimpleName().equals("Customer")){
				list = criteria.addOrder(Order.desc("name")).setFirstResult((currentPage-1)*pageSize).setMaxResults(pageSize).list();
			}else{
				list = criteria.setFirstResult((currentPage-1)*pageSize).setMaxResults(pageSize).list();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	public  List findVisitedByRole(int customerID,int currentPage,int pageSize) {
		String hql="from Visited where customer.id=?";
		List list = super.getSession().createQuery(hql).setParameter(0, customerID).list();
		return super.getSession().createQuery(hql).setParameter(0, customerID).setFirstResult((currentPage-1)*pageSize).setMaxResults(pageSize).list();
		
		
	}
	
	
	
	public List findAll(Class clzz) {
		List list = new ArrayList();
		String className = clzz.getSimpleName();
		list = super.getSession().createQuery("from "+className).list();
		return list;
	}
	//查找状态是合法的对象
	public List findAll(Class clzz, Map filter) {
		List list = new ArrayList();
		Set<Map<K,V>> entrySets=  filter.entrySet();
		Criteria criteria = super.getSession().createCriteria(clzz);
		Iterator its = entrySets.iterator();
		while(its.hasNext()){
			Map.Entry<K, V> m = (Entry<K, V>) its.next();
			if(!(m.getValue() instanceof Integer)){
				criteria.add(Restrictions.like(m.getKey().toString(), "%"+m.getValue()+"%"));
			}else{
				criteria.add(Restrictions.eq(m.getKey().toString(), m.getValue()));
			}
		}
		try {
			list = criteria.list();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return list;
	}

	public  List findUserByRole(String roleName) {
		String hql="from User where role.name=?";
		List list = super.getSession().createQuery(hql).setParameter(0, roleName).list();
		return super.getSession().createQuery(hql).setParameter(0, roleName).list();
		
		
	}
	public Object getObjectByName(Class clzz,String name,String nameValue) {
		String className=clzz.getSimpleName();
		String hql="from "+className+" where name=?";
		Object obj = null;
		obj = super.getSession().createQuery(hql).setParameter(0, nameValue).list().get(0);
		System.out.println((Customer)obj);
		return  obj;
		
	}
	public List findAllProvince() {
		String hql = " from Province";
		List provinces = super.getSession().createQuery(hql).list();
		return provinces;
	}

	public List findCityByPID(int pid) {
		String hql = " from City where proId.proId=?";
		List citys = super.getSession().createQuery(hql).setParameter(0, pid).list();
		return citys;
	}



	// 当日待办事项
	public List findFirst( int userid,int currentPage,int PageSize,int roleId) {
		String sql = "";
		if(roleId == 4 || roleId == 141){
			// 总经理 与 系统管理员 所看到的 
			sql =  " select cc.*   from t5_crm_customer cc , t5_crm_visited cb where cc.id = cb.customer and cb.nextvisitedtime like sysdate and status!='4' ";
		}else{
			//根据咨询师的id查找给咨询师可查看和操作的客户
			sql = "select cc.*   from t5_crm_customer cc , t5_crm_visited cb where cc.id = cb.customer and cb.nextvisitedtime like sysdate  and status!='4' and cc.userid = "+userid ;
		}
		
		//String sql =  "select cc.*   from t4crm_ccustomer cc , t4crm_cback cb where cc.id = cb.customerid and cb.nexttime like sysdate and cc.consulter = "+userid;
		Session session= super.getSession();
		
			return session.createSQLQuery(sql).addEntity(Customer.class).setFirstResult((currentPage-1)*PageSize).setMaxResults(PageSize).list();	
		//	String hql = " from Customer as c, Back as b where  c.id = b.customer.id and b.nextTime like sysdate and c.user.id ="+userid;
		//	return session.createQuery(hql).list();
		
		
	}

	// 当月待办事项
	public List findMonth(int userid,int currentPage,int PageSize, int roleId) {
		String sql = "";
		if(roleId == 4 || roleId == 141){
			sql = " select cc.* from t5_crm_customer cc , t5_crm_visited cb where cc.id = cb.customer   and  cb.nextvisitedtime  between sysdate and   last_day(sysdate)  ";
		}else{
			sql = " select cc.* from t5_crm_customer cc , t5_crm_visited cb where cc.id = cb.customer   and  cb.nextvisitedtime  between sysdate and   last_day(sysdate) and cc.userid = "+userid;
		}
		//String sql = "select cc.* from t4crm_ccustomer cc , t4crm_cback cb where cc.id = cb.customerid   and  cb.nexttime  between sysdate and   last_day(sysdate) and cc.userid = "+userid;
		Session session= super.getSession();
		List list = session.createSQLQuery(sql).addEntity(Customer.class).setFirstResult((currentPage-1)*PageSize).setMaxResults(PageSize).list();
		list.toString();
			return list;	
		
	}
}
