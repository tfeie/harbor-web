package com.the.harbor.web.weixin.param;

public class MenuClickRequest {
	private String FromUserName;//发送方帐号（open_id）
	private String ToUserName;//公众帐号
	private String MsgType;//消息类型
	private String Event;//事件类型
	private String EventKey;//事件key
	private String Content;//文本内容
	
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
