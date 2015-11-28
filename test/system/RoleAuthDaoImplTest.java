package system;

import static org.junit.Assert.*;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.dao.BaseDao;
import com.seecen.system.po.Moudle;
import com.seecen.system.po.Role;
import com.seecen.system.po.RoleAuth;
import com.seecen.system.po.RoleAuthDoublePk;

public class RoleAuthDaoImplTest {
	private static  BaseDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		
		dao  = (BaseDao) context.getBean("roleAuthDao");
		System.out.println("dao");
	}

	@Test
	public void testAddObject() {
		RoleAuth roleAuth=new RoleAuth();
		
		//Moudle moudle=new Moudle();
		//Role role=(Role)dao.findObjectById(Role.class, 1);
		
		//RoleAuthDoublePk pk=new RoleAuthDoublePk(1,1);
		RoleAuthDoublePk pk=new RoleAuthDoublePk(2,1);
		roleAuth.setPk(pk);
		dao.addObject(roleAuth);
		
		
	}

	@Test
	public void testUpdateObject() {
		/*
		 * */
		//Role role=(Role)dao.findObjectById(Role.class, 1);
		//Moudle moudle=(Moudle)dao.findObjectById(Moudle.class, 1);
		RoleAuth roleAuth=new RoleAuth();
		
		RoleAuthDoublePk pk=new RoleAuthDoublePk();
		pk.setModuleId(1);
		pk.setRoleId(3);
		roleAuth.setPk(pk);
		Assert.assertTrue(dao.updateObject(pk));


		
	}

	@Test
	public void testDeleteObject() {
		fail("Not yet implemented");
	}

	@Test
	public void testFindObjectById() {
		fail("Not yet implemented");
	}

	@Test
	public void testFindAll() {
		fail("Not yet implemented");
	}

}
