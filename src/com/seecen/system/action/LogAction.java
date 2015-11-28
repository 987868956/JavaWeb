package com.seecen.system.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.seecen.action.BaseAction;
import com.seecen.student.po.Student;
import com.seecen.system.dao.LogDao;
import com.seecen.system.po.Log;


public class LogAction  extends BaseAction {
	private Log log;
	private LogDao logDao;
	
	

	public void setLogDao(LogDao logDao) {
		this.logDao = logDao;
	}
		
	@Override
	public String execute() throws Exception {
		
		  Map filter=new HashMap();
		  /*
			List<Log> logs =logDao.findAll(Log.class, filter, 1, 999);
			this.request.setAttribute("logs", logs);*/
		    int CurrentPage=1;
			int pageSize=8;
			String currentP=this.request.getParameter("currentPage");
			int totalSize=logDao.findAll(Log.class).size();
			if(currentP!=null){
				CurrentPage=Integer.parseInt(currentP);
				int totalPage=1;
				if(totalSize%pageSize==0){
					totalPage=totalSize/pageSize;
				}else{
					totalPage=totalSize/pageSize+1;
				}
				if(CurrentPage>totalPage){
					CurrentPage=totalPage;
				}
				if(CurrentPage<=0){
					CurrentPage=1;
				}
			}
			
			List<Log> logs=logDao.findAll(Log.class, filter, CurrentPage, pageSize);
			
			
			List<Log> cs=logDao.findAll(Log.class);
			
			this.request.setAttribute("logs", logs);
			
			this.request.setAttribute("currentPage", CurrentPage);
			this.request.setAttribute("count", totalSize);
		
		
		
		return SUCCESS;
	}
	
	

}
