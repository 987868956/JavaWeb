package com.seecen.system.po;

/*权限表联合主键
 * 
 * UserRoleDoublePk类，里面  角色ID   模块ID
 * */


public class RoleAuth {
 
	


	private RoleAuthDoublePk pk;
	
	
	public RoleAuth(RoleAuthDoublePk pk) {
		super();
		this.pk = pk;
	}
	

	public RoleAuth() {
		
	}




	public RoleAuthDoublePk getPk() {
		return pk;
	}

	public void setPk(RoleAuthDoublePk pk) {
		this.pk = pk;
	}
	

	@Override
	public String toString() {
		return "RoleAuth [pk=" + pk + "]";
	}
	
	
	
}
