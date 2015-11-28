package market;

import system.UserDaoImplTest;

public class InsertData {
	public static void main(String[] args) throws Exception {
		CentretDaoImplTest  t1= new CentretDaoImplTest();
		CentretDaoImplTest.setUpBeforeClass();
		UserDaoImplTest u1 = new UserDaoImplTest();
		UserDaoImplTest.setUpBeforeClass();
		DepartmentDaoImplTest t2 = new DepartmentDaoImplTest();
		DepartmentDaoImplTest.setUpBeforeClass();
		ChannelDaoTest t3 = new  ChannelDaoTest();
		ChannelDaoTest.setUpBeforeClass();
		CustomerDaoImplTest t4 = new CustomerDaoImplTest();
		CustomerDaoImplTest.setUpBeforeClass();
		VisitedDaoImplTest t5 = new VisitedDaoImplTest();
		VisitedDaoImplTest.setUpBeforeClass();
		t1.testAddObject();
		t2.testAddObject();
		u1.testAddObject();
		t3.testAddObject();
		t4.testAddObject();
		t5.testAddObject();
	}
}
