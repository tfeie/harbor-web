package com.the.harbor.web.system.utils;

import com.alibaba.fastjson.JSON;
import com.the.harbor.api.user.param.UserInfo;
import com.the.harbor.commons.components.redis.CacheFactory;
import com.the.harbor.commons.redisdata.def.RedisDataKey;

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
	
	

}
