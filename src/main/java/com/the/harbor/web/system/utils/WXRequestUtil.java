package com.the.harbor.web.system.utils;

import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.the.harbor.web.system.utils.MathUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;
import com.the.harbor.web.weixin.param.WeixinUserInfo;
import com.alibaba.fastjson.JSONObject;
import com.the.harbor.web.constants.WXConstants;

public class WXRequestUtil {
	private static Log log = LogFactory.getLog(WXRequestUtil.class);
	
	/**
	 * 获取预支付流水
	 * @param openId
	 * @param notifyUrl
	 * @param request
	 * @return {"STATE":"OK","MSG":""}或者{"STATE":"FAILD","MSG":""}
	 */
	public static JSONObject wxUnifiedorder(String openId,String notifyUrl,HttpServletRequest request) {
		String orderId = request.getParameter("orderId");
		String fee  = request.getParameter("orderAmount");
		String appsecret = "Tgbnhy21qwerty39jjygbnh77ijnbvcx";
		String url = "https://api.mch.weixin.qq.com/pay/unifiedorder";
        SortedMap<String, String> map = new TreeMap<String, String>();
        map.put("appid", "wxbec41326662016d1");
        map.put("mch_id", "1333852501");
        map.put("device_info", "WEB");
        map.put("nonce_str", StringUtil.getRandomNumStr());
        map.put("body", "海归海湾微信支付");
        map.put("out_trade_no", orderId);
        map.put("total_fee", MathUtil.changeYuanToFen(Double.parseDouble(fee)) + "");
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
	 * @param code
	 * @return
	 */
	public static WeixinOauth2Token refreshAccessToken(String code) {
		WeixinOauth2Token wtoken = null;
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
                + "appid="
                + "wxbec41326662016d1"
                + "&secret="
                + "276c6d27f07239411cd9ba93a40aac4c"
                + "&code="
                + code 
                + "&grant_type=authorization_code";
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
	 * @param accessToken
	 * @param openId
	 * @return
	 */
	public static WeixinUserInfo getWxUserInfo(String accessToken,String openId) {
		WeixinUserInfo userInfo = null;
		String url = "https://api.weixin.qq.com/sns/userinfo?"
                + "access_token="
                + accessToken
                + "&openid="
                + openId
                + "&lang=zh_CN";
		JSONObject jsonObject = CommonUtil.httpsRequest(url, "GET", null);
		if (null != jsonObject) {
            log.info("获取网页授权用户信息:" + jsonObject.toString());
            try {
        		userInfo = (WeixinUserInfo) JSONObject.toJavaObject(jsonObject, WeixinUserInfo.class);
            	
            } catch(Exception e) {
            	userInfo = null;
            	String errorCode = jsonObject.getString("errcode");
                String errorMsg = jsonObject.getString("errmsg");
                log.error("获取微信用户信息失败： errcode:{" + errorCode + "},errmsg:{" + errorMsg + "}");
            }
			
		}
		return userInfo;
	}

}
