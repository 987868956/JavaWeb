package market;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.market.dao.CustomerDao;
import com.seecen.market.po.Centre;
import com.seecen.market.po.Channel;
import com.seecen.market.po.Customer;
import com.seecen.system.po.User;
/*
 * 2015年10月10日13:39:29  测试通过   龚涛
 */
public class CustomerDaoImplTest {


	private static  CustomerDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		dao  = (CustomerDao) context.getBean("customerDao");
		System.out.println(dao);
	}

	@Test
	public void testAddObject() {
		Centre centre = (Centre) dao.findObjectById(Centre.class, 1);
		Channel channel = (Channel) dao.findObjectById(Channel.class, 1);
		User user = (User) dao.findObjectById(User.class, 1);
		for(int i=0;i<10;i++){
		//Customer cons = new Customer(name, sex, birthday, telephone, qq, email, schoolName, collegeName, reportTime, createTime, address, consultContent, major, user, location, centre, channel, status, intention)	;
		Customer cons = new Customer("咨询人"+i, "男", new Date(), "12312321312", "21343543", "987868956@qq.com", "北京大学", "计算机学院", new Date(), new Date(), "北京王府井西大街", "ahhah", "计算机科学与技术", user, "广州", centre, channel, "1", "2",new Date());
		System.out.println(dao.addObject(cons));
		}
	}

	@Test
	public void testUpdateObject() {
		Customer con = (Customer) dao.findObjectById(Customer.class, 2);
		con.setAddress("南昌绿地");
		System.out.println(dao.updateObject(con));
	}

	@Test
	public void testDeleteObject() {
		/*
		 * 对潜在客户删除不是改变状态位,而是真的从数据库中删掉该条记录
		 */
		//Customer con = (Customer) dao.findObjectById(Customer.class, 3);
		dao.deleteObject(Customer.class, 3);
	}

	@Test
	public void testFindObjectById() {
		System.out.println(dao.findObjectById(Customer.class, 5));
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("name", "5");
		List list = dao.findAll(Customer.class, filter, 1, 5);
		for(int i=0;i<list.size();i++){
			System.out.println(((Customer)list.get(i)).getName());
		}
	}

}
