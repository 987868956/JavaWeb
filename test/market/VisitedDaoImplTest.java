package market;

import static org.junit.Assert.fail;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.market.dao.VisitedDao;
import com.seecen.market.po.Customer;
import com.seecen.market.po.Visited;
import com.seecen.system.po.User;

public class VisitedDaoImplTest {

	private static  VisitedDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		dao  = (VisitedDao) context.getBean("visitedDao");
		System.out.println(dao);
	}


	@Test
	public void testAddObject() {
		Customer con = (Customer) dao.findObjectById(Customer.class, 5);
		User user = (User) dao.findObjectById(User.class, 1);
		for(int i=0;i<10;i++){
			Visited visit = new Visited(con, user, "fdfadsfdsfdasf"+i, "hello"+i, new Date(), new Date());
			dao.addObject(visit);
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
		Visited visit = (Visited) dao.findObjectById(Visited.class, 1);
		System.out.println(visit);
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("title", "");
		List list = dao.findAll(Visited.class,filter , 1, 5);
		for(Object obj:list){
			Visited c = (Visited)obj;
			System.out.println(c.getTitle());
		}
	}

}
