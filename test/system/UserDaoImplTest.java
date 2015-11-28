package system;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.dao.BaseDao;
import com.seecen.market.po.Centre;
import com.seecen.market.po.Department;
import com.seecen.system.po.Moudle;
import com.seecen.system.po.Role;
import com.seecen.system.po.User;

public class UserDaoImplTest {
	private static  BaseDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		
		dao  = (BaseDao) context.getBean("userDao");
		
		System.out.println("dao");
	}

	/*private int id;   //用户ID
	 private String userName;  //用户name
	 private String pass;    //用户密码
	 private String status="1";   //用户状态
	 private String sex;     //用户性别
	 private String userTel;   //用户电话
	 private String qq;     //用户QQ
	 private String email;   //用户Email
	 private Role  role;    //用户对应的角色
	 private Department depts;  //部门
	 private Centre centers;   //中心
	 
	 * */
	
	@Test
	public void testAddObject() {
for(int i=0;i<3;i++){
	Role role=(Role) dao.findObjectById(Role.class, 1);
	Department depts=(Department)dao.findObjectById(Department.class, 1);
	Centre centers=(Centre)dao.findObjectById(Centre.class, 1);
	
	
			User user = new  User("admin"+i, "123", "男", "10086",
					"110", "123@qq.com", role, depts,centers);
			dao.addObject(user);
		}
	}

	@Test
	public void testUpdateObject() {
		User user=(User)dao.findObjectById(User.class, 1);
		
		
		user.setSex("女");
		Assert.assertTrue(dao.updateObject(user));
		
	}

	@Test
	public void testDeleteObject() {
		Assert.assertTrue(dao.deleteObject(User.class, 3));
		
	}

	@Test
	public void testFindObjectById() {
		User user=(User)dao.findObjectById(User.class, 1);
		System.out.println(user);
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("userName", "admin");
		List list = dao.findAll(User.class,filter , 1, 4);
		//分页加模糊
		//1  表示第一页      4  表示每页显示多少条记录
		for(Object obj:list){
			User u = (User)obj;
			System.out.println(u.getUserName());
	}

}
	}
