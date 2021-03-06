package com.the.harbor.web.constants;

public class WXConstants {
	// 与接口配置信息中的Token要一致
	public static String token = "harbor";

	public static class WEIXIN_TRADE_TYPE {
		// 交易类型： JSAPI,NATIVE,APP
		public static final String NATIVE = "NATIVE";
		public static final String JSAPI = "JSAPI";
		public static final String APP = "APP";
	}

	// 本地网页授权后获取的信息,存储在本地session中
	public static final String SESSION_WX_WEB_AUTH = "_WeixinOauth2Token_"; 
	
	// WEB登录后的SESSION
	public static final String SESSION_WEB_LOGIN = "_WEB_LOGIN_SESSION_"; 
	
	//WEB登录成功后的跳转页面
	public static final String SESSION_WEB_REDIRECTURL = "_WEB_LOGIN_REDIRECTURL_"; 
	
}
