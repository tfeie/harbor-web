package com.the.harbor.web.util;

import com.the.harbor.api.go.IGoSV;
import com.the.harbor.api.go.param.Go;
import com.the.harbor.api.go.param.GoOrder;
import com.the.harbor.api.go.param.GoOrderQueryReq;
import com.the.harbor.api.go.param.GoOrderQueryResp;
import com.the.harbor.api.go.param.GoQueryReq;
import com.the.harbor.api.go.param.GoQueryResp;
import com.the.harbor.api.user.IUserSV;
import com.the.harbor.api.user.param.UserInfo;
import com.the.harbor.api.user.param.UserQueryResp;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.api.user.param.UserViewResp;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.exception.GenericException;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.util.ExceptionUtil;

public final class DubboServiceUtil {

	/**
	 * 查询活动信息
	 * 
	 * @param goId
	 * @return
	 */
	public static Go queryGo(String goId) {
		GoQueryReq goQueryReq = new GoQueryReq();
		goQueryReq.setGoId(goId);
		GoQueryResp resp = null;
		try {
			resp = DubboConsumerFactory.getService(IGoSV.class).queryGo(goQueryReq);
		} catch (Exception ex) {
			GenericException ge = ExceptionUtil.convert2GenericException(ex);
			throw ge;
		}

		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultMessage());
		}
		return resp.getGo();
	}

	public static GoOrder queryGoOrder(String userId, String goId) {
		GoOrderQueryReq goOrderQueryReq = new GoOrderQueryReq();
		goOrderQueryReq.setGoId(goId);
		goOrderQueryReq.setUserId(userId);
		GoOrderQueryResp resp = null;
		try {
			resp = DubboConsumerFactory.getService(IGoSV.class).queryUserOrderGo(goOrderQueryReq);
		} catch (Exception ex) {
			GenericException ge = ExceptionUtil.convert2GenericException(ex);
			throw ge;
		}
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultMessage());
		}
		return resp.getGoOrder();
	}

	public static GoOrder queryGoOrder(String goOrderId) {
		GoOrderQueryReq goOrderQueryReq = new GoOrderQueryReq();
		goOrderQueryReq.setGoOrderId(goOrderId);
		GoOrderQueryResp resp = null;
		try {
			resp = DubboConsumerFactory.getService(IGoSV.class).queryGoOrder(goOrderQueryReq);
		} catch (Exception ex) {
			GenericException ge = ExceptionUtil.convert2GenericException(ex);
			throw ge;
		}

		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultMessage());
		}
		return resp.getGoOrder();
	}

	public static UserViewInfo queryUserViewByOpenId(String openId) {
		UserViewResp resp = null;
		try {
			resp = DubboConsumerFactory.getService(IUserSV.class).queryUserViewByOpenId(openId);
		} catch (Exception ex) {
			GenericException ge = ExceptionUtil.convert2GenericException(ex);
			throw ge;
		}
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultMessage());
		}
		return resp.getUserInfo();
	}

	public static UserViewInfo queryUserViewInfoByUserId(String userId) {
		UserViewResp resp = null;
		try {
			resp = DubboConsumerFactory.getService(IUserSV.class).queryUserViewByUserId(userId);
		} catch (Exception ex) {
			GenericException ge = ExceptionUtil.convert2GenericException(ex);
			throw ge;
		}
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultMessage());
		}
		return resp.getUserInfo();
	}
	
	public static UserInfo getUserInfoByOpenId(String openId) {
		UserQueryResp resp = DubboConsumerFactory.getService(IUserSV.class).queryUserInfoByOpenId(openId);
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultMessage());
		}
		return resp.getUserInfo();
	}
	
	public static UserInfo getUserInfoByUserId(String userId) {
		UserQueryResp resp = DubboConsumerFactory.getService(IUserSV.class).queryUserInfoByUserId(userId);
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultMessage());
		}
		return resp.getUserInfo();
	}

}
