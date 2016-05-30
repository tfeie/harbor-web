package com.the.harbor.web.system.wechatutils.req;
/**
* @ClassName: BaseMessage 
* @Description: 微信请求服务后台的消息基类
* @author lifeng lifeng3@asiainfo.com
* @date 2014年9月3日 下午4:17:27
 */
public class BaseMessage {

		// 开发者微信号
		private String ToUserName;
		// 发送方帐号（一个OpenID）
		private String FromUserName;
		// 消息创建时间 （整型）
		private long CreateTime;
		// 消息类型（text/image/location/link）
		private String MsgType;
		// 消息id，64位整型
		private long MsgId;

		public String getToUserName() {
			return ToUserName;
		}

		public void setToUserName(String toUserName) {
			ToUserName = toUserName;
		}

		public String getFromUserName() {
			return FromUserName;
		}

		public void setFromUserName(String fromUserName) {
			FromUserName = fromUserName;
		}

		public long getCreateTime() {
			return CreateTime;
		}

		public void setCreateTime(long createTime) {
			CreateTime = createTime;
		}

		public String getMsgType() {
			return MsgType;
		}

		public void setMsgType(String msgType) {
			MsgType = msgType;
		}

		public long getMsgId() {
			return MsgId;
		}

		public void setMsgId(long msgId) {
			MsgId = msgId;
		}
}
