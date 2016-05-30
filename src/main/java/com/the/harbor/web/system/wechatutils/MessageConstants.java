package com.the.harbor.web.system.wechatutils;

public class MessageConstants {
	/** 微信广告类 菜单前缀*/
	public static final String WX_AD_MENU_PERFIX = "AD_M_";
	
	/**
	 * @ClassName: RequestMsgType
	 * @Description: 请求消息类型
	 * */
	public class RequestMsgType {
		/** 请求消息类型：文本 */
		public static final String REQ_MESSAGE_TYPE_TEXT = "text";

		/** 请求消息类型：图片 */
		public static final String REQ_MESSAGE_TYPE_IMAGE = "image";

		/** 请求消息类型：语音 */
		public static final String REQ_MESSAGE_TYPE_VOICE = "voice";

		/** 请求消息类型：视频 */
		public static final String REQ_MESSAGE_TYPE_VIDEO = "video";

		/** 请求消息类型：小视频 */
		public static final String REQ_MESSAGE_TYPE_SVIDEO = "shortvideo";

		/** 请求消息类型：定位 */
		public static final String REQ_MESSAGE_TYPE_LOCATION = "location";

		/** 请求消息类型：链接 */
		public static final String REQ_MESSAGE_TYPE_LINK = "link";

		/** 请求消息类型：事件推送 */
		public static final String REQ_MESSAGE_TYPE_EVENT = "event";
	}

	/**
	 * @ClassName: ResponceMsgType
	 * @Description: 返回消息类型
	 * */
	public class ResponseMsgType {
		/** 返回消息类型：文本 */
		public static final String RESP_MESSAGE_TYPE_TEXT = "text";

		/** 返回消息类型：图片 */
		public static final String RESP_MESSAGE_TYPE_IMAGE = "image";

		/** 返回消息类型：语音 */
		public static final String RESP_MESSAGE_TYPE_VOICE = "voice";

		/** 返回消息类型：视频 */
		public static final String RESP_MESSAGE_TYPE_VIDEO = "video";

		/** 返回消息类型：音乐 */
		public static final String RESP_MESSAGE_TYPE_MUSIC = "music";

		/** 返回消息类型：图文 */
		public static final String RESP_MESSAGE_TYPE_NEWS = "news";
		
		/**返回消息类型 ：转发至多客服*/
		public static final String RESP_MESSAGE_TYPE_CUSTOMSERVICE = "transfer_customer_service";
	}

	/**
	 * @ClassName: EventType
	 * @Description: 事件类型定义
	 * */
	public class EventType {
		/** 事件类型：subscribe(订阅) */
		public static final String EVENT_TYPE_SUBSCRIBE = "subscribe";

		/** 事件类型：unsubscribe(取消订阅) */
		public static final String EVENT_TYPE_UNSUBSCRIBE = "unsubscribe";

		/** 事件类型：LOCATION(上报地理位置) */
		public static final String EVENT_TYPE_LOCATION = "LOCATION";

		/** 事件类型：CLICK(自定义菜单点击事件) */
		public static final String EVENT_TYPE_CLICK = "CLICK";

		/** 事件类型：VIEW(点击菜单跳转链接事件) */
		public static final String EVENT_TYPE_VIEW = "VIEW";
	}

	/**
	 * @ClassName: EventKey
	 * @Description: 事件KEY值定义
	 * */
	public class EventKey {
		
	}
}
