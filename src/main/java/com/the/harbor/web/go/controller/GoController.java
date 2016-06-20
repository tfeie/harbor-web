package com.the.harbor.web.go.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.the.harbor.api.go.param.GoCreateReq;
import com.the.harbor.api.go.param.GoCreateResp;
import com.the.harbor.api.go.param.GoOrderCheckReq;
import com.the.harbor.api.go.param.GoOrderCheckResp;
import com.the.harbor.api.go.param.GoOrderCreateReq;
import com.the.harbor.api.go.param.GoOrderCreateResp;
import com.the.harbor.api.go.param.GoOrderQueryReq;
import com.the.harbor.api.go.param.GoOrderQueryResp;
import com.the.harbor.api.go.param.UpdateGoOrderPayReq;
import com.the.harbor.api.user.param.UserInfo;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.enumeration.hypaymentorder.BusiType;
import com.the.harbor.base.enumeration.hypaymentorder.PayType;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
import com.the.harbor.commons.util.AmountUtils;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.system.utils.WXUserUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;

@RestController
@RequestMapping("/go")
public class GoController {

	private static final Logger LOG = Logger.getLogger(GoController.class);

	@RequestMapping("/toConfirm.html")
	public ModelAndView toConfirm(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/confirm");
		return view;
	}

	@RequestMapping("/toOrder.html")
	public ModelAndView toOrder(HttpServletRequest request) {
		String goId = request.getParameter("goId");
		if (StringUtil.isBlank(goId)) {
			throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "预约失败:缺少活动标识");
		}
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromReqAttr(request);
		LOG.debug("获取到的微信认证token=" + JSON.toJSONString(wtoken));
		UserInfo userInfo = WXUserUtil.getUserInfo(wtoken.getOpenId());
		System.out.println("获取到的用户信息=" + JSON.toJSONString(userInfo));
		if (userInfo == null) {
			throw new BusinessException("USER-100001", "您的微信号没有注册成用户，请先注册");
		}
		request.setAttribute("goId", goId);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("go/order");
		return view;
	}

	@RequestMapping("/toAppointment.html")
	public ModelAndView toAppointment(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/appointment");
		return view;
	}

	@RequestMapping("/toPay.html")
	public ModelAndView toPay(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "支付失败:缺少活动预约信息");
		}
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromReqAttr(request);
		UserInfo userInfo = WXUserUtil.getUserInfo(wtoken.getOpenId());
		if (userInfo == null) {
			throw new BusinessException("USER-100001", "您的微信号没有注册成用户，请先注册");
		}
		// 获取预约信息
		GoOrderQueryReq goOrderQueryReq = new GoOrderQueryReq();
		goOrderQueryReq.setGoOrderId(goOrderId);
		GoOrderQueryResp goOrderQueryResp = DubboConsumerFactory.getService(IGoSV.class)
				.queryGoOrderDetail(goOrderQueryReq);
		if (!ExceptCodeConstants.SUCCESS.equals(goOrderQueryResp.getResponseHeader().getResultCode())) {
			throw new BusinessException(goOrderQueryResp.getResponseHeader().getResultCode(),
					goOrderQueryResp.getResponseHeader().getResultMessage());
		}
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
		request.setAttribute("openId", wtoken.getOpenId());
		request.setAttribute("topic", goOrderQueryResp.getTopic());
		request.setAttribute("goId", goOrderQueryResp.getGoId());
		request.setAttribute("goOrderId", goOrderId);
		request.setAttribute("price", AmountUtils.changeF2Y(goOrderQueryResp.getFixedPrice()));
		ModelAndView view = new ModelAndView("go/pay");
		return view;
	}

	@RequestMapping("/publishGo.html")
	public ModelAndView publishGo(HttpServletRequest request) {
		WeixinOauth2Token wtoken = WXRequestUtil.getWeixinOauth2TokenFromReqAttr(request);
		LOG.debug("获取到的微信认证token=" + JSON.toJSONString(wtoken));
		UserInfo userInfo = WXUserUtil.getUserInfo(wtoken.getOpenId());
		System.out.println("获取到的用户信息=" + JSON.toJSONString(userInfo));
		if (userInfo == null) {
			throw new BusinessException("USER-100001", "您的微信号没有注册成用户，请先注册");
		}
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

	@RequestMapping("/checkUserJoinGo")
	@ResponseBody
	public ResponseData<GoOrderCheckResp> checkUserJoinGo(String userId, String goId) {
		ResponseData<GoOrderCheckResp> responseData = null;
		try {
			GoOrderCheckReq goOrderCheckReq = new GoOrderCheckReq();
			goOrderCheckReq.setGoId(goId);
			goOrderCheckReq.setUserId(userId);
			GoOrderCheckResp rep = DubboConsumerFactory.getService(IGoSV.class).checkUserJoinGo(goOrderCheckReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<GoOrderCheckResp>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage());
			} else {
				responseData = new ResponseData<GoOrderCheckResp>(ResponseData.AJAX_STATUS_SUCCESS, "提交成功", rep);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<GoOrderCheckResp>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
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
			String summary = "活动[" + goId + "]预约流水[" + goOrderId + "]支付";
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
			String pkg = WXHelpUtil.getPackageOfWXJSSDKChoosePayAPI(summary, payOrderId, Integer.parseInt(price), host,
					openId, GlobalSettings.getHarborWXPayNotifyURL(), nonceStr);
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

}
