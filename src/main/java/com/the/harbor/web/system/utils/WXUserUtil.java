package com.the.harbor.web.system.utils;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.the.harbor.api.user.IUserSV;
import com.the.harbor.api.user.param.UserInfo;
import com.the.harbor.api.user.param.UserQueryResp;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.commons.components.redis.CacheFactory;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.def.RedisDataKey;
import com.the.harbor.web.util.DubboServiceUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;

public final class WXUserUtil {

	private static final Logger LOG = Logger.getLogger(WXUserUtil.class);

	private WXUserUtil() {

	}

	public static void bindWXOpenIdUserInfo(String openId, UserInfo userInfo) {
		CacheFactory.getClient().hset(RedisDataKey.KEY_WEIXIN_REG_USER.getKey(), openId, JSON.toJSONString(userInfo));
	}

	public static boolean checkWXOpenIdBindUser(String openId) {
		boolean exists = CacheFactory.getClient().hexists(RedisDataKey.KEY_WEIXIN_REG_USER.getKey(), openId);
		return exists;
	}

	public static UserInfo getUserInfo(String openId) {
		UserQueryResp userResp = DubboConsumerFactory.getService(IUserSV.class).queryUserInfoByOpenId(openId);
		return userResp.getUserInfo();
	}

	public static UserInfo getUserInfoByWXAuth(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromReqAttr(request);
		LOG.debug("获取到的微信认证token=" + JSON.toJSONString(wtoken));
		UserInfo userInfo = WXUserUtil.getUserInfo(wtoken.getOpenId());
		System.out.println("获取到的用户信息=" + JSON.toJSONString(userInfo));
		if (userInfo == null) {
			throw new BusinessException("USER-100001", "您的微信没有注册成用户");
		}
		return userInfo;
	}

	public static UserViewInfo getUserViewInfoByWXAuth(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromReqAttr(request);
		LOG.debug("获取到的微信认证token=" + JSON.toJSONString(wtoken));
		UserViewInfo userInfo = DubboServiceUtil.queryUserViewInfo(wtoken.getOpenId());
		System.out.println("获取到的用户信息=" + JSON.toJSONString(userInfo));
		if (userInfo == null) {
			throw new BusinessException("USER-100001", "您的微信没有注册成用户");
		}
		return userInfo;
	}

}
