package market;

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
/*
 * 2015年10月10日09:28:13  测试完毕   龚涛
 */
public class CentretDaoImplTest {
	private static  BaseDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		dao  = (BaseDao) context.getBean("marketDao");
		System.out.println("dao");
		
	}

	@Test     
	public  void testAddObject() {
		for(int i=0;i<2;i++){
			Centre centre = new Centre("南昌中心"+i, "南昌绿地新都会"+i, "0791-85708781", "1", "www.seecen.com",new Date());
			dao.addObject(centre);
		}
		
		
	}

	@Test
	public void testUpdateObject() {
		Centre centre = new Centre("广州中心", "广州新山", "0791-85708781", "1", "www.seecen.com",new Date());
		centre.setCid(3);
		Assert.assertTrue(dao.updateObject(centre));
	}

	@Test
	public void testDeleteObject() {

		Assert.assertTrue(dao.deleteObject(Centre.class, 2));
	}

	@Test
	public void testFindObjectById() {
		System.out.println(dao.findObjectById(Centre.class, 1));
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("cname", "中心");
		List list = dao.findAll(Centre.class,filter , 1, 2);
		for(Object obj:list){
			Centre c = (Centre)obj;
			System.out.println(c.getCname());
		}
	}

}
