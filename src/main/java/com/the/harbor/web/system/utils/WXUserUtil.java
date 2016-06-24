package com.the.harbor.web.system.utils;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.the.harbor.api.user.param.UserInfo;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.commons.components.redis.CacheFactory;
import com.the.harbor.commons.redisdata.def.RedisDataKey;
import com.the.harbor.web.util.DubboServiceUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;
import com.the.harbor.web.weixin.param.WeixinUserInfo;

public final class WXUserUtil {

	private WXUserUtil() {

	}

	public static void bindWXOpenIdUserInfo(String openId, UserInfo userInfo) {
		CacheFactory.getClient().hset(RedisDataKey.KEY_WEIXIN_REG_USER.getKey(), openId, JSON.toJSONString(userInfo));
	}

	public static boolean checkWXOpenIdBindUser(String openId) {
		boolean exists = CacheFactory.getClient().hexists(RedisDataKey.KEY_WEIXIN_REG_USER.getKey(), openId);
		return exists;
	}

	public static WeixinUserInfo getWeixinUserInfo(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromSession(request);
		WeixinUserInfo wxUserInfo = WXRequestUtil.getWxUserInfo(wtoken.getAccessToken(), wtoken.getOpenId());
		if (wxUserInfo == null) {
			throw new BusinessException("您没有通过微信网页授权认证,请先认证");
		}
		return wxUserInfo;
	}

	public static UserInfo getUserInfo(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromSession(request);
		UserInfo userInfo = DubboServiceUtil.getUserInfoByOpenId(wtoken.getOpenId());
		return userInfo;
	}

	public static UserInfo checkUserRegAndGetUserInfo(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromSession(request);
		UserInfo userInfo = DubboServiceUtil.getUserInfoByOpenId(wtoken.getOpenId());
		if (userInfo == null) {
			throw new BusinessException("您的微信还没注册成湾民,请先注册", true, "../user/toUserRegister.html");
		}
		return userInfo;
	}

	public static UserViewInfo checkUserRegAndGetUserViewInfo(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromSession(request);
		UserViewInfo userInfo = DubboServiceUtil.queryUserViewByOpenId(wtoken.getOpenId());
		if (userInfo == null) {
			throw new BusinessException("您的微信还没注册成湾民,请先注册", true, "../user/toUserRegister.html");
		}
		return userInfo;
	}

	public static UserViewInfo checkUserRegAndGetUserViewInfo1(HttpServletRequest request) {
		UserViewInfo userInfo = DubboServiceUtil.queryUserViewByOpenId("oztCUs_Ci25lT7IEMeDLtbK6nr1M");
		if (userInfo == null) {
			throw new BusinessException("您的微信还没注册成湾民,请先注册", true, "../user/toUserRegister.html");
		}
		return userInfo;
	}

}
