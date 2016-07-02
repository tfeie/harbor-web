package com.the.harbor.web.system.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.enumeration.hynotify.AccepterType;
import com.the.harbor.base.enumeration.hynotify.SenderType;
import com.the.harbor.commons.redisdata.def.DoNotify;
import com.the.harbor.commons.redisdata.def.HyNotifyVo;
import com.the.harbor.commons.redisdata.util.HyNotifyUtil;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.system.utils.NotifyMQSend;
import com.the.harbor.web.system.utils.WXUserUtil;

@RestController
@RequestMapping("/notify")
public class SysNotifyController {

	private static final Logger LOG = Logger.getLogger(SysNotifyController.class);

	@RequestMapping("/getUserMessage")
	@ResponseBody
	public ResponseData<List<HyNotifyVo>> getUserMessage(HttpServletRequest request) {

		ResponseData<List<HyNotifyVo>> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Set<String> notifyIds = HyNotifyUtil.getUserNotifyIds(userInfo.getUserId(), 0, -1);
			List<HyNotifyVo> notifies = new ArrayList<HyNotifyVo>();
			for (String notifyId : notifyIds) {
				HyNotifyVo nofity = HyNotifyUtil.getNotify(notifyId);
				this.fillNotifyVo(nofity);
				notifies.add(nofity);
			}
			responseData = new ResponseData<List<HyNotifyVo>>(ResponseData.AJAX_STATUS_SUCCESS, "获取成功成功", notifies);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyNotifyVo>>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/deleteUserMessage")
	@ResponseBody
	public ResponseData<String> deleteUserMessage(@NotBlank(message = "参数为空") String notifyId,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			// 组织一条消息，用户要删除此消息
			DoNotify body = new DoNotify();
			body.setNotifyId(notifyId);
			body.setHandleType(DoNotify.HandleType.CANCEL.name());
			body.setAccepterType(AccepterType.USER.getValue());
			body.setAccepterId(userInfo.getUserId());
			NotifyMQSend.sendNotifyMQ(body);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "消息删除成功", "");
		} catch (Exception e) {
			LOG.error(e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	private void fillNotifyVo(HyNotifyVo vo) {
		vo.setHaslink(!StringUtil.isBlank(vo.getLink()));
		vo.setCreateDate(DateUtil.getSysDate());
		vo.setTimeInterval(DateUtil.getInterval(vo.getCreateDate()));
		if (SenderType.USER.getValue().equals(vo.getSenderType())) {
			if (!StringUtil.isBlank(vo.getSenderId())) {
				UserViewInfo userInfo = WXUserUtil.getUserViewInfoByUserId(vo.getSenderId());
				if (userInfo != null) {
					vo.setUserStatusName(userInfo.getUserStatusName());
					vo.setWxHeadimg(userInfo.getWxHeadimg());
					vo.setEnName(userInfo.getEnName());
					vo.setAbroadCountryName(userInfo.getAbroadCountryName());
					vo.setUserTitle(userInfo.getTitle());
				}

			}
		}

	}

}
