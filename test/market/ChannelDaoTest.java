package market;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.market.dao.ChannelDao;
import com.seecen.market.po.Channel;
/*
 * 2015年10月10日13:09:48 测试完毕   龚涛
 */
public class ChannelDaoTest {

	private static  ChannelDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		dao  = (ChannelDao) context.getBean("channelDao");
		System.out.println("dao");
	}

	@Test
	public void testAddObject() {
		/*
		 * 当关联外键时,如果需要引用关联对象,该对象就必须是持久态,而不能是new出来的对象(瞬时态)
		 */
		
		//Channel pChannel = (Channel) dao.findObjectById(Channel.class, 1);
		for(int i=0;i<2;i++ ){
			Channel channel = new Channel("学习网站"+i, null, "1",new Date());
			dao.addObject(channel);
		}
		
		
	}

	@Test
	public void testUpdateObject() {
		Channel pChannel = (Channel) dao.findObjectById(Channel.class, 1);
		pChannel.setStatus("1");
		System.out.println(dao.updateObject(pChannel));
	}
	@Test
	public void testFreezeStatus(){
		Channel pChannel = (Channel) dao.findObjectById(Channel.class, 1);
		System.out.println(pChannel);
		dao.freezeStatus(pChannel);
		
	}

	@Test
	public void testDeleteObject() {
		/*
		 * 调用freezeStatus()方法
		 */
	}

	@Test
	public void testFindObjectById() {
		Channel pChannel = (Channel) dao.findObjectById(Channel.class, 1);
		System.out.println(pChannel);
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("name", "学习");
		List list = dao.findAll(Channel.class, filter, 1, 5);
		for(int i=0;i<list.size();i++){
			System.out.println(((Channel)list.get(i)).getName());
		}
	}

}
