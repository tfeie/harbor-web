package com.the.harbor.web.system.utils;

import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSONObject;
import com.the.harbor.base.exception.SystemException;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.util.AmountUtils;
import com.the.harbor.commons.util.RandomUtil;
import com.the.harbor.web.constants.WXConstants;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;
import com.the.harbor.web.weixin.param.WeixinUserInfo;

public class WXRequestUtil {
	private static Log log = LogFactory.getLog(WXRequestUtil.class);

	/**
	 * 得到的地址为http://harbor.tfeie.com/user/xx.html?p1=1&... 不包含harbor-app名称
	 * 
	 * @param request
	 * @return
	 */
	public static String getFullURL(HttpServletRequest request) {
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String actionURL = uri.substring(contextPath.length());
		String domainURL = GlobalSettings.getHarborDomain() + actionURL;
		StringBuffer url = new StringBuffer(domainURL);
		if (request.getQueryString() != null) {
			url.append("?");
			url.append(request.getQueryString());
		}
		return url.toString();
	}

	public static WeixinOauth2Token getWeixinOauth2TokenFromReqAttr(HttpServletRequest request) {
		Object o = request.getAttribute(WXConstants.WX_WEB_AUTH);
		if (o == null) {
			throw new SystemException("获取不到网页授权token");
		}
		WeixinOauth2Token wtoken = (WeixinOauth2Token) o;
		return wtoken;
	}

	/**
	 * 统一下单处理
	 * 
	 * @param openId
	 * @param notifyUrl
	 * @param request
	 * @return {"STATE":"OK","MSG":""}或者{"STATE":"FAILD","MSG":""}
	 */
	public static JSONObject wxUnifiedorder(String openId, String notifyUrl, HttpServletRequest request) {
		String orderId = request.getParameter("orderId");
		String fee = request.getParameter("orderAmount");
		String appsecret = GlobalSettings.getWeiXinAppSecret();
		String url = GlobalSettings.getWeiXinMCHPayUnifiedorderAPI();
		SortedMap<String, String> map = new TreeMap<String, String>();
		map.put("appid", GlobalSettings.getWeiXinAppId());
		map.put("mch_id", GlobalSettings.getWeiXinMerchantId());
		map.put("device_info", "WEB");
		map.put("nonce_str", RandomUtil.generateString(32));
		map.put("body", GlobalSettings.getWeiXinMerchantName() + "微信支付");
		map.put("out_trade_no", orderId);
		map.put("total_fee", AmountUtils.changeY2F(fee));
		map.put("fee_type", "CNY");
		map.put("spbill_create_ip", request.getRemoteAddr());
		map.put("trade_type", WXConstants.WEIXIN_TRADE_TYPE.JSAPI);
		map.put("openid", openId);
		map.put("notify_url", notifyUrl);

		String sign = CommonUtil.createSign(map, appsecret);
		map.put("sign", sign);

		try {
			String xml = CommonUtil.getRequestXml(map);
			JSONObject json = CommonUtil.getPayNo2(url, xml);
			log.info("获取预支付流水输出参数：" + json.toJSONString());
			return json;
		} catch (Exception e1) {
			log.error("获取预支付流水:" + e1);
		}
		return new JSONObject();
	}

	/**
	 * 获取AccessToken
	 * 
	 * @param code
	 * @return
	 */
	public static WeixinOauth2Token refreshAccessToken(String code) {
		WeixinOauth2Token wtoken = null;
		String url = GlobalSettings.getWeiXinSNSAuthAccessTokenAPI() + "?appid=" + GlobalSettings.getWeiXinAppId()
				+ "&secret=" + GlobalSettings.getWeiXinAppSecret() + "&code=" + code + "&grant_type=authorization_code";
		JSONObject jsonObject = CommonUtil.httpsRequest(url, "GET", null);
		if (null != jsonObject) {
			log.info("获取网页授权凭证:" + jsonObject.toString());
			try {
				wtoken = new WeixinOauth2Token();
				wtoken.setAccessToken(jsonObject.getString("access_token"));
				wtoken.setExpiresIn(jsonObject.getIntValue("expires_in"));
				wtoken.setRefreshToken(jsonObject.getString("refresh_token"));
				wtoken.setOpenId(jsonObject.getString("openid"));
				wtoken.setScope(jsonObject.getString("scope"));
			} catch (Exception e) {
				log.error("获取网页授权凭证失败", e);
				wtoken = null;
				int errorCode = jsonObject.getIntValue("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("获取网页授权凭证失败 errcode:{" + errorCode + "},errmsg:{" + errorMsg + "}");
			}
		}
		return wtoken;
	}

	/**
	 * 获取用户信息
	 * 
	 * @param accessToken
	 * @param openId
	 * @return
	 */
	public static WeixinUserInfo getWxUserInfo(String accessToken, String openId) {
		WeixinUserInfo userInfo = null;
		String url = GlobalSettings.getWeiXinSNSUserInfoAPI() + "?access_token=" + accessToken + "&openid=" + openId
				+ "&lang=zh_CN";
		JSONObject jsonObject = CommonUtil.httpsRequest(url, "GET", null);
		if (null != jsonObject) {
			log.info("获取网页授权用户信息:" + jsonObject.toString());
			try {
				userInfo = (WeixinUserInfo) JSONObject.toJavaObject(jsonObject, WeixinUserInfo.class);

			} catch (Exception e) {
				userInfo = null;
				String errorCode = jsonObject.getString("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				log.error("获取微信用户信息失败： errcode:{" + errorCode + "},errmsg:{" + errorMsg + "}");
			}

		}
		return userInfo;
	}

}
