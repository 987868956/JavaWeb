package system;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.seecen.dao.BaseDao;
import com.seecen.market.po.Centre;
import com.seecen.system.Impl.MoudleDaoImpl;
import com.seecen.system.dao.MoudleDao;
import com.seecen.system.po.Moudle;
import com.seecen.system.po.Role;
import com.seecen.system.po.User;

public class MoudleDaoImplTest {
	private static  BaseDao dao ;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		
		dao  = (BaseDao) context.getBean("moudleDao");
		System.out.println("dao");
	}
	/*private int id;   //模块ID
    private String name;  //模块名称
    private String url;    //模块路径
    private String status;   //模块状态
    private Moudle parentMoudle;  //父类模块
    private Set<Moudle> sonMoudles; //子类模块
    private Set<Role>  roles;  //模块角色
	 * 
	 * 
	 * */
	

	@Test
	public void testAddObject() {
	
		Moudle moudle=new Moudle();
	
		for(int i=0;i<3;i++){
			/*
			moudle.setName("系统管理"+i);
			moudle.setUrl("www.seecen.com"+i);
			moudle.setIsson("0");//注意：0表示是父级模块   1表示是子级模块
			dao.addObject(moudle);*/
			Moudle parentMoudle=(Moudle)dao.findObjectById(Moudle.class, 1);
			moudle.setName("日志事件管理"+i);
			moudle.setUrl("www.seecen.com"+i);
			moudle.setIsson("1");
			
			moudle.setParentMoudle(parentMoudle);
			
			dao.addObject(moudle);
		}
		
	}

	@Test
	public void testUpdateObject() {
		
		//Moudle moudle=new Moudle();
		Moudle moudle=(Moudle)dao.findObjectById(Moudle.class, 1);
		
		
		moudle.setUrl("www.58.com");
		moudle.setStatus("0");
		Assert.assertTrue(dao.updateObject(moudle));
		
		
		
	}

	@Test
	public void testDeleteObject() {
		Assert.assertTrue(dao.deleteObject(Moudle.class, 3));
		//注一般不做真正的删除，只是改变状态
	}

	@Test
	public void testFindObjectById() {
		Moudle moudle=(Moudle)dao.findObjectById(Moudle.class, 1);
		System.out.println(moudle);
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("name", "日志");
		List list = dao.findAll(Moudle.class,filter , 1, 4);
		//1  表示第一页      4  表示每页显示多少条记录
		for(Object obj:list){
			Moudle m = (Moudle)obj;
			System.out.println(m.getName());
		 
		
		
		
	}
	}
	
	
//	@Test
//	public void testFindIssonAll() {
//		
//		MoudleDao moudleDao=new MoudleDaoImpl();
//		List list=moudleDao.findIssonAll(Moudle.class, "0");
//		for(Object obj:list){
//			Moudle m = (Moudle)obj;
//			System.out.println(m.getName());
//		 
//		
//		
//		
//	}
//
//}
	}
