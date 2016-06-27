package com.the.harbor.web.user.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.validator.constraints.NotBlank;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.aliyun.mns.client.CloudQueue;
import com.aliyun.mns.client.MNSClient;
import com.aliyun.mns.common.ClientException;
import com.aliyun.mns.common.ServiceException;
import com.aliyun.mns.model.Message;
import com.the.harbor.api.pay.IPaymentSV;
import com.the.harbor.api.pay.param.CreatePaymentOrderReq;
import com.the.harbor.api.pay.param.CreatePaymentOrderResp;
import com.the.harbor.api.user.IUserSV;
import com.the.harbor.api.user.param.DoUserFans;
import com.the.harbor.api.user.param.UserCertificationReq;
import com.the.harbor.api.user.param.UserEditReq;
import com.the.harbor.api.user.param.UserMemberInfo;
import com.the.harbor.api.user.param.UserMemberQuery;
import com.the.harbor.api.user.param.UserMemberRenewalReq;
import com.the.harbor.api.user.param.UserMemberRenewalResp;
import com.the.harbor.api.user.param.UserRegReq;
import com.the.harbor.api.user.param.UserSystemTagQueryReq;
import com.the.harbor.api.user.param.UserSystemTagQueryResp;
import com.the.harbor.api.user.param.UserSystemTagSubmitReq;
import com.the.harbor.api.user.param.UserTag;
import com.the.harbor.api.user.param.UserTagQueryReq;
import com.the.harbor.api.user.param.UserTagQueryResp;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.api.user.param.UserViewResp;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.enumeration.hypaymentorder.BusiType;
import com.the.harbor.base.enumeration.hypaymentorder.PayType;
import com.the.harbor.base.enumeration.mns.MQType;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.components.aliyuncs.mns.MNSFactory;
import com.the.harbor.commons.components.aliyuncs.sms.SMSSender;
import com.the.harbor.commons.components.aliyuncs.sms.param.SMSSendRequest;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
import com.the.harbor.commons.redisdata.util.HyUserUtil;
import com.the.harbor.commons.redisdata.util.SMSRandomCodeUtil;
import com.the.harbor.commons.util.CollectionUtil;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.util.UUIDUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.system.utils.WXUserUtil;
import com.the.harbor.web.weixin.param.WeixinUserInfo;

@RestController
@RequestMapping("/user")
public class UserController {

	private static final Logger LOG = LoggerFactory.getLogger(UserController.class);

	@RequestMapping("/pages.html")
	public ModelAndView pages(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView view = new ModelAndView("pages");
		return view;
	}

	@RequestMapping("/myguanzhu.html")
	public ModelAndView myguanzhu(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		ModelAndView view = new ModelAndView("user/myguanzhu");
		return view;
	}

	@RequestMapping("/myfans.html")
	public ModelAndView myfans(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		ModelAndView view = new ModelAndView("user/myfans");
		return view;
	}

	@RequestMapping("/messagecenter.html")
	public ModelAndView messagecenter(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/messagecenter");
		return view;
	}

	@RequestMapping("/mymessagedetail.html")
	public ModelAndView mymessagedetail(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/mymessagedetail");
		return view;
	}

	@RequestMapping("/tuijian.html")
	public ModelAndView tuijian(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView view = new ModelAndView("user/haiyoutuijian");
		return view;
	}

	@RequestMapping("/myhaiyou.html")
	public ModelAndView myhaiyou(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView view = new ModelAndView("user/myhaiyou");
		return view;
	}

	@RequestMapping("/toUserRegister.html")
	public ModelAndView toUserRegister(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserViewInfo userInfo = WXUserUtil.getUserViewInfoByWXAuth(request);
		if (userInfo != null) {
			throw new BusinessException("您的微信已经注册");
		}
		WeixinUserInfo wxUserInfo = WXUserUtil.getWeixinUserInfo(request);
		request.setAttribute("wxUserInfo", wxUserInfo);
		ModelAndView view = new ModelAndView("user/toUserRegister");
		return view;
	}

