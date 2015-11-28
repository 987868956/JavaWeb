package com.seecen.student.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.student.dao.ReviewDao;
import com.seecen.student.po.Consult;
import com.seecen.student.po.Interview;
import com.seecen.student.po.Review;
import com.seecen.student.po.Student;
import com.seecen.system.po.User;

public class ReviewAction extends BaseAction implements ModelDriven<Review> {
	private Review review;
	private ReviewDao reviewDao;

	public void setReviewDao(ReviewDao reviewDao) {
		this.reviewDao = reviewDao;
	}
	
	@Override
	public String execute() throws Exception {
		Map filter = new HashMap();
		
		int CurrentPage=1;
		int pageSize=5;
		
		String currentP=this.request.getParameter("currentPage");
		if(currentP!=null){
			CurrentPage=Integer.parseInt(currentP);
		}
		int totalSize=reviewDao.findAll(Interview.class).size();
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
		
		
		List<Review> rs = reviewDao.findAll(Review.class, filter, CurrentPage, pageSize);
		this.request.setAttribute("reviews", rs);
		
		List<Student> ss=reviewDao.findAll(Student.class, filter, 1, 998);
		this.request.setAttribute("ss",ss);
		List<User> us=reviewDao.findAll(User.class, filter, 1, 998);
		this.request.setAttribute("us", us);
		
		this.request.setAttribute("currentPage", CurrentPage);
		this.request.setAttribute("count", totalSize);
		
		return "list";
	}

	public String add() throws Exception {
		String stuid=this.request.getParameter("student");
		String userid=this.request.getParameter("user");
		int sid=2;
		int uid=1;
		if(stuid!=null && userid!=null){
			sid=Integer.parseInt(stuid);
			uid=Integer.parseInt(userid);
		}
		Student s=(Student) reviewDao.findObjectById(Student.class, sid);
		User u=(User) reviewDao.findObjectById(User.class, uid);
		review.setSid(s);
		review.setUserId(u);
		boolean f=reviewDao.addObject(review);
		if(f){
			return "listAll";
		}else{
			return ERROR;
		}
	}

	public String update() throws Exception {
		String id=this.request.getParameter("cid");
		System.out.println(id);
		int cid=1;
		if(id!=null){
			cid=Integer.parseInt(id);
		}
		review.setId(cid);
		String stuid=this.request.getParameter("student");
		String userid=this.request.getParameter("user");
		int sid=1;
		int uid=1;
		if(stuid!=null && userid!=null){
			sid=Integer.parseInt(stuid);
			uid=Integer.parseInt(userid);
		}
		Student s=(Student) reviewDao.findObjectById(Student.class, sid);
		User u=(User) reviewDao.findObjectById(User.class, uid);
		review.setSid(s);
		review.setUserId(u);
		boolean f=reviewDao.updateObject(review);
		if(f){
			return "listAll";
		}else{
			return ERROR;
		}
	}

	public String delete() throws Exception {
		String id=this.request.getParameter("id");
		int cid=1;
		if(id!=null){
			cid=Integer.parseInt(id);
		}
		boolean f=reviewDao.deleteObject(Review.class, cid);
		if(f){
			return "delete";
		}else{
			return ERROR;
		}
	}
	
	public String findById() throws Exception {
		String id=this.request.getParameter("id");
		int rid=1;
		if(id!=null){
			rid=Integer.parseInt(id);
		}
		Review r=(Review) reviewDao.findObjectById(Review.class, rid);
		
		JSONObject jobj=new JSONObject();
		jobj.element("rid", r.getId());
		jobj.element("sid", r.getSid().getId());
		jobj.element("name", r.getProjectName());
		jobj.element("time", r.getCreateDate().toString());
		jobj.element("phase", r.getProjectPhase());
		jobj.element("suit", r.getSuitEtiquetteScore());
		jobj.element("explain", r.getExplainScore());
		jobj.element("reply", r.getReplyScore());
		jobj.element("uid", r.getUserId().getId());

		PrintWriter out=response.getWriter();
		out.write(jobj.toString());
		out.flush();
		out.close();
		
		return INPUT;
	}

	public Review getModel() {
		review = new Review();
		return review;
	}

}
