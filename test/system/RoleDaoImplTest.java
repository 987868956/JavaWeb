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
import com.seecen.system.po.Role;
import com.seecen.system.po.User;

public class RoleDaoImplTest {
	private static  BaseDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		
		dao  = (BaseDao) context.getBean("roleDao");
		System.out.println("dao");
	}

	@Test
	public void testAddObject() {
		Role role=new Role();
		for(int i=0;i<2;i++){
		
		role.setName("业务员"+i);
		dao.addObject(role);
		}
		
		
	}

	@Test
	public void testUpdateObject() {
Role role=(Role)dao.findObjectById(Role.class, 1);
		
		
		role.setName("管理员");
		Assert.assertTrue(dao.updateObject(role));
	}

	@Test
	public void testDeleteObject() {
		//Assert.assertTrue(dao.deleteObject(Role.class, 3));
	}

	@Test
	public void testFindObjectById() {
		Role role=(Role)dao.findObjectById(Role.class, 1);
		System.out.println(role);
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("name", "主管");
		List list = dao.findAll(Role.class,filter ,1, 2);
		//1  表示第一页      4  表示每页显示多少条记录
		for(Object obj:list){
			Role r = (Role)obj;
			System.out.println(r.getName());
	}
	}
}
