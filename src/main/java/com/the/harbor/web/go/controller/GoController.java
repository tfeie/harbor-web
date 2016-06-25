package com.the.harbor.web.go.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotNull;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.the.harbor.api.go.IGoSV;
import com.the.harbor.api.go.param.CreateGoPaymentOrderReq;
import com.the.harbor.api.go.param.CreateGoPaymentOrderResp;
import com.the.harbor.api.go.param.Go;
import com.the.harbor.api.go.param.GoCreateReq;
import com.the.harbor.api.go.param.GoCreateResp;
import com.the.harbor.api.go.param.GoOrder;
import com.the.harbor.api.go.param.GoOrderConfirmReq;
import com.the.harbor.api.go.param.GoOrderCreateReq;
import com.the.harbor.api.go.param.GoOrderCreateResp;
import com.the.harbor.api.go.param.QueryMyGoReq;
import com.the.harbor.api.go.param.QueryMyGoResp;
import com.the.harbor.api.go.param.UpdateGoOrderPayReq;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.enumeration.dict.ParamCode;
import com.the.harbor.base.enumeration.dict.TypeCode;
import com.the.harbor.base.enumeration.hygoorder.OrderStatus;
import com.the.harbor.base.enumeration.hypaymentorder.BusiType;
import com.the.harbor.base.enumeration.hypaymentorder.PayType;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.vo.PageInfo;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyDictUtil;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
import com.the.harbor.commons.util.AmountUtils;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.system.utils.WXUserUtil;
import com.the.harbor.web.util.DubboServiceUtil;

@RestController
@RequestMapping("/go")
public class GoController {

	private static final Logger LOG = Logger.getLogger(GoController.class);

	@RequestMapping("/mygroup.html")
	public ModelAndView mygroup(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		ModelAndView view = new ModelAndView("go/mygroup");
		return view;
	}

	@RequestMapping("/myono.html")
	public ModelAndView myono(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		ModelAndView view = new ModelAndView("go/myono");
		return view;
	}

