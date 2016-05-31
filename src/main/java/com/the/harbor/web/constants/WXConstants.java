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
}
