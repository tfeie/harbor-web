package com.the.harbor.web.system.utils;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.the.harbor.api.user.param.UserInfo;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.enumeration.common.BusiErrorCode;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.commons.components.redis.CacheFactory;
import com.the.harbor.commons.redisdata.def.RedisDataKey;
import com.the.harbor.commons.redisdata.util.HyUserUtil;
import com.the.harbor.commons.util.StringUtil;
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
			throw new BusinessException(BusiErrorCode.WECHAT_UNAUTHORIZED.getValue(), "您没有通过微信网页授权认证,请先认证");
		}
		return wxUserInfo;
	}

	public static UserViewInfo getUserViewInfoByWXAuth(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromSession(request);
		if (StringUtil.isBlank(wtoken.getOpenId())) {
			throw new BusinessException("认证失败,请关闭浏览器后重新进入");
		}
		UserViewInfo userInfo = getUserViewInfoByOpenId(wtoken.getOpenId());
		return userInfo;
	}

	public static UserViewInfo checkUserRegAndGetUserViewInfo(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromSession(request);
		UserViewInfo userInfo = getUserViewInfoByOpenId(wtoken.getOpenId());
		if (userInfo == null) {
			throw new BusinessException(BusiErrorCode.USER_UNREGISTER.getValue(), "您的微信还没注册成湾民,请先注册", true,
					"../user/toUserRegister.html");
		}
		return userInfo;
	}

	public static UserViewInfo getUserViewInfoByOpenId(String openId) {
		UserViewInfo userInfo = null;
		String userId = HyUserUtil.getUserIdByOpenId(openId);
		if (StringUtil.isBlank(userId)) {
			// 如果Redis Hash表中没有，则调用服务获取
			userInfo = DubboServiceUtil.queryUserViewByOpenId(openId);
			if (userInfo != null) {
				HyUserUtil.buildOpenIdAndUserIdMapped(openId, userInfo.getUserId());
			}
		} else {
			// 从REDIS中读取用户信息
			String userData = HyUserUtil.getUserInfoFromRedis(userId);
			if (StringUtil.isBlank(userData)) {
				// 如果换成没有用户信息，则查询库
				userInfo = DubboServiceUtil.queryUserViewInfoByUserId(userId);
				if (userInfo == null) {
					HyUserUtil.storeUserInfo2Redis(userId, JSON.toJSONString(userInfo));
				}
			} else {
				userInfo = JSONObject.parseObject(userData, UserViewInfo.class);
			}
		}
		return userInfo;
	}

	public static UserViewInfo getUserViewInfoByUserId(String userId) {
		UserViewInfo userInfo = null;
		// 从REDIS中读取用户信息
		String userData = HyUserUtil.getUserInfoFromRedis(userId);
		if (StringUtil.isBlank(userData)) {
			// 如果换成没有用户信息，则查询库
			userInfo = DubboServiceUtil.queryUserViewInfoByUserId(userId);
			if (userInfo == null) {
				HyUserUtil.storeUserInfo2Redis(userId, JSON.toJSONString(userInfo));
			}
		} else {
			userInfo = JSONObject.parseObject(userData, UserViewInfo.class);
		}
		return userInfo;
	}

}
