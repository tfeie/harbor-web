package com.the.harbor.web.weixin.param;

public class MenuClickRequest {
	//发送方帐号（open_id）
	private String FromUserName;
	//公众帐号
	private String ToUserName;
	//消息类型
	private String MsgType;
	//事件类型
	private String Event;
	//事件key
	private String EventKey;
	//文本内容
	private String Content;
	
	public String getFromUserName() {
		return FromUserName;
	}
	public void setFromUserName(String fromUserName) {
		FromUserName = fromUserName;
	}
	public String getToUserName() {
		return ToUserName;
	}
	public void setToUserName(String toUserName) {
		ToUserName = toUserName;
	}
	public String getMsgType() {
		return MsgType;
	}
	public void setMsgType(String msgType) {
		MsgType = msgType;
	}
	public String getEvent() {
		return Event;
	}
	public void setEvent(String event) {
		Event = event;
	}
	public String getEventKey() {
		return EventKey;
	}
	public void setEventKey(String eventKey) {
		EventKey = eventKey;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}

}
