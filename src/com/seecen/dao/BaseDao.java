package com.seecen.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface BaseDao {
	/**
	 * 
	 * @param obj 添加的对象
	 * @return   填加成功返回true
	 */
	public boolean addObject(Object obj);
	/**
	 * 
	 * @param obj  修改对象
	 * @return     修改成功返回true
	 */
	public boolean updateObject(Object obj);
	/**
	 * 
	 * @param clzz   对象字节码
	 * @param id     对象ID
	 * @return       删除成功返回true
	 */
	public boolean deleteObject(Class clzz,Serializable id);
	/**
	 * 通过对象ID查找对象
	 * @param clzz    对象字节码
	 * @param id      对象ID
	 * @return        查找到的对象
	 */
	public Object findObjectById(Class clzz,Serializable id);
	/**
	 * 模糊查询和分页功能
	 * @param clzz         对象字节码
	 * @param filter       模糊查询    
	 * @param CurrentPage  分页功能当前页
	 * @param pageSize     每页大小
	 * @return
	 */
	public List findAll(Class clzz,Map filter,int CurrentPage,int pageSize);
	/**
	 * 
	 * @param clzz   对象字节码
	 * @return       返回该类的所有对象
	 */
	public List findAll(Class clzz);
	/**
	 * 
	 * @param clzz       对象字节码
	 * @param filter     模糊查询
	 * @return           返回该类的所有对象
	 */
	public List findAll(Class clzz,Map filter);
	/**
	 * 根据角色名查找该角色用户
	 * @param roleName     角色名
	 * @return             所有用户对象的集合
	 */
	public List findUserByRole(String roleName);
	/**
	 * 通过name查找对象
	 * @param clzz         对象字节码
	 * @param name         该对象的name参数   在这里没有被使用,用做拓展
	 * @param nameValue    name对应的值
	 * @return             查找的对象
	 */
	public Object getObjectByName(Class clzz,String name,String nameValue) ;
	/**
	 * 查找省份
	 * @return
	 */
	public List findAllProvince();
	/**
	 * 查找城市
	 * @param pid
	 * @return
	 */
	public List findCityByPID(int pid);
	/**
	 * 查找待办项(下次回访时间内等于今天)
	 * @param userid       咨询师的ID
	 * @param currentPage  当前页
	 * @param PageSize     每页大小
	 * @param roleId       角色ID
	 * @return             查找到的今日待办事项
	 */
	public List findFirst( int userid,int currentPage,int PageSize,int roleId);
	/**
	 * 查找本月已完成的任务()
	 * @param userid         咨询师的ID
	 * @param currentPage    当前页
	 * @param PageSize       每页大小
	 * @param roleId         角色ID
	 * @return               查找到的本月已办事项
	 */
	public List findMonth(int userid,int currentPage,int PageSize, int roleId) ;
	
	
	/**
	 * 
	 * @param id            咨询师的ID  
	 * @param currentPage   当前页
	 * @param pageSize      每页大小
	 * @return              该咨询师所添加的回访记录
	 */
	public  List findVisitedByRole(int customerID,int currentPage,int pageSize);
}
