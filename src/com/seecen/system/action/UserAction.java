package com.seecen.system.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.market.dao.CentreDao;
import com.seecen.market.dao.DepartmentDao;
import com.seecen.market.po.Centre;
import com.seecen.market.po.Department;
import com.seecen.system.dao.RoleDao;
import com.seecen.system.dao.UserDao;
import com.seecen.system.po.Moudle;
import com.seecen.system.po.Role;
import com.seecen.system.po.User;
import com.seecen.system.vo.UserVo;

public class UserAction extends BaseAction  implements ModelDriven<User> {



private User user;
  
    private Role role;
	private Centre centre;
	private Department deparetment;
	private RoleDao roleDao;
	private DepartmentDao  deparetmentDao;
	private UserDao userDao;
	private CentreDao centreDao;
	
	

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}


	public void setDeparetmentDao(DepartmentDao deparetmentDao) {
		this.deparetmentDao = deparetmentDao;
	}


	public void setCentreDao(CentreDao centreDao) {
		this.centreDao = centreDao;
	}


	public void setUserDao(UserDao userDao) {
	this.userDao = userDao;
}

	

	public User getModel() {
		user=new User();
		return user;
	
	}
		  @Override
			public String execute() throws Exception {
				// TODO Auto-generated method stub
			  Map filter=new HashMap();
				List<User> users =userDao.findAll(User.class, filter, 1, 999);
				List<Role> roles =userDao.findAll(Role.class, filter, 1, 999);
				List<Department> deparetments =userDao.findAll(Department.class, filter, 1, 999);
				List<Centre> centres =userDao.findAll(Centre.class, filter, 1, 999);
				this.request.setAttribute("users", users);
				this.request.setAttribute("roles", roles);
				this.request.setAttribute("deparetments", deparetments);
				this.request.setAttribute("centres", centres);
		
				this.request.setAttribute("count", users.size());
				//全部记录大小
		
				return SUCCESS;	
			}
		  public String addUser() throws Exception {
			  String rid = this.request.getParameter("roleId");
				String cid = this.request.getParameter("centerId");
				String did = this.request.getParameter("deptId");
				
				int roleId = 0, centerId = 0,deptId=0 ;
				
				if(rid!=null && !"".equals(rid)){
					roleId = Integer.parseInt(rid);
				}
				if(cid!=null && !"".equals(cid)){
					centerId = Integer.parseInt(cid);
				}
				if(did!=null && !"".equals(did)){
					deptId = Integer.parseInt(did);
				}
				System.out.println(roleId);
				System.out.println(centerId);
				System.out.println(deptId);
				
				Role role = (Role) userDao.findObjectById(Role.class, roleId);
				Centre centre=(Centre)userDao.findObjectById(Centre.class, centerId);
				Department deparetment=(Department)userDao.findObjectById(Department.class, deptId);
				//System.out.println(role);
				//System.out.println(centre);
				//System.out.println(deparetment);
				user.setRole(role);
				user.setCenters(centre);
				user.setDepts(deparetment);
				boolean result = userDao.addObject(user);
				System.out.println(result);
				
				if(result){
					return"addUser";
				}else{
					return"error";
				}
				
			}
		  public String getpageUserById() throws Exception {
			  
			  String uid = this.request.getParameter("userid");
				int id = 0;
				if(uid!=null && !"".equals(uid)){
					id = Integer.parseInt(uid);
				}
				User user = (User) userDao.findObjectById(User.class, id);
			
				UserVo vo=new UserVo();
				JSONObject userObj = new JSONObject();
				BeanUtils.copyProperties(vo, user);
				vo.setRoleId(user.getRole().getId());
				vo.setCenterId(user.getCenters().getCid());
				vo.setDeptId(user.getDepts().getDeptid());
				userObj.element("user", vo);
				PrintWriter out = this.response.getWriter();
				out.write(userObj.toString());
				System.out.println("修改用户"+userObj.toString());
				out.flush();
				out.close();
				return null;
			  
		  }
		  public String changeUserStatus() throws Exception {
			
			  String uid = this.request.getParameter("userId");
			  int userId=0;
			  if(uid!=null && !"".equals(uid)){
				  userId = Integer.parseInt(uid);
				}
			 User user=(User)userDao.findObjectById(User.class, userId);
			 String status=user.getStatus();
			 if("1".equals(status)){
				 user.setStatus("0");
				}else{
					user.setStatus("1");
				}
			  
			 userDao.updateObject(user);
			 
			  return "changeStatus";
			  
		       }
		  
		  public String updataUser() throws Exception {
			  String uid = this.request.getParameter("userId");
			  int userId=0;
			  if(uid!=null && !"".equals(uid)){
				  userId = Integer.parseInt(uid);
				}
			 user.setId(userId);
			 
			 String rid = this.request.getParameter("roleId");
				String cid = this.request.getParameter("centerId");
				String did = this.request.getParameter("deptId");
				
				int roleId = 0, centerId = 0,deptId=0 ;
				
				if(rid!=null && !"".equals(rid)){
					roleId = Integer.parseInt(rid);
				}
				if(cid!=null && !"".equals(cid)){
					centerId = Integer.parseInt(cid);
				}
				if(did!=null && !"".equals(did)){
					deptId = Integer.parseInt(did);
				}
				System.out.println(roleId);
				System.out.println(centerId);
				System.out.println(deptId);
				
				Role role = (Role) userDao.findObjectById(Role.class, roleId);
				Centre centre=(Centre)userDao.findObjectById(Centre.class, centerId);
				Department deparetment=(Department)userDao.findObjectById(Department.class, deptId);
				//System.out.println(role);
				//System.out.println(centre);
				//System.out.println(deparetment);
				user.setRole(role);
				user.setCenters(centre);
				user.setDepts(deparetment);
			 
			 boolean f=userDao.updateObject(user);
				if(f){
					return "updata";
				}else{
					
					return "error";
				}
				  
			  
		  }
		  
		  
		  
		  public String delUser() throws Exception {
			  String uid=request.getParameter("ids");
			  int userId=0;
			  if(uid!=null && !"".equals(uid)){
					userId = Integer.parseInt(uid);
				   }
			  System.out.println(userId+"是需要输出的ID");
			  boolean f=userDao.deleteObject(User.class, userId);
			  if(f){
				  System.out.println("删除成功");
				  return "delUser";
			  }else {
				return "error";
			}
			
			  
			  
			  
		  }
		  
}
