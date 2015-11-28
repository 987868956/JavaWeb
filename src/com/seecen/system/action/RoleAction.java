package com.seecen.system.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;

import com.seecen.system.dao.RoleDao;


import com.seecen.system.po.Role;
import com.seecen.system.vo.RoleVo;


	public class RoleAction  extends BaseAction  implements ModelDriven<Role> {
	
	private Role role;
	private RoleDao roleDao;
	
	
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		Map filter=new HashMap();
		List<Role> roles =roleDao.findAll(Role.class, filter, 1, 999);
		
		this.request.setAttribute("roles", roles);
		this.request.setAttribute("count", roles.size());
		//全部记录大小

		return SUCCESS;
		
	}
	
	
	
	public Role getModel() {
		// TODO Auto-generated method stub
		role=new Role();
		return role;
	   }
	
	public String add() throws Exception {
		
		boolean f=roleDao.addObject(role);
		if(f){
			return "add";
		}else{
			return "error";
		}
	
	}
	
	
	public String getPageRole() throws Exception {
		
		
		 String roleId = this.request.getParameter("cid");

	     int id = 0;
	     System.out.println(roleId);
			if(roleId!=null && !"".equals(roleId)){
				id = Integer.parseInt(roleId);
			   }	
		Role role=(Role)roleDao.findObjectById(Role.class, id);
		RoleVo rolevo=new RoleVo();
		JSONObject jsonRole=new JSONObject();
		BeanUtils.copyProperties(rolevo, role);	
		 	
		 try{
			 jsonRole.element("role", rolevo);
		 }catch(Exception e){
			 e.printStackTrace();
		 }
		
		 System.out.println(jsonRole.toString());
		 
			PrintWriter out = this.response.getWriter();
			
			out.write(jsonRole.toString());
			out.flush();
			out.close();
			return null;
		
	}
	
	public String updataRole() throws Exception {
		
		 
		 String roleId = this.request.getParameter("id");

	     int id = 0;
	     System.out.println(roleId);
			if(roleId!=null && !"".equals(roleId)){
				id = Integer.parseInt(roleId);
			   }
			System.out.println(id+"*******************************8");
			role.setId(id);
	
			boolean f=roleDao.updateObject(role);
			if(f){
				return "updata";
			}else{
				
				return ERROR;
			}
		   
		
		
		
		
	}
	public String delRole() throws Exception {
		String roleId = this.request.getParameter("id");

	     int id = 0;
	     System.out.println(roleId);
			if(roleId!=null && !"".equals(roleId)){
				id = Integer.parseInt(roleId);
			   }
			
			boolean f=roleDao.deleteObject(Role.class, id);
		
			if(f){
				return "del";
			}else{
				
				return ERROR;
			}
		
		
	}
	public String changeRoleStatus() throws Exception {
		 String roleId = this.request.getParameter("id");
		     int id = 0;
				if(roleId!=null && !"".equals(roleId)){
					id = Integer.parseInt(roleId);
				   }
				System.out.println("yyyyyyyyyyyy修改状态");
				Role role=(Role) roleDao.findObjectById(Role.class, id);
				String status=role.getStatus();
				if("1".equals(status)){
					role.setStatus("0");
				}else{
					role.setStatus("1");
				}
				roleDao.updateObject(role);
			     return "change";
				
				
		
		
		
		
		
		
	}

	
	}


