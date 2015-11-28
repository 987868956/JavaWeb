package com.seecen.market.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;

import com.opensymphony.xwork2.ModelDriven;
import com.seecen.action.BaseAction;
import com.seecen.market.dao.ChannelDao;
import com.seecen.market.po.Channel;
import com.seecen.market.po.Customer;
import com.seecen.market.vo.ChannelVo;

public class ChannelAction extends BaseAction implements ModelDriven<Channel> {
	private Channel channel;
	private ChannelDao channelDao;
	
	public void setChannelDao(ChannelDao channelDao) {
		this.channelDao = channelDao;
	}

	@Override
	public String execute() throws Exception {
		
		System.out.println("******************88");
		List channels = new ArrayList();
		Map filter = new HashMap();
		String name = this.request.getParameter("CName");
		String address = this.request.getParameter("CAddress");
		if(name!=null){
			filter.put("cname", name.trim());
		}
		if(address!=null){
			filter.put("caddress", address.trim());
		}
		String currentPage = this.request.getParameter("currentPage");
		int current = 0;
		if(currentPage!=null){
			current = Integer.parseInt(currentPage);
			if(current==0){
				current = 1;
			}
			System.out.println(current);
		}else{
			current = 1;
		}
		Map filte2 = new HashMap();
		filte2.put("status", "1");
		int size = channelDao.findAll(Channel.class,filte2).size();
		int totalPage=0;
		if(size % 5==0){
			totalPage = (size / 5) ;
		}else{
			totalPage = (size / 5) + 1;
		}
		
		//查找状态合法的父模块
		Map filter2 = new HashMap();
		filter2.put("status", "1");
		//filter2.put("parentChannel", null);
		List parentChannels = channelDao.findAll(Channel.class,filter2);
		this.request.setAttribute("parentChannels", parentChannels);
		//模糊分页查询
		channels = channelDao.findAll(Channel.class, filter, current, 5);
		System.out.println(channels.size());
		for (Object c : channels) {
			Channel cent = new Channel();
			cent = (Channel) c;
			System.out.println(cent);
		}
		
		this.request.setAttribute("totalPage", totalPage);
		this.request.setAttribute("currentPage", current);
		this.request.setAttribute("size", size);
		this.request.setAttribute("channels", channels);
		System.out.println("************");
		return SUCCESS;
	}

	public String getByID() throws Exception {
		System.out.println("hello");
		System.out.println("通过ID查找对象");
		String cid = this.request.getParameter("chID");
		int id = Integer.parseInt(cid);
		System.out.println(id);
		Channel cen = (Channel) channelDao.findObjectById(Channel.class, id);
		System.out.println(cen);
		ChannelVo vo = new ChannelVo();
		BeanUtils.copyProperties(vo, cen);
		System.out.println(vo);
		JSONObject obj = new JSONObject();
		System.out.println(cen.getId());
		if(cen.getParentChannel()==null){
		
		}else{
			vo.setParentChannel(cen.getParentChannel().getId());
			vo.setParentName(cen.getParentChannel().getName());
		}
		
		obj.element("chan", vo);
		PrintWriter out = this.response.getWriter();
		out.write(obj.toString());
		System.out.println(obj.toString());
		out.flush();
		return null;
		
	}

	public String add() throws Exception {
		String pChannel = this.request.getParameter("parentID");
		int parId = Integer.parseInt(pChannel);
		Channel chan = (Channel) channelDao.findObjectById(Channel.class, parId);
		channel.setParentChannel(chan);
		boolean flag = channelDao.addObject(channel);
		if(flag){
			return "listAll";
		}else{
			return "error";
		}
				
	}
	public String update() throws Exception {
		System.out.println(channel);
		String pChannel = this.request.getParameter("parentID");
		System.out.println(pChannel);
		int parId = Integer.parseInt(pChannel);
		Channel chan = (Channel) channelDao.findObjectById(Channel.class, parId);
		channel.setParentChannel(chan);
		channelDao.updateObject(channel);
		return "listAll";

	}

	public String delete() throws Exception {
		String id = request.getParameter("chId");
		int cid = Integer.parseInt(id);
		channelDao.deleteObject(Channel.class, cid);
		return "listAll";
	}
	


	public Channel getModel() {
		channel = new Channel();
		return channel;
	}

}
