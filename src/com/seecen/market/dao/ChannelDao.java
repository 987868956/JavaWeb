package com.seecen.market.dao;

import com.seecen.dao.BaseDao;
import com.seecen.market.po.Channel;

public interface ChannelDao extends BaseDao{
	/*
	 * 对状态位的改变
	 * 如果启用 置1 禁用置0
	 * 如果是禁用父渠道,则需要将父渠道下的子渠道全部禁用
	 * 
	 */
	public boolean freezeStatus(Channel channel);
}
