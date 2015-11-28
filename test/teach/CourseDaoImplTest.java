package teach;

import static org.junit.Assert.fail;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.seecen.system.po.User;
import com.seecen.teach.po.Course;

public class CourseDaoImplTest {
	private static BaseDao dao;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		dao  = (BaseDao) context.getBean("courseDao");
		System.out.println("dao");
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("className", "Fate Zero");
		List list = dao.findAll(Course.class,filter , 1, 4);
		for(Object obj:list){
			Course c = (Course)obj;
			System.out.println(c.getClassroom());
		}
	}

	@Test
	public void testAddObject() {		
		for(int i=0;i<15;i++){
			User user=(User) dao.findObjectById(User.class, i);
			User u1=(User) dao.findObjectById(User.class, i);
			Centre cen= (Centre) dao.findObjectById(Centre.class, i);
			
			Course course=new Course("SC00"+i, new Date(), i, user, u1, "a"+i, cen,"第"+i+"阶段");
			dao.addObject(course);
		}
	}

	@Test
	public void testUpdateObject() {
		User user=(User) dao.findObjectById(User.class, 2);
		User u1=(User) dao.findObjectById(User.class, 2);
		Centre cen= (Centre) dao.findObjectById(Centre.class, 2);
		SimpleDateFormat sdf=new SimpleDateFormat("2020-12-11");
		Date dt=new Date();
		sdf.format(dt);
		Course course=new Course("Fate Zero", dt, 100, user, u1, "Assassination", cen, "毕业");
		course.setId(3);
		Assert.assertTrue(dao.updateObject(course));
	}

	@Test
	public void testDeleteObject() {
		
	}

	@Test
	public void testFindObjectById() {
		Course course= (Course) dao.findObjectById(Course.class, 3);
		System.out.println(course);
	}

}
