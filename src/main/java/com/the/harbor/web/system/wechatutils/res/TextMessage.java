package com.the.harbor.web.system.wechatutils.res;

import java.util.Date;

import com.the.harbor.web.system.wechatutils.MessageUtil;

public class TextMessage extends BaseMessage {

	public TextMessage(String fromUserName, String toUserName)
	{
		this.setFromUserName(fromUserName);
		this.setToUserName(toUserName);
		this.setCreateTime(new Date().getTime());
		this.setMsgType(MessageUtil.ResponseMsgType.RESP_MESSAGE_TYPE_TEXT);
	}
	public TextMessage()
	{
	}
	// 回复的消息内容
	private String Content;

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}
}
