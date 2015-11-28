package com.seecen.system.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.beanutils.BeanUtils;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.system.dao.MoudleDao;
import com.seecen.system.dao.RoleAuthDao;
import com.seecen.system.dao.RoleDao;
import com.seecen.system.po.Moudle;
import com.seecen.system.po.Role;
import com.seecen.system.po.RoleAuth;
import com.seecen.system.po.RoleAuthDoublePk;
import com.seecen.system.po.MoudleVo;
import com.seecen.system.vo.RoleVo;

public class AuthAction extends BaseAction  implements ModelDriven<RoleAuth>{
	private RoleDao roleDao;
	private MoudleDao moudleDao;
	private RoleAuthDao roleAuthDao;
	private Role role;
	private Moudle moudle;
	private RoleAuth roleauth;
	
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public void setMoudleDao(MoudleDao moudleDao) {
		this.moudleDao = moudleDao;
	}

	public void setRoleAuthDao(RoleAuthDao roleAuthDao) {
		this.roleAuthDao = roleAuthDao;
	}	
	public RoleAuth getModel() {
		roleauth  = new RoleAuth();
		return roleauth;
	}
	
	@Override
	
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		
		Map filter=new HashMap();
		List<Role> roles =roleAuthDao.findAll(Role.class, filter, 1, 999);
		this.request.setAttribute("roles", roles);
		
		//List<Moudle> moudles =roleAuthDao.findAll(Moudle.class, filter, 1, 999);
		
		List<Moudle> moudles =moudleDao.findSonMoudle(Moudle.class, "1");
		System.out.println(moudles+"111111111");
		this.request.setAttribute("moudles", moudles);
		this.request.setAttribute("moudlesSize", moudles.size());
		return SUCCESS;
	}

	
	
	
	
	public String AddRoleAuth() throws Exception {
		
   String [] modid = this.request.getParameterValues("moudlesId");
		
		String roid = this.request.getParameter("roles");
		
		int moudleId = 0, roleId = 0;
		
		List<RoleAuthDoublePk> list=new ArrayList<RoleAuthDoublePk>();
		
	
		 if(roid!=null && !"".equals(roid)){
			  roleId = Integer.parseInt(roid);
			  
			  if(modid!=null && !"".equals(modid)){
				 
				  for(String mods:modid){
					 RoleAuthDoublePk authPk = new RoleAuthDoublePk();
					moudleId = Integer.parseInt(mods);	
					
					authPk.setModuleId(moudleId);
					
					authPk.setRoleId(roleId);
					list.add(authPk);
				}
			}
	       }
		// delete from RoleAuth where pk.roleId=?
		
			
		for(int i=0;i<list.size();i++){
			RoleAuth roleauth = new RoleAuth();
			roleauth.setPk(list.get(i));
			System.out.println(list.get(i));
			roleAuthDao.addObject(roleauth);
		     }
		
		
		return "addRoleAuth";
		
		
		
	}
	public String UpdataRoleAuth() throws Exception {
		System.out.println("进入修改方法");
		String [] modid = this.request.getParameterValues("moudlesId");
		
		String roid = this.request.getParameter("roles");
		
		int moudleId = 0, roleId = 0;
		
		List<RoleAuthDoublePk> list=new ArrayList<RoleAuthDoublePk>();
		 if(roid!=null && !"".equals(roid)){
			  roleId = Integer.parseInt(roid);
			  
			  if(modid!=null && !"".equals(modid)){
				  for(String mods:modid){
					 RoleAuthDoublePk authPk = new RoleAuthDoublePk();
					moudleId = Integer.parseInt(mods);	
					
					authPk.setModuleId(moudleId);
					
					authPk.setRoleId(roleId);
					
					list.add(authPk);
				}
			}

	       }
		Role role=(Role)roleDao.findObjectById(Role.class, roleId);
		this.request.setAttribute("role", role);
		
		boolean f=roleAuthDao.deleteRoleAuthByroleId(roleId);
		// delete from RoleAuth where pk.roleId=?
		if(f){	
			System.out.println("删除角色");
		for(int i=0;i<list.size();i++){
			RoleAuth roleauth = new RoleAuth();
			roleauth.setPk(list.get(i));
			
			System.out.println(list.get(i));
			
			roleAuthDao.addObject(roleauth);
		     }
		}
		
		return "updataRoleAuth";
		
	}

	public String getRole() throws Exception {
		try{
			//修改使用
			//String roid = this.request.getParameter("rolesId");
			String roid = this.request.getParameter("rolesId");
			int roleId=0;
			if(roid!=null && !"".equals(roid)){
			 roleId = Integer.parseInt(roid);
			}
			System.out.println(roleDao);
			System.out.println(roleId+"是..........roleid");
			Role role=(Role)roleDao.findObjectById(Role.class, roleId);
			
		   // this.request.setAttribute("role", role)
		     Set<Moudle> moudle=role.getMoudles();
		     List<MoudleVo> vos=new ArrayList<MoudleVo>();
		     Iterator<Moudle> its= moudle.iterator();
		     while(its.hasNext()){
		    	 Moudle m=its.next();
		    	 MoudleVo vo=new MoudleVo();
		    	 BeanUtils.copyProperties(vo, m);
		    	 vos.add(vo);
		        }
		      RoleVo rolevo=new RoleVo();
			 BeanUtils.copyProperties(rolevo, role);	
			
			JSONObject moudleObj = new JSONObject();
			moudleObj.element("role", rolevo);
			moudleObj.element("moudle", vos);
			PrintWriter out = this.response.getWriter();
			out.write(moudleObj.toString());
			out.flush();
			out.close();
			}catch(Exception e){
			e.printStackTrace();
		}
		return null;
		
		
	}
	
	
	
	

}