	/**
	 * OneOnOne活动参与者确认页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toConfirm.html")
	public ModelAndView toConfirm(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("不能查看确认信息:缺少预约单信息");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("不能查看确认信息,该预约单不存在。您可以前往预约", true, "../go/oneononeindex.html");
		}
		if (!userInfo.getUserId().equals(goOrder.getUserId())) {
			throw new BusinessException("不能查看确认信息,预约单不是您发起的。请可以前往预约", true,
					"../go/toOrder.html?goId=" + goOrder.getGoId());
		}
		// 活动发起者用户
		UserViewInfo publishUserInfo = WXUserUtil.getUserViewInfoByUserId(goOrder.getPublishUserId());
		if (publishUserInfo == null) {
			throw new BusinessException("不能查看确认信息:活动发起者信息不存在");
		}
		String tips = "";
		if (OrderStatus.WAIT_CONFIRM.getValue().equals(goOrder.getOrderStatus())) {
			tips = DateUtil.getDateString(goOrder.getCreateDate(), "yyyy-MM-dd HH:mm") + " 预约已提交，请等待海牛确认";
		} else if (OrderStatus.REJECT.getValue().equals(goOrder.getOrderStatus())) {
			tips = DateUtil.getDateString(goOrder.getStsDate(), "yyyy-MM-dd HH:mm") + " 海牛拒绝了您的预约,您支付的费用将在3个工作日内退款";
		} else if (OrderStatus.WAIT_MEET.getValue().equals(goOrder.getOrderStatus())) {
			tips = DateUtil.getDateString(goOrder.getStsDate(), "yyyy-MM-dd HH:mm")
					+ " 海牛已经确认，等待约见。<a href=\"../go/toAppointment.html?goOrderId=" + goOrderId
					+ "\" style=\"color:red\">进入约见</a>";
		} else if (OrderStatus.FINISH.getValue().equals(goOrder.getOrderStatus())) {
			tips = DateUtil.getDateString(goOrder.getStsDate(), "yyyy-MM-dd HH:mm")
					+ " 活动已经结束。<a href=\"../go/toFeedback.html?goOrderId=" + goOrderId
					+ "\" style=\"color:red\">进入点评</a>";
		}
		request.setAttribute("tips", tips);
		request.setAttribute("userInfo", publishUserInfo);
		request.setAttribute("goOrder", goOrder);
		ModelAndView view = new ModelAndView("go/confirm");
		return view;
	}

	/**
	 * OneOnOne活动发起者确认页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toHainiuConfirm.html")
	public ModelAndView toHainiuConfirm(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("不能确认活动预约信息:缺少预约单信息");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("不能确认活动预约信息:该预约单不存在。");
		}
		if (!userInfo.getUserId().equals(goOrder.getPublishUserId())) {
			throw new BusinessException("不能确认活动预约信息:您不是该活动的发起方");
		}
		// 活动参与方
		UserViewInfo joinUserInfo = WXUserUtil.getUserViewInfoByUserId(goOrder.getUserId());
		if (joinUserInfo == null) {
			throw new BusinessException("不能确认活动预约信息:活动预约方信息不存在");
		}
		// 如果不是待海牛确认的，则跳转到对应页面
		if (!OrderStatus.WAIT_CONFIRM.getValue().equals(goOrder.getOrderStatus())) {
			String statusName = HyDictUtil.getHyDictDesc(TypeCode.HY_GO_ORDER.getValue(),
					ParamCode.ORDER_STATUS.getValue(), goOrder.getOrderStatus());
			// 如果状态是待约见，提示跳转到约见
			if (OrderStatus.WAIT_MEET.getValue().equals(goOrder.getOrderStatus())) {
				throw new BusinessException("您已经确认。可以进一步设定约见地点", true,
						"../go/toHainiuAppointment.html?goOrderId=" + goOrderId + "");
			} else if (OrderStatus.FINISH.getValue().equals(goOrder.getOrderStatus())) {
				// 如果是完成，则进入评价
				throw new BusinessException("您已经确认。活动已经结束。您可以进行点评", true,
						"../go/toFeedback.html?goOrderId=" + goOrderId + "");
			} else {
				throw new BusinessException("不能确认活动预约信息:预约单的状态为[" + statusName + "]");
			}

		}
		String tips = DateUtil.getDateString(goOrder.getCreateDate(), "yyyy-MM-dd HH:mm") + " 预约已提交，等待您的确认";
		request.setAttribute("tips", tips);
		request.setAttribute("userInfo", joinUserInfo);
		request.setAttribute("goOrder", goOrder);
		request.setAttribute("publishUserId", userInfo.getUserId());
		ModelAndView view = new ModelAndView("go/hainiuconfirm");
		return view;
	}

	@RequestMapping("/toOrder.html")
	public ModelAndView toOrder(HttpServletRequest request) {
		String goId = request.getParameter("goId");
		if (StringUtil.isBlank(goId)) {
			throw new BusinessException("请先选择活动后才可以预约", true, "../go/oneononeindex.html");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 查询活动信息
		Go go = DubboServiceUtil.queryGo(goId);
		if (go == null) {
			throw new BusinessException("活动不存在，请重新选择", true, "../go/oneononeindex.html");
		}
		if (userInfo.getUserId().equals(go.getUserId())) {
			throw new BusinessException("此活动是您自己发布，不可预约，请重新选择", true, "../go/oneononeindex.html");
		}
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(userInfo.getUserId(), goId);
		if (goOrder != null) {
			String goOrderId = goOrder.getOrderId();
			String orderStatus = goOrder.getOrderStatus();
			Map<String, String> m = this.getJumpURLAndMessageForJoiner(orderStatus, goOrder.getGoId(), goOrderId);
			String jumpURL = m.get("jumpURL");
			String message = m.get("message");
			throw new BusinessException("您已经预约了此活动," + message, true, jumpURL);
		}
		request.setAttribute("goId", goId);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("go/order");
		return view;
	}

	private Map<String, String> getJumpURLAndMessageForJoiner(String orderStatus, String goId, String goOrderId) {
		Map<String, String> m = new HashMap<String, String>();
		String jumpURL = null;
		String message = null;
		if (OrderStatus.PAY_FAILURE.getValue().equals(orderStatus)
				|| OrderStatus.WAIT_PAY.getValue().equals(orderStatus)) {
			// 如果是支付失败或者待支付，直接进入支付页面
			jumpURL = "../go/toPay.html?goId=" + goId + "&goOrderId=" + goOrderId;
			message = "需要您进行支付,请前往";
		} else if (OrderStatus.WAIT_CONFIRM.getValue().equals(orderStatus)) {
			// 如果是待海牛确认，则跳转到确认页面
			jumpURL = "../go/toConfirm.html?goOrderId=" + goOrderId;
			message = "需要等待海牛确认,请前往";
		} else if ((OrderStatus.REJECT.getValue().equals(orderStatus))) {
			// 海牛已经拒绝
			message = "海牛拒绝了您的参与请求，请重新选择其他活动";
			jumpURL = "../go/oneononeindex.html";
		} else if ((OrderStatus.WAIT_MEET.getValue().equals(orderStatus))) {
			message = "海牛接收了您的请求，请前往";
			jumpURL = "../go/toAppointment.html";
		}
		m.put("jumpURL", jumpURL);
		m.put("message", message);
		return m;
	}

	@RequestMapping("/toAppointment.html")
	public ModelAndView toAppointment(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/appointment");
		return view;
	}

	@RequestMapping("/toPay.html")
	public ModelAndView toPay(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		String goId = request.getParameter("goId");
		if (StringUtil.isBlank(goId) || StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("支付失败:您需要同时指定活动信息和活动预约单信息");
		}
		Go go = DubboServiceUtil.queryGo(goId);
		if (go == null) {
			throw new BusinessException("支付失败:活动不存在。请前往预约活动", true, "../go/oneononeindex.html");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("支付失败:您没有对此活动进行预约。请前往预约", true, "../go/toOrder.html?goId=" + go.getGoId());
		}
		// 判断活动是否属于待支付或者支付失败状态
		if (!(OrderStatus.PAY_FAILURE.getValue().equals(goOrder.getOrderStatus())
				|| OrderStatus.WAIT_PAY.getValue().equals(goOrder.getOrderStatus()))) {
			Map<String, String> m = this.getJumpURLAndMessageForJoiner(goOrder.getOrderStatus(), goOrder.getGoId(),
					goOrder.getOrderId());
			String jumpURL = m.get("jumpURL");
			String message = m.get("message");
			throw new BusinessException("此活动预约单不可支付," + message, true, jumpURL);
		}
		// 获取预约信息
		long timestamp = DateUtil.getCurrentTimeMillis();
		String nonceStr = WXHelpUtil.createNoncestr();
		String jsapiTicket = WXHelpUtil.getJSAPITicket();
		String url = WXRequestUtil.getFullURL(request);
		String signature = WXHelpUtil.createJSSDKSignatureSHA(nonceStr, jsapiTicket, timestamp, url);
		request.setAttribute("appId", GlobalSettings.getWeiXinAppId());
		request.setAttribute("timestamp", timestamp);
		request.setAttribute("nonceStr", nonceStr);
		request.setAttribute("signature", signature);

		request.setAttribute("userInfo", userInfo);
		request.setAttribute("openId", userInfo.getWxOpenid());
		request.setAttribute("topic", goOrder.getTopic());
		request.setAttribute("goId", goOrder.getGoId());
		request.setAttribute("goOrderId", goOrderId);
		request.setAttribute("orderStatus", goOrder.getOrderStatus());
		request.setAttribute("orderStatusName", goOrder.getOrderStatusName());
		request.setAttribute("price", AmountUtils.changeF2Y(goOrder.getFixedPrice()));
		ModelAndView view = new ModelAndView("go/pay");
		return view;
	}

	@RequestMapping("/publishGo.html")
	public ModelAndView publishGo(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		long timestamp = DateUtil.getCurrentTimeMillis();
		String nonceStr = WXHelpUtil.createNoncestr();
		String jsapiTicket = WXHelpUtil.getJSAPITicket();
		String url = WXRequestUtil.getFullURL(request);
		String signature = WXHelpUtil.createJSSDKSignatureSHA(nonceStr, jsapiTicket, timestamp, url);
		request.setAttribute("appId", GlobalSettings.getWeiXinAppId());
		request.setAttribute("timestamp", timestamp);
		request.setAttribute("nonceStr", nonceStr);
		request.setAttribute("signature", signature);
		request.setAttribute("url", url);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("go/publishgo");
		return view;
	}

	@RequestMapping("/toFeedback.html")
	public ModelAndView toFeedback(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/feedback");
		return view;
	}

	@RequestMapping("/confirmlist.html")
	public ModelAndView confirmlist(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/confirmlist");
		return view;
	}

	@RequestMapping("/godetail.html")
	public ModelAndView godetail(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/godetail");
		return view;
	}

	@RequestMapping("/groupindex.html")
	public ModelAndView groupindex(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/groupindex");
		return view;
	}

	@RequestMapping("/oneononeindex.html")
	public ModelAndView oneononeindex(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/oneononeindex");
		return view;
	}

	@RequestMapping("/comments.html")
	public ModelAndView comments(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/comments");
		return view;
	}

	@RequestMapping("/invite.html")
	public ModelAndView invite(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/invite");
		return view;
	}

	@RequestMapping("/invite2.html")
	public ModelAndView invite2(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/invite2");
		return view;
	}

	@RequestMapping("/getGoSystemTags")
	@ResponseBody
	public ResponseData<JSONObject> getGoSystemTags() {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		try {
			List<HyTagVo> allGoTags = HyTagUtil.getAllGoTags();
			data.put("allGoTags", allGoTags);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, "获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/submitNewGo")
	@ResponseBody
	public ResponseData<String> submitNewGo(String goData) {
		ResponseData<String> responseData = null;
		try {
			if (StringUtil.isBlank(goData)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "活动信息为空");
			}
			GoCreateReq request = JSON.parseObject(goData, GoCreateReq.class);
			GoCreateResp rep = DubboConsumerFactory.getService(IGoSV.class).createGo(request);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage(), "");
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "提交成功", "");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/uploadGoImgToOSS")
	public ResponseData<String> uploadGoImgToOSS(HttpServletRequest request) {
		ResponseData<String> responseData = null;
		String mediaId = request.getParameter("mediaId");
		String userId = request.getParameter("userId");
		try {
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户标识不存在");
			}
			String fileName = WXHelpUtil.uploadGoImgToOSS(mediaId, userId);
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName + "@!pipe1";
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "上传到OSS成功", fileURL);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/orderOneOnOne")
	@ResponseBody
	public ResponseData<String> orderOneOnOne(GoOrderCreateReq goOrderCreateReq) {
		ResponseData<String> responseData = null;
		try {
			GoOrderCreateResp rep = DubboConsumerFactory.getService(IGoSV.class).orderOneOnOne(goOrderCreateReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage());
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "提交成功", rep.getOrderId());
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/updateGoOrderPay")
	@ResponseBody
	public ResponseData<String> updateGoOrderPay(UpdateGoOrderPayReq updateGoOrderPayReq) {
		ResponseData<String> responseData = null;
		try {
			Response rep = DubboConsumerFactory.getService(IGoSV.class).updateGoOrderPay(updateGoOrderPayReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage());
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "提交成功", "");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/createGoPayOrder")
	@ResponseBody
	public ResponseData<JSONObject> createGoPayOrder(HttpServletRequest request) {
		ResponseData<JSONObject> responseData = null;
		try {
			String price = request.getParameter("price");
			String nonceStr = request.getParameter("nonceStr");
			String timeStamp = request.getParameter("timeStamp");
			String openId = request.getParameter("openId");
			String userId = request.getParameter("userId");
			String goId = request.getParameter("goId");
			String goOrderId = request.getParameter("goOrderId");
			if (StringUtil.isBlank(openId)) {
				throw new BusinessException("USER-100001", "生成支付流水失败:没有微信绑定信息");
			}
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException("USER-100001", "生成支付流水失败:用户标识不存在");
			}
			if (StringUtil.isBlank(goId)) {
				throw new BusinessException("GO-100001", "生成支付流水失败:活动标识不存在");
			}
			if (StringUtil.isBlank(goOrderId)) {
				throw new BusinessException("GO-100001", "生成支付流水失败:活动预约流水不存在");
			}
			String summary = "One on One活动预约支付";
			// 调用服务生成支付流水
			CreateGoPaymentOrderReq createGoPaymentOrderReq = new CreateGoPaymentOrderReq();
			createGoPaymentOrderReq.setBusiType(BusiType.PAY_FOR_GO.getValue());
			createGoPaymentOrderReq.setPayAmount(Long.parseLong(AmountUtils.changeY2F(price)));
			createGoPaymentOrderReq.setPayType(PayType.WEIXIN.getValue());
			createGoPaymentOrderReq.setSummary(summary);
			createGoPaymentOrderReq.setUserId(userId);
			createGoPaymentOrderReq.setGoOrderId(goOrderId);
			CreateGoPaymentOrderResp resp = DubboConsumerFactory.getService(IGoSV.class)
					.createGoPaymentOrder(createGoPaymentOrderReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			// 组织支付认证信息
			String payOrderId = resp.getPayOrderId();
			String host = "192.168.1.1";
			String pkg = WXHelpUtil.getPackageOfWXJSSDKChoosePayAPI(summary, payOrderId,
					Integer.parseInt(AmountUtils.changeY2F(price)), host, openId,
					GlobalSettings.getHarborWXPayNotifyURL(), nonceStr);
			String paySign = WXHelpUtil.getPaySignOfWXJSSDKChoosePayAPI(timeStamp, nonceStr, pkg);

			JSONObject d = new JSONObject();
			d.put("package", pkg);
			d.put("paySign", paySign);
			d.put("payOrderId", payOrderId);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, "处理成功", d);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/confirmGoOrder")
	@ResponseBody
	public ResponseData<String> confirmGoOrder(GoOrderConfirmReq goOrderConfirmReq) {
		ResponseData<String> responseData = null;
		try {
			Response rep = DubboConsumerFactory.getService(IGoSV.class).confirmGoOrder(goOrderConfirmReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage());
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "提交成功", "");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getMyGoes")
	@ResponseBody
	public ResponseData<PageInfo<Go>> getMyGoes(@NotNull(message = "参数为空") QueryMyGoReq queryMyGoReq,
			HttpServletRequest request) {
		ResponseData<PageInfo<Go>> responseData = null;
		try {
			// 获取用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			queryMyGoReq.setUserId(userInfo.getUserId());
			QueryMyGoResp rep = DubboConsumerFactory.getService(IGoSV.class).queryMyGoes(queryMyGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage());
			} else {
				responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功",
						rep.getPagInfo());
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

}
