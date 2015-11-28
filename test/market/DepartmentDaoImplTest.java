package market;

import static org.junit.Assert.*;

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
import com.seecen.market.po.Department;
/*
 * 2015年10月10日09:28:43 测试完毕    龚涛
 */
public class DepartmentDaoImplTest {
	private static  BaseDao dao ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext*.xml");
		System.out.println(context.getBean("sessionFactory"));
		dao  = (BaseDao) context.getBean("deptDao");
		System.out.println("dao");
	}

	@Test
	public void testAddObject() {
		Centre cen1 = (Centre)dao.findObjectById(Centre.class, 1);
		
		Department dep = new Department("市场部", "1810", "1", cen1,new Date());
		Department dep1 = new Department("教学部", "1809", "1", cen1,new Date());
		Department dep2 = new Department("职业发展部", "1810", "1", cen1,new Date());
		Department dep3 = new Department("办公室", "1811", "1", cen1,new Date());
		dao.addObject(dep);
		dao.addObject(dep1);
		dao.addObject(dep2);
		dao.addObject(dep3);
	}

	@Test
	public void testUpdateObject() {
		Department dep =(Department) dao.findObjectById(Department.class,1);
		dep.setStatus("0");
		Assert.assertTrue(dao.updateObject(dep));
	}

	@Test
	public void testDeleteObject() {
		//删除并不是将数据删除,而是将状态改为不可用  "0";
		Department dep =(Department) dao.findObjectById(Department.class,1);
		dep.setStatus("0");
		Assert.assertTrue(dao.updateObject(dep));
	}

	@Test
	public void testFindObjectById() {
		System.out.println(dao.findObjectById(Department.class, 21));
	}

	@Test
	public void testFindAll() {
		Map filter = new HashMap();
		filter.put("deptname", "部");
		List list = dao.findAll(Department.class,filter , 1, 5);
		for(Object obj:list){
			Department c = (Department)obj;
			System.out.println(c.getDeptname());
		}
	}

}
