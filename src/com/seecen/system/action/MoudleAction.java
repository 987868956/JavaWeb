package com.seecen.system.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.beanutils.BeanUtils;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.dao.BaseDao;
import com.seecen.system.dao.MoudleDao;
import com.seecen.system.po.Moudle;
import com.seecen.system.vo.MoudleVo;




public class MoudleAction extends BaseAction  implements
ModelDriven<Moudle>{
	private Moudle moudle;
	private MoudleDao moudleDao;


	public void setMoudleDao(MoudleDao moudleDao) {
		this.moudleDao = moudleDao;
	}




	@Override
	public String execute() throws Exception {
		//System.out.println("sgjdioghdohod");
		
		/*Map filter=new HashMap();
		List<Moudle> moudles =moudleDao.findAll(Moudle.class, filter, 1, 999);
		this.request.setAttribute("moudles", moudles);*/
		
		try{
			/*Map filter=new HashMap();
			List<Moudle> moudles =moudleDao.findAll(Moudle.class, filter, 1, 999);*/
			List<Moudle> moudles =moudleDao.findIssonAll(Moudle.class, "0");

			this.request.setAttribute("moudles", moudles);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return SUCCESS;
		
	}

	public Moudle getModel() {
		moudle=new Moudle();
		return moudle;
	}
	public String add() throws Exception {
		/*
		List<Moudle> addtMoudle =moudleDao.findIssonAll(Moudle.class, "0");
		this.request.setAttribute("addtMoudle", addtMoudle);
		
		return "parMoudle";*/
		
		String p = this.request.getParameter("parentId");
		//System.out.println(p);
			String isson = moudle.getIsson();
			if("1".equals(isson)){
				
				int parentId = 0;
				if(p!=null && !"".equals(p)){
					parentId = Integer.parseInt(p);
					
					System.out.println(parentId);
					
				}
				Moudle pmoudle = (Moudle)moudleDao.findObjectById(Moudle.class, parentId);
				
				
				moudle.setParentMoudle(pmoudle);
			}
			

			moudleDao.addObject(moudle);
			
		return "add";
		
	}
	
	
	
	public String changeMoudleStatus() throws Exception {
		
		
		  String moudleId = this.request.getParameter("moudleId");
		  
		
		  
		  //System.out.println(moudleId);
		  
		  
		     int id = 0;
				if(moudleId!=null && !"".equals(moudleId)){
					id = Integer.parseInt(moudleId);
				   }
				//System.out.println(id);
				Moudle moudle = (Moudle)moudleDao.findObjectById(Moudle.class, id);
				String status=moudle.getStatus();
				
				if("1".equals(status)){
					moudle.setStatus("0");
				}else{
					moudle.setStatus("1");
				}
				
					//禁用模块 ，就是改变模块状态，在改变父类模块与子类模块的时候，要分开改变
				if("1".equals(moudle.getIsson())){   
					//判断是否是子类模块
					Set<Moudle> sonModules = moudle.getSonMoudles();//获取所有子模块
					
					Iterator<Moudle> iterator = sonModules.iterator();//迭代器遍历子类模块
					while(iterator.hasNext()){
						Moudle sonMoudle = iterator.next();
						sonMoudle.setStatus(moudle.getStatus());//找到子模块  获取子模块状态
						moudleDao.updateObject(sonMoudle);
					}
				}
				moudleDao.updateObject(moudle);
				
				
		     return "change";
		
	   }
	
	
	
	
	
	
	
	public String getPagemoudle() throws Exception {
		
		 String moudleId = this.request.getParameter("id");

	     int id = 0;
	     System.out.println(moudleId);
			if(moudleId!=null && !"".equals(moudleId)){
				id = Integer.parseInt(moudleId);
			   }
			Moudle moudle = (Moudle)moudleDao.findObjectById(Moudle.class, id);
			
			MoudleVo moudlevo=new MoudleVo();
			JSONObject jsonMoudle = new JSONObject();
			BeanUtils.copyProperties(moudlevo, moudle);
			
			if("1".equals(moudle.getIsson())){
				//如果他是一个子模块，先获取他的父级模块的ID  再塞
				moudlevo.setParentId(moudle.getParentMoudle().getId());
			}
			
			jsonMoudle.element("moudle", moudlevo);
			
			PrintWriter out = this.response.getWriter();
			
			out.write(jsonMoudle.toString());
			out.flush();
			out.close();
			return "add";
	
		  
	   }
	

	public String UpdataMoudle() throws Exception {
		
		  String moudleId = this.request.getParameter("hiddenId");
		  System.out.println("进入修改方法的moudleId是"+moudleId);
		     int id = 0;
				if(moudleId!=null && !"".equals(moudleId)){
					id = Integer.parseInt(moudleId);
				   }
				//System.out.println(id);
				Moudle moudle2 = (Moudle)moudleDao.findObjectById(Moudle.class, id);
				
				this.request.setAttribute("moudle", moudle);
				moudle.setId(id);
				moudle.setParentMoudle(moudle2.getParentMoudle());
				moudle.setRoles(moudle2.getRoles());
				moudle.setSonMoudles(moudle2.getSonMoudles());
				moudleDao.updateObject(moudle);
					
		/*String isSon = moudle.getIsson();
		if("1".equals(isSon)){
			String pId = this.request.getParameter("parentId");
			int parentId = 0;
			if(pId!=null && !"".equals(pId)){
				parentId = Integer.parseInt(pId);
			}
			Moudle parentMoudle = (Moudle)moudleDao.findObjectById(Moudle.class, parentId);
			moudle.setParentMoudle(parentMoudle);
		}else{
			Moudle newModule=(Moudle) moudleDao.findObjectById(Moudle.class,moudle.getId());
			Set<Moudle> sonMoudles=newModule.getSonMoudles();
			moudle.setSonMoudles(sonMoudles);
		}
		
		
		moudleDao.updateObject(moudle);*/
		return "updata";
		
		
		
	   }
	
	
	
	public String DelMoudle() throws Exception {
		String moudleId = this.request.getParameter("id");
		int id = 0;
		if(moudleId!=null && !"".equals(moudleId)){
			id = Integer.parseInt(moudleId);
		}
		System.out.println(id);
		
		Moudle moudle = (Moudle)moudleDao.findObjectById(Moudle.class, id);
		if("0".equals(moudle.getIsson())){
			this.request.setAttribute("moudle", moudle);
			}
		boolean f= moudleDao.deleteObject(Moudle.class, id);
		if(f){
			return "del";
		}else{
			return "error";
		}
		
		   
		     
	   }
	
	
	
	
}
