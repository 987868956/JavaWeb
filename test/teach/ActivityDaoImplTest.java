package teach;

import static org.junit.Assert.fail;

import java.util.Date;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.dao.BaseDao;
import com.seecen.teach.po.Activity;
import com.seecen.teach.po.Course;

public class ActivityDaoImplTest {
	private static BaseDao dao;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		dao  = (BaseDao) context.getBean("marketDao");
		System.out.println("dao");
	}

	@Test
	public void testAddObject() {
		Course course=(Course) dao.findObjectById(Course.class, 1);
		for(int i=0;i<100;i++){
			Activity activity=new Activity(course, "BBQ", new Date(), "瑶湖");
			dao.addObject(activity);
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
