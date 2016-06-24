package com.the.harbor.test;

import com.alibaba.fastjson.JSONObject;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.web.system.utils.CommonUtil;

public class WXAuth {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String authorURL = GlobalSettings.getWeiXinConnectAuthorizeAPI() + "?appid="
				+ GlobalSettings.getWeiXinAppId()
				+ "&response_type=code&scope=snsapi_userinfo&state=haigui";
		JSONObject jsonObject = CommonUtil.httpsRequest(authorURL, "GET", null);
		System.out.println(jsonObject.toJSONString());

	}

}
