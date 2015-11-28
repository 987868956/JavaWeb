package system;

import static org.junit.Assert.*;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.dao.BaseDao;
import com.seecen.system.po.Log;
import com.seecen.system.po.User;

public class LogDaoImplTest {
	private static  BaseDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		
		dao  = (BaseDao) context.getBean("moudleDao");
		System.out.println("dao");
	}
	

	@Test
	public void testAddObject() {
		
		
		
		Log log=new Log();
		for(int i=0;i<3;i++){
		log.setEvent("查询用户"+i);
		User user=(User)dao.findObjectById(User.class, 1);
		log.setUser(user);
		/*SimpleDateFormat sdf=new SimpleDateFormat("2012-12-11");
		Date dtf=new Date();
		sdf.format(dtf);
		log.setLogDate(dtf);*/
		dao.addObject(log);
		}
	}

	@Test
	public void testUpdateObject() {
		fail("Not yet implemented");
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