	@RequestMapping("/getRandomCode")
	public ResponseData<String> getRandomCode(String mobilePhone) {
		ResponseData<String> responseData = null;
		try {
			if (StringUtil.isBlank(mobilePhone)) {
				throw new BusinessException("请输入您的手机号码");
			}
			String randomCode = SMSRandomCodeUtil.getSmsRandomCode(mobilePhone);
			if (!StringUtil.isBlank(randomCode)) {
				throw new BusinessException("验证码已经发送，一分钟内不要重复获取");
			}
			// 生成随机验证码，并且存入到缓存中
			randomCode = SMSRandomCodeUtil.createRandomCode();
			/* 调用API发送短信 */
			SMSSendRequest req = new SMSSendRequest();
			List<String> recNumbers = new ArrayList<String>();
			recNumbers.add(mobilePhone);
			JSONObject smsParams = new JSONObject();
			smsParams.put("randomCode", randomCode);
			req.setRecNumbers(recNumbers);
			req.setSmsFreeSignName(GlobalSettings.getSMSFreeSignName());
			req.setSmsParams(smsParams);
			req.setSmsTemplateCode(GlobalSettings.getSMSUserRandomCodeTemplate());
			SMSSender.send(req);
			SMSRandomCodeUtil.setSmsRandomCode(mobilePhone, randomCode);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "验证码发送成功", randomCode);
		} catch (BusinessException e) {
			LOG.error(e.getErrorMessage(), e);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, e.getMessage());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/submitUserRegister")
	public ResponseData<String> submitUserRegister(String userData, String randomCode) {
		ResponseData<String> responseData = null;
		try {
			if (StringUtil.isBlank(userData)) {
				throw new BusinessException("用户信息格式不正确");
			}
			if (StringUtil.isBlank(randomCode)) {
				throw new BusinessException("请输入验证码");
			}
			UserRegReq userRegReq = JSONObject.parseObject(userData, UserRegReq.class);
			if (userRegReq == null) {
				throw new BusinessException("用户信息格式不正确");
			}
			if (StringUtil.isBlank(userRegReq.getMobilePhone())) {
				throw new BusinessException("请输入手机号码");
			}
			String code = SMSRandomCodeUtil.getSmsRandomCode(userRegReq.getMobilePhone());
			if (StringUtil.isBlank(code)) {
				throw new BusinessException("验证码已经过期，请重新获取");
			}
			if (!randomCode.equals(code)) {
				throw new BusinessException("输入的验证码不正确");
			}
			Response rep = DubboConsumerFactory.getService(IUserSV.class).userRegister(userRegReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage(), "");
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "注册成功", "");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/toApplyCertficate.html")
	public ModelAndView toApplyCertficate(HttpServletRequest request) {
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
		ModelAndView view = new ModelAndView("user/toApplyCertficate");
		return view;
	}

	@RequestMapping("/submitUserCertficate")
	@ResponseBody
	public ResponseData<String> submitUserCertficate(UserCertificationReq req) {
		ResponseData<String> responseData = null;
		try {
			if (req == null) {
				throw new BusinessException("认证材料信息不正确");
			}
			Response rep = DubboConsumerFactory.getService(IUserSV.class).submitUserCertification(req);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage(), "");
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "认证信息提交成功", "");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/uploadUserAuthFileToOSS")
	public ResponseData<String> uploadUserAuthFileToOSS(HttpServletRequest request) {
		ResponseData<String> responseData = null;
		String mediaId = request.getParameter("mediaId");
		String userId = request.getParameter("userId");
		try {
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户标识不存在");
			}
			String fileName = WXHelpUtil.uploadUserAuthFileToOSS(mediaId, userId);
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName + "@!pipe1";
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "上传到OSS成功", fileURL);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/uploadUserHomeBgToOSS")
	public ResponseData<String> uploadUserHomeBgToOSS(HttpServletRequest request) {
		ResponseData<String> responseData = null;
		String mediaId = request.getParameter("mediaId");
		String userId = request.getParameter("userId");
		try {
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户标识不存在");
			}
			String fileName = WXHelpUtil.uploadUserHomeBgToOSS(mediaId, userId);
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName + "@!pipe1";
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "上传到OSS成功", fileURL);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/uploadUserHeadIconToOSS")
	public ResponseData<String> uploadUserHeadIconToOSS(HttpServletRequest request) {
		ResponseData<String> responseData = null;
		String mediaId = request.getParameter("mediaId");
		String userId = request.getParameter("userId");
		try {
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户标识不存在");
			}
			String fileName = WXHelpUtil.uploadUserHeadIconToOSS(mediaId, userId);
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName + "@!pipe1";
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "上传到OSS成功", fileURL);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/userInfo.html")
	public ModelAndView userInfo(HttpServletRequest request) {
		String userId = request.getParameter("userId");
		if (StringUtil.isBlank(userId)) {
			throw new BusinessException("USER-100001", "查看的用户不存在");
		}
		UserViewResp resp = DubboConsumerFactory.getService(IUserSV.class).queryUserViewByUserId(userId);
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultCode(),
					resp.getResponseHeader().getResultMessage());
		}
		UserViewInfo userInfo = resp.getUserInfo();
		if (userInfo == null) {
			throw new BusinessException("USER-100001", "您访问的用户不存在");
		}
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("user/userInfo");
		return view;
	}

	@RequestMapping("/previewUserInfo.html")
	public ModelAndView previewUserInfo(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("user/userInfopreview");
		return view;
	}

	@RequestMapping("/memberCenter.html")
	public ModelAndView memberCenter(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		UserMemberQuery query = new UserMemberQuery();
		query.setUserId(userInfo.getUserId());
		UserMemberInfo userMember = DubboConsumerFactory.getService(IUserSV.class).queryUserMemberInfo(query);
		if (!ExceptCodeConstants.SUCCESS.equals(userMember.getResponseHeader().getResultCode())) {
			throw new BusinessException(userMember.getResponseHeader().getResultCode(),
					userMember.getResponseHeader().getResultMessage());
		}
		request.setAttribute("openId", userInfo.getWxOpenid());
		request.setAttribute("userMember", userMember);
		long timestamp = DateUtil.getCurrentTimeMillis();
		String nonceStr = WXHelpUtil.createNoncestr();
		String jsapiTicket = WXHelpUtil.getJSAPITicket();
		String url = WXRequestUtil.getFullURL(request);
		String signature = WXHelpUtil.createJSSDKSignatureSHA(nonceStr, jsapiTicket, timestamp, url);
		request.setAttribute("appId", GlobalSettings.getWeiXinAppId());
		request.setAttribute("timestamp", timestamp);
		request.setAttribute("nonceStr", nonceStr);
		request.setAttribute("signature", signature);
		ModelAndView view = new ModelAndView("user/memberCenter");
		return view;
	}

	@RequestMapping("/createMemberPayOrder")
	@ResponseBody
	public ResponseData<JSONObject> createMemberPayOrder(HttpServletRequest request) {
		ResponseData<JSONObject> responseData = null;
		try {
			String payMonth = request.getParameter("payMonth");
			String price = request.getParameter("price");
			String nonceStr = request.getParameter("nonceStr");
			String timeStamp = request.getParameter("timeStamp");
			String openId = request.getParameter("openId");
			String userId = request.getParameter("userId");
			if (StringUtil.isBlank(openId)) {
				throw new BusinessException("USER-100001", "生成支付流水失败:没有微信绑定信息");
			}
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException("USER-100001", "生成支付流水失败:用户标识不存在");
			}
			String summary = GlobalSettings.getWeiXinMerchantName() + payMonth + "个月会员";
			// 调用服务生成支付流水
			CreatePaymentOrderReq createPaymentOrderReq = new CreatePaymentOrderReq();
			createPaymentOrderReq.setBusiType(BusiType.PAY_FOR_MEMBER.getValue());
			createPaymentOrderReq.setPayAmount(Long.parseLong(price));
			createPaymentOrderReq.setPayType(PayType.WEIXIN.getValue());
			createPaymentOrderReq.setSummary(summary);
			createPaymentOrderReq.setUserId(userId);
			CreatePaymentOrderResp resp = DubboConsumerFactory.getService(IPaymentSV.class)
					.createPaymentOrder(createPaymentOrderReq);
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

	@RequestMapping("/userMemberRenewal")
	@ResponseBody
	public ResponseData<UserMemberRenewalResp> userMemberRenewal(UserMemberRenewalReq request) {
		ResponseData<UserMemberRenewalResp> responseData = null;
		try {
			UserMemberRenewalResp resp = DubboConsumerFactory.getService(IUserSV.class).userMemberRenewal(request);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}

			responseData = new ResponseData<UserMemberRenewalResp>(ResponseData.AJAX_STATUS_SUCCESS, "会员续期成功", resp);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, UserMemberRenewalResp.class);
		}
		return responseData;
	}

	@RequestMapping("/userCenter.html")
	public ModelAndView userCenter(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("fansCount", HyUserUtil.getUserFans(userInfo.getUserId()).size());
		request.setAttribute("guanzhuCount", HyUserUtil.getUserGuanzhuUsers(userInfo.getUserId()).size());
		ModelAndView view = new ModelAndView("user/userCenter");
		return view;
	}

	@RequestMapping("/editUserInfo.html")
	public ModelAndView editUserInfo(HttpServletRequest request) {
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
		request.setAttribute("openId", userInfo.getWxOpenid());
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("user/editUserInfo");
		return view;
	}

	@RequestMapping("/getUserCard.html")
	public ModelAndView getUserCard(HttpServletRequest request) {
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
		request.setAttribute("url",
				GlobalSettings.getHarborDomain() + "/user/getUserCardDetail.html?userId=" + userInfo.getUserId());
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("user/userCard");
		return view;
	}

	@RequestMapping("/getUserCardDetail.html")
	public ModelAndView getUserCardDetail(HttpServletRequest request) {
		String userId = request.getParameter("userId");
		if (StringUtil.isBlank(userId)) {
			throw new BusinessException("USER-100001", "您访问的用户名片不存在");
		}
		UserViewResp resp = DubboConsumerFactory.getService(IUserSV.class).queryUserViewByUserId(userId);
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultCode(),
					resp.getResponseHeader().getResultMessage());
		}
		UserViewInfo userInfo = resp.getUserInfo();
		System.out.println("获取到的用户信息=" + JSON.toJSONString(userInfo));
		if (userInfo == null) {
			throw new BusinessException("USER-100001", "您访问的用户名片不存在");
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
		request.setAttribute("url",
				GlobalSettings.getHarborDomain() + "/user/getUserCardDetail.html?userId=" + userInfo.getUserId());
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("user/userCard");
		return view;
	}

	@RequestMapping("/userWealth.html")
	public ModelAndView userWealth(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("user/userWealth");
		return view;
	}

	@RequestMapping("/setUserSkills.html")
	public ModelAndView setUserSkills(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("user/setUserSkills");
		return view;
	}

	@RequestMapping("/getSystemTags")
	@ResponseBody
	public ResponseData<JSONObject> getSystemTags(String userId) {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		UserSystemTagQueryResp resp = null;
		try {
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户标识不存在");
			}
			// 获取用户选择的标签
			UserSystemTagQueryReq userSystemTagQueryReq = new UserSystemTagQueryReq();
			userSystemTagQueryReq.setUserId(userId);
			resp = DubboConsumerFactory.getService(IUserSV.class).queryUserSystemTags(userSystemTagQueryReq);
		} catch (Exception ex) {
			LOG.error("加载用户已经选择的系统标签出错", ex);
		}

		try {
			// 获取面板上的系统内置标签
			List<HyTagVo> skillAllTags = HyTagUtil.getAllBaseSkillTags();
			List<HyTagVo> interestAllTags = HyTagUtil.getAllBaseInterestTags();
			// 根据用户选择的标签给面板上的总标签打标记
			this.markTags(skillAllTags, resp.getSystemSkillTags());
			this.markTags(interestAllTags, resp.getSystemInterestTags());
			data.put("interestSelectedTags", this.getSelectedTags(interestAllTags));
			data.put("skillSelectedTags", this.getSelectedTags(skillAllTags));
			data.put("skillAllTags", skillAllTags);
			data.put("interestAllTags", interestAllTags);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, "获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/submitUserSelectedSystemTags")
	@ResponseBody
	public ResponseData<String> submitUserSelectedSystemTags(String submitString) {
		ResponseData<String> responseData = null;
		try {
			UserSystemTagSubmitReq request = JSON.parseObject(submitString, UserSystemTagSubmitReq.class);
			Response rep = DubboConsumerFactory.getService(IUserSV.class).submitUserSelectedSystemTags(request);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
						rep.getResponseHeader().getResultMessage(), "");
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "提交成功", "");
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "处理成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/getUserTags")
	@ResponseBody
	public ResponseData<JSONObject> getUserTags(String userId) {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		/* 获取用户已经选择的所有标签 */
		UserTagQueryResp resp = null;
		try {
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户标识不存在");
			}
			// 获取用户选择的标签
			UserTagQueryReq userTagQueryReq = new UserTagQueryReq();
			userTagQueryReq.setUserId(userId);
			resp = DubboConsumerFactory.getService(IUserSV.class).queryUserTags(userTagQueryReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
		} catch (Exception ex) {
			LOG.error("加载用户已经选择的系统标签出错", ex);
		}

		try {
			/* 已经选择的兴趣标签 */
			List<UserTag> selectedInterestTags = resp.getInterestTags();
			/* 已经选择的技能标签 */
			List<UserTag> selectedSkillTags = resp.getSkillTags();
			/* 系统提供的技能标签 */
			List<HyTagVo> skillAllTags = HyTagUtil.getAllBaseSkillTags();
			/* 系统提供的兴趣标签 */
			List<HyTagVo> interestAllTags = HyTagUtil.getAllBaseInterestTags();

			/* 标记系统级别的兴趣和性能标签被选择了 */
			this.markTags(interestAllTags, selectedInterestTags);
			this.markTags(skillAllTags, selectedSkillTags);

			data.put("selectedInterestTags", selectedInterestTags);
			data.put("selectedSkillTags", selectedSkillTags);
			data.put("skillAllTags", skillAllTags);
			data.put("interestAllTags", interestAllTags);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, "获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/submitUserEdit")
	@ResponseBody
	public ResponseData<String> submitUserEdit(String userData) {
		ResponseData<String> responseData = null;
		try {
			if (StringUtil.isBlank(userData)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户信息为空");
			}
			UserEditReq request = JSON.parseObject(userData, UserEditReq.class);
			Response rep = DubboConsumerFactory.getService(IUserSV.class).userEdit(request);
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

	@RequestMapping("/getMyGuanzhuUsers")
	@ResponseBody
	public ResponseData<JSONArray> getMyGuanzhuUsers(HttpServletRequest request) {
		ResponseData<JSONArray> responseData = null;
		try {
			JSONArray arr = new JSONArray();
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Set<String> userIds = HyUserUtil.getUserGuanzhuUsers(userInfo.getUserId());
			for (String userId : userIds) {
				// 获取单个用户信息
				UserViewInfo u = WXUserUtil.getUserViewInfoByUserId(userId);
				if (u != null) {
					JSONObject d = new JSONObject();
					d.put("userId", u.getUserId());
					d.put("wxHeadimg", u.getWxHeadimg());
					d.put("enName", u.getEnName());
					d.put("abroadCountryName", u.getAbroadCountryName());
					d.put("userStatusName", u.getUserStatusName());
					d.put("industryName", u.getIndustryName());
					d.put("title", u.getTitle());
					d.put("atCityName", u.getAtCityName());
					arr.add(d);
				}
			}
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功", arr);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
		}
		return responseData;
	}

	@RequestMapping("/getMyFansUsers")
	@ResponseBody
	public ResponseData<JSONArray> getMyFansUsers(HttpServletRequest request) {
		ResponseData<JSONArray> responseData = null;
		try {
			JSONArray arr = new JSONArray();
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Set<String> userIds = HyUserUtil.getUserFans(userInfo.getUserId());
			for (String userId : userIds) {
				// 获取单个用户信息
				UserViewInfo u = WXUserUtil.getUserViewInfoByUserId(userId);
				if (u != null) {
					JSONObject d = new JSONObject();
					d.put("userId", u.getUserId());
					d.put("wxHeadimg", u.getWxHeadimg());
					d.put("enName", u.getEnName());
					d.put("abroadCountryName", u.getAbroadCountryName());
					d.put("userStatusName", u.getUserStatusName());
					d.put("industryName", u.getIndustryName());
					d.put("title", u.getTitle());
					d.put("atCityName", u.getAtCityName());
					arr.add(d);
				}
			}
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功", arr);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
		}
		return responseData;
	}

	@RequestMapping("/addFans")
	@ResponseBody
	public ResponseData<String> addFans(@NotBlank(message = "粉丝用户ID为空") String fansUserId, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			if (userInfo.getUserId().equals(fansUserId)) {
				throw new BusinessException("您不可以关注自己哦");
			}
			Set<String> sets = HyUserUtil.getUserFans(userInfo.getUserId());
			if(sets.contains(fansUserId)){
				throw new BusinessException("您已经关注了这个海友哦");
			}
			// 构造一条粉丝关注的消息
			this.sendAddFansMQ(userInfo.getUserId(), fansUserId);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/cancelFans")
	@ResponseBody
	public ResponseData<String> cancelFans(@NotBlank(message = "粉丝用户ID为空") String fansUserId,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Set<String> sets = HyUserUtil.getUserFans(userInfo.getUserId());
			if(!sets.contains(fansUserId)){
				throw new BusinessException("您没有关注这个海友哦");
			}
			// 构造一条粉丝关注的消息
			this.sendDeleteFansMQ(userInfo.getUserId(), fansUserId);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	/**
	 * 发送添加粉丝消息
	 * 
	 * @param userId
	 * @param fansUserId
	 */
	private void sendAddFansMQ(String userId, String fansUserId) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserInteractionQueueName());
			Message message = new Message();
			DoUserFans body = new DoUserFans();
			body.setFansUserId(fansUserId);
			body.setUserId(userId);
			body.setTime(DateUtil.getSysDate());
			body.setHandleType(DoUserFans.HandleType.GUANZHU.name());
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_USER_FANS.getValue());
			message.setMessageBody(JSONObject.toJSONString(body));
			queue.putMessage(message);
		} catch (ClientException ce) {
			LOG.error("Something wrong with the network connection between client and MNS service."
					+ "Please check your network and DNS availablity.", ce);
		} catch (ServiceException se) {
			if (se.getErrorCode().equals("QueueNotExist")) {
				LOG.error("Queue is not exist.Please create before use", se);
			} else if (se.getErrorCode().equals("TimeExpired")) {
				LOG.error("The request is time expired. Please check your local machine timeclock", se);
			}
			LOG.error("User Fans build  message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

	/**
	 * 发送删除粉丝消息
	 * 
	 * @param userId
	 * @param fansUserId
	 */
	private void sendDeleteFansMQ(String userId, String fansUserId) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserInteractionQueueName());
			Message message = new Message();
			DoUserFans body = new DoUserFans();
			body.setFansUserId(fansUserId);
			body.setUserId(userId);
			body.setTime(DateUtil.getSysDate());
			body.setHandleType(DoUserFans.HandleType.CANCEL.name());
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_USER_FANS.getValue());
			message.setMessageBody(JSONObject.toJSONString(body));
			queue.putMessage(message);
		} catch (ClientException ce) {
			LOG.error("Something wrong with the network connection between client and MNS service."
					+ "Please check your network and DNS availablity.", ce);
		} catch (ServiceException se) {
			if (se.getErrorCode().equals("QueueNotExist")) {
				LOG.error("Queue is not exist.Please create before use", se);
			} else if (se.getErrorCode().equals("TimeExpired")) {
				LOG.error("The request is time expired. Please check your local machine timeclock", se);
			}
			LOG.error("User Fans build  message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

	private List<HyTagVo> getSelectedTags(List<HyTagVo> allTags) {
		List<HyTagVo> l = new ArrayList<HyTagVo>();
		if (!CollectionUtil.isEmpty(allTags)) {
			for (HyTagVo t : allTags) {
				if (t.isSelected()) {
					l.add(t);
				}
			}
		}
		return l;
	}

	private void markTags(List<HyTagVo> allTags, List<UserTag> selectedTags) {
		if (CollectionUtil.isEmpty(allTags)) {
			return;
		}
		if (CollectionUtil.isEmpty(selectedTags)) {
			return;
		}
		for (HyTagVo tag : allTags) {
			for (UserTag ut : selectedTags) {
				if (tag.getTagId().equals(ut.getTagId())) {
					tag.setSelected(true);
					break;
				}
			}
		}

	}

}
