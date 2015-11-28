package com.seecen.market.dao.impl;

import java.util.HashSet;
import java.util.Set;

import com.seecen.dao.impl.BaseDaoImpl;
import com.seecen.market.dao.ChannelDao;
import com.seecen.market.po.Channel;

public class ChannelDaoImpl extends BaseDaoImpl implements ChannelDao{

	public boolean freezeStatus(Channel channel) {
		try {
			//该渠道为父渠道,将子渠道的状态改为0
			if(channel.getParentChannel()==null){
				System.out.println("该渠道为父渠道");
				Set<Channel> sonChannels = new HashSet<Channel>();
	 			sonChannels = channel.getSonChannel();
	 			Object[] objs  = sonChannels.toArray();
	 			for(int i=0;i<objs.length;i++){
	 				Channel chan = new Channel();
	 				chan=(Channel)objs[i];
	 				chan.setStatus("0");
	 				super.updateObject(chan);
	 			}
	 			//将父渠道的状态改为0
	 			channel.setStatus("0");
	 			super.updateObject(channel);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
		
		
	}
	
}
