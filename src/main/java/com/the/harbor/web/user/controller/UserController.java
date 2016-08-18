package com.the.harbor.web.user.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;

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
import com.the.harbor.api.user.IUserSV;
import com.the.harbor.api.user.param.CreateUserBuyHBOrderReq;
import com.the.harbor.api.user.param.CreateUserBuyHBOrderResp;
import com.the.harbor.api.user.param.CreateUserBuyMemberOrderReq;
import com.the.harbor.api.user.param.CreateUserBuyMemberOrderResp;
import com.the.harbor.api.user.param.DoUserFans;
import com.the.harbor.api.user.param.DoUserFriend;
import com.the.harbor.api.user.param.UserAuthReq;
import com.the.harbor.api.user.param.UserCertificationReq;
import com.the.harbor.api.user.param.UserEditReq;
import com.the.harbor.api.user.param.UserInviteInfo;
import com.the.harbor.api.user.param.UserInviteReq;
import com.the.harbor.api.user.param.UserMemberInfo;
import com.the.harbor.api.user.param.UserMemberQuery;
import com.the.harbor.api.user.param.UserRegReq;
import com.the.harbor.api.user.param.UserSystemTagQueryReq;
import com.the.harbor.api.user.param.UserSystemTagQueryResp;
import com.the.harbor.api.user.param.UserSystemTagSubmitReq;
import com.the.harbor.api.user.param.UserTag;
import com.the.harbor.api.user.param.UserTagQueryReq;
import com.the.harbor.api.user.param.UserTagQueryResp;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.api.user.param.UserViewResp;
import com.the.harbor.api.user.param.UserWealthQueryResp;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.enumeration.hypaymentorder.PayType;
import com.the.harbor.base.enumeration.hyuser.UserInviteStatus;
import com.the.harbor.base.enumeration.hyuser.UserStatus;
import com.the.harbor.base.enumeration.mns.MQType;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.components.aliyuncs.im.IMSettings;
import com.the.harbor.commons.components.aliyuncs.sms.SMSSender;
import com.the.harbor.commons.components.aliyuncs.sms.param.SMSSendRequest;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.redis.CacheFactory;
import com.the.harbor.commons.components.redis.interfaces.ICacheClient;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyCfgUtil;
import com.the.harbor.commons.redisdata.util.HyNotifyUtil;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
import com.the.harbor.commons.redisdata.util.HyUserUtil;
import com.the.harbor.commons.redisdata.util.SMSRandomCodeUtil;
import com.the.harbor.commons.util.CollectionUtil;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.Java3DESUtil;
import com.the.harbor.commons.util.Pinyin;
import com.the.harbor.commons.util.SignUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.util.UUIDUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.system.utils.WXUserUtil;
import com.the.harbor.web.util.DubboServiceUtil;
import com.the.harbor.web.util.UserInteractionMQSend;
import com.the.harbor.web.weixin.param.WeixinUserInfo;

@RestController
@RequestMapping("/user")
public class UserController {

	private static final Logger LOG = LoggerFactory.getLogger(UserController.class);

	@RequestMapping("/im.html")
	public ModelAndView im(HttpServletRequest request) {
		String touchId = request.getParameter("touchId");
		if (StringUtil.isBlank(touchId)) {
			throw new BusinessException("请选择您要聊天的海友");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		if (userInfo.getUserId().equals(touchId)) {
			throw new BusinessException("您不能和自己聊天");
		}
		UserViewInfo toUserInfo = WXUserUtil.getUserViewInfoByUserId(touchId);
		request.setAttribute("uid", userInfo.getUserId());
		request.setAttribute("credential", userInfo.getWxOpenid());
		request.setAttribute("appkey", IMSettings.getAppKey());
		request.setAttribute("touid", touchId);
		request.setAttribute("toUserIcon", toUserInfo.getWxHeadimg());
		request.setAttribute("fromUserIcon", userInfo.getWxHeadimg());
		request.setAttribute("title", "与"+ toUserInfo.getEnName() +"聊天中");
		ModelAndView view = new ModelAndView("user/im");
		return view;
	}

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
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		ModelAndView view = new ModelAndView("user/messagecenter");
		return view;
	}

	@RequestMapping("/mymessagedetail.html")
	public ModelAndView mymessagedetail(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/mymessagedetail");
		return view;
	}

	@RequestMapping("/myhaiyou.html")
	public ModelAndView myhaiyou(HttpServletRequest request, HttpServletResponse response) throws Exception {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		ModelAndView view = new ModelAndView("user/myhaiyou");
		return view;
	}

	@RequestMapping("/toUserRegister.html")
	public ModelAndView toUserRegister(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserViewInfo userInfo = WXUserUtil.getUserViewInfoByWXAuth(request);
		if (userInfo != null) {
			throw new BusinessException("您的微信已经注册");
		}
		boolean invite = HyCfgUtil.checkUserRegisterByInvite();
		String pcode = request.getParameter("pcode");
		if (invite) {
			if (StringUtil.isBlank(pcode)) {
				throw new BusinessException("目前只开通邀约注册，速速找好友邀请吧~", true, "../user/toUserInviteCode.html");
			}
			String jsonparam = Java3DESUtil.decryptThreeDESECB(pcode);
			JSONObject json = JSONObject.parseObject(jsonparam);
			String inviteCode = json.getString("inviteCode");
			String userId = json.getString("userId");
			String sign = json.getString("sign");
			String newsign = SignUtil.getUserInviteSign(userId, inviteCode);
			if (!newsign.equals(sign)) {
				throw new BusinessException("分享连接失效或者已被使用，速速找好友邀请吧~");
			}
			pcode = java.net.URLEncoder.encode(pcode);
			request.setAttribute("pcode", pcode);
		}
		WeixinUserInfo wxUserInfo = WXUserUtil.getWeixinUserInfo(request);
		request.setAttribute("wxUserInfo", wxUserInfo);
		ModelAndView view = new ModelAndView("user/toUserRegister");
		return view;
	}

	@RequestMapping("/getRandomCode")
	public ResponseData<String> getRandomCode(@NotBlank(message = "手机号码为空") String mobilePhone) {
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
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, ExceptCodeConstants.SUCCESS,
					e.getMessage());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/submitUserRegister")
	public ResponseData<String> submitUserRegister(@NotNull(message = "参数为空") String userData,
			@NotNull(message = "验证码为空") String randomCode, HttpServletRequest request) {
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
			boolean invite = HyCfgUtil.checkUserRegisterByInvite();
			String pcode = request.getParameter("pcode");
			if (invite) {
				if (StringUtil.isBlank(pcode)) {
					throw new BusinessException("目前只开通邀约注册，请通过分享连接进入注册~");
				}
				pcode = java.net.URLDecoder.decode(pcode);

				String jsonparam = Java3DESUtil.decryptThreeDESECB(pcode);
				JSONObject json = JSONObject.parseObject(jsonparam);
				String inviteCode = json.getString("inviteCode");
				String userId = json.getString("userId");
				String sign = json.getString("sign");
				String newsign = SignUtil.getUserInviteSign(userId, inviteCode);
				if (!newsign.equals(sign)) {
					throw new BusinessException("邀请码已经失效或者被使用，速速找好友邀请吧~");
				}
				userRegReq.setInviteCode(inviteCode);
			}
			Response rep = DubboConsumerFactory.getService(IUserSV.class).userRegister(userRegReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"注册成功", "");
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
	public ResponseData<String> submitUserCertficate(@NotNull(message = "参数为空") UserCertificationReq req) {
		ResponseData<String> responseData = null;
		try {
			if (req == null) {
				throw new BusinessException("认证材料信息不正确");
			}
			Response rep = DubboConsumerFactory.getService(IUserSV.class).submitUserCertification(req);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
						"认证信息提交成功", "");
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
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName;
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"上传到OSS成功", fileURL);
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
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName + "@!user_home_bg";
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"上传到OSS成功", fileURL);
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
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName + "@!user_headicon";
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"上传到OSS成功", fileURL);
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

	@RequestMapping("/buyhaibei.html")
	public ModelAndView buyhaibei(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		long timestamp = DateUtil.getCurrentTimeMillis();
		String nonceStr = WXHelpUtil.createNoncestr();
		String jsapiTicket = WXHelpUtil.getJSAPITicket();
		String url = WXRequestUtil.getFullURL(request);
		String signature = WXHelpUtil.createJSSDKSignatureSHA(nonceStr, jsapiTicket, timestamp, url);
		request.setAttribute("appId", GlobalSettings.getWeiXinAppId());
		request.setAttribute("timestamp", timestamp);
		request.setAttribute("nonceStr", nonceStr);
		request.setAttribute("signature", signature);
		ModelAndView view = new ModelAndView("user/buyhaibei");
		return view;
	}

	@RequestMapping("/createMemberPayOrder")
	@ResponseBody
	public ResponseData<JSONObject> createMemberPayOrder(HttpServletRequest request) {
		ResponseData<JSONObject> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			String payMonth = request.getParameter("payMonth");
			String price = request.getParameter("price");
			String nonceStr = request.getParameter("nonceStr");
			String timeStamp = request.getParameter("timeStamp");
			String summary = GlobalSettings.getWeiXinMerchantName() + payMonth + "个月会员";
			// 调用服务生成支付流水
			CreateUserBuyMemberOrderReq createPaymentOrderReq = new CreateUserBuyMemberOrderReq();
			createPaymentOrderReq.setPayAmount(Long.parseLong(price));
			createPaymentOrderReq.setPayType(PayType.WEIXIN.getValue());
			createPaymentOrderReq.setSummary(summary);
			createPaymentOrderReq.setUserId(userInfo.getUserId());
			createPaymentOrderReq.setFromSign(nonceStr);
			createPaymentOrderReq.setBuyMonths(Integer.parseInt(payMonth));
			CreateUserBuyMemberOrderResp resp = DubboConsumerFactory.getService(IUserSV.class)
					.createUserBuyMember(createPaymentOrderReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			// 组织支付认证信息
			String payOrderId = resp.getPayOrderId();
			String host = "192.168.1.1";
			String pkg = WXHelpUtil.getPackageOfWXJSSDKChoosePayAPI(summary, payOrderId, Integer.parseInt(price), host,
					userInfo.getWxOpenid(), GlobalSettings.getHarborWXPayNotifyURL(), nonceStr);
			String paySign = WXHelpUtil.getPaySignOfWXJSSDKChoosePayAPI(timeStamp, nonceStr, pkg);

			JSONObject d = new JSONObject();
			d.put("package", pkg);
			d.put("paySign", paySign);
			d.put("payOrderId", payOrderId);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"处理成功", d);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/userCenter.html")
	public ModelAndView userCenter(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		UserWealthQueryResp userWealth = DubboServiceUtil.getUserWealth(userInfo.getUserId());
		boolean hasRight = HyCfgUtil.checkUserHasAuthCertRight(userInfo.getUserId());
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("fansCount", HyUserUtil.getUserFans(userInfo.getUserId()).size());
		request.setAttribute("guanzhuCount", HyUserUtil.getUserGuanzhuUsers(userInfo.getUserId()).size());
		request.setAttribute("hasAuthRight", hasRight);
		request.setAttribute("superUser", HyCfgUtil.checkSuperUser(userInfo.getUserId()));
		request.setAttribute("yiyou", userWealth.getYiyou());
		request.setAttribute("zhuren", userWealth.getZhuren());
		// 是否认证标志
		request.setAttribute("isCert", "0");
		if (userInfo != null) {
			if (UserStatus.AUTHORIZED_SUCCESS.getValue().equals(userInfo.getUserStatus())) {
				request.setAttribute("isCert", "1");
			}
		}
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

		// 获取邀请码
		UserInviteReq req = new UserInviteReq();
		UserInviteInfo userInvite = new UserInviteInfo();
		userInvite.setUserId(userInfo.getUserId());
		userInvite.setStatus(UserInviteStatus.NOT_USE.getValue());
		req.setUserInviteInfo(userInvite);
		List<UserInviteInfo> userInviteList = DubboConsumerFactory.getService(IUserSV.class).queryUserInvite(req);
		String code = "";
		String sign = "";
		String param = "";
		int ncount = 0;
		if (!CollectionUtil.isEmpty(userInviteList)) {
			code = userInviteList.get(0).getInviteCode();
			sign = SignUtil.getUserInviteSign(userInfo.getUserId(), code);
			ncount = userInviteList.size() - 1;
		}
		try {
			JSONObject json = new JSONObject();
			json.put("userId", userInfo.getUserId());
			json.put("inviteCode", code);
			json.put("sign", sign);
			json.put("ncount", ncount);
			param = Java3DESUtil.encryptThreeDESECB(json.toJSONString());
			param = java.net.URLEncoder.encode(param, "utf-8");
		} catch (Exception ex) {
			throw new BusinessException("邀请码加密错误");
		}
		
		UserWealthQueryResp userWealth = DubboServiceUtil.getUserWealth(userInfo.getUserId());
		request.setAttribute("yiyou", userWealth.getYiyou());
		request.setAttribute("zhuren", userWealth.getZhuren());

		request.setAttribute("appId", GlobalSettings.getWeiXinAppId());
		request.setAttribute("timestamp", timestamp);
		request.setAttribute("nonceStr", nonceStr);
		request.setAttribute("signature", signature);
		request.setAttribute("url",
				GlobalSettings.getHarborDomain() + "/user/getUserCardDetail.html?inviteCode=" + param);
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("inviteCode", param);
		request.setAttribute("initcode", code);
		request.setAttribute("ncount", ncount);

		ModelAndView view = new ModelAndView("user/userCard");
		return view;
	}

	@RequestMapping("/getUserCardDetail.html")
	public ModelAndView getUserCardDetail(HttpServletRequest request) {
		// 获取邀请码
		String param = request.getParameter("inviteCode");
		if (StringUtil.isBlank(param)) {
			throw new BusinessException("USER-100001", "您访问的用户名片不存在");
		}
		String userId = "";
		try {
			String jsonparam = Java3DESUtil.decryptThreeDESECB(param);
			JSONObject json = JSONObject.parseObject(jsonparam);
			userId = json.getString("userId");
			request.setAttribute("initcode", json.getString("inviteCode"));
			request.setAttribute("ncount", json.getString("ncount"));
			param = java.net.URLEncoder.encode(param, "utf-8");
		} catch (Exception ex) {
			throw new BusinessException("邀请码解密错误");
		}

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
		
		UserWealthQueryResp userWealth = DubboServiceUtil.getUserWealth(userInfo.getUserId());
		request.setAttribute("yiyou", userWealth.getYiyou());
		request.setAttribute("zhuren", userWealth.getZhuren());

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
				GlobalSettings.getHarborDomain() + "/user/getUserCardDetail.html?inviteCode=" + param);
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("inviteCode", param);

		ModelAndView view = new ModelAndView("user/userCard");
		return view;
	}

	@RequestMapping("/userWealth.html")
	public ModelAndView userWealth(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		UserWealthQueryResp userWealth = DubboServiceUtil.getUserWealth(userInfo.getUserId());
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("userWealth", userWealth);
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
	public ResponseData<JSONObject> getSystemTags(@NotBlank(message = "参数为空") String userId) {
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
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/submitUserSelectedSystemTags")
	@ResponseBody
	public ResponseData<String> submitUserSelectedSystemTags(@NotBlank(message = "参数为空") String submitString) {
		ResponseData<String> responseData = null;
		try {
			UserSystemTagSubmitReq request = JSON.parseObject(submitString, UserSystemTagSubmitReq.class);
			Response rep = DubboConsumerFactory.getService(IUserSV.class).submitUserSelectedSystemTags(request);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"处理成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/getUserTags")
	@ResponseBody
	public ResponseData<JSONObject> getUserTags(@NotBlank(message = "参数为空") String userId) {
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
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/submitUserEdit")
	@ResponseBody
	public ResponseData<String> submitUserEdit(@NotBlank(message = "参数为空") String userData) {
		ResponseData<String> responseData = null;
		try {
			if (StringUtil.isBlank(userData)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户信息为空");
			}
			UserEditReq request = JSON.parseObject(userData, UserEditReq.class);
			Response rep = DubboConsumerFactory.getService(IUserSV.class).userEdit(request);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			} else {
				responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
						"提交成功", "");
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
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"查询成功", arr);
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
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"查询成功", arr);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
		}
		return responseData;
	}

	@RequestMapping("/addGuanzhu")
	@ResponseBody
	public ResponseData<String> addGuanzhu(@NotBlank(message = "关注用户ID为空") String userId, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			if (userInfo.getUserId().equals(userId)) {
				throw new BusinessException("您不可以关注自己哦");
			}
			Set<String> sets = HyUserUtil.getUserFans(userId);
			if (sets.contains(userInfo.getUserId())) {
				throw new BusinessException("您已经关注了这个海友哦");
			}
			// 构造一条粉丝关注的消息
			this.sendAddFansMQ(userInfo.getUserId(), userId);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/cancelGuanzhu")
	@ResponseBody
	public ResponseData<String> cancelGuanzhu(@NotBlank(message = "用户ID为空") String userId, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Set<String> sets = HyUserUtil.getUserGuanzhuUsers(userInfo.getUserId());
			if (!sets.contains(userId)) {
				throw new BusinessException("您没有关注这个海友哦");
			}
			// 构造一条粉丝关注的消息
			this.sendDeleteFansMQ(userInfo.getUserId(), userId);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	/**
	 * 主动申请某人成为自己的好友
	 * 
	 * @param friendUserId
	 * @param applyMq
	 * @param request
	 * @return
	 */
	@RequestMapping("/applyFriend")
	@ResponseBody
	public ResponseData<String> applyFriend(@NotBlank(message = "好友用户ID为空") String friendUserId, String applyMq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			// 判断他的好友申请列表中是否有我
			Set<String> sets = HyUserUtil.getUserFriendApplies(friendUserId);
			if (sets.contains(userInfo.getUserId())) {
				throw new BusinessException("您已经申请成为TA的好友，等待确认");
			}
			// 好友关系是双向的，判断哪个都一样
			sets = HyUserUtil.getUserFriends(userInfo.getUserId());
			if (sets.contains(friendUserId)) {
				throw new BusinessException("TA已经是您的好友哦~");
			}
			this.sendAddFriendMQ(userInfo.getUserId(), friendUserId, applyMq);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/ignorApplyFriend")
	@ResponseBody
	public ResponseData<String> ignorApplyFriend(@NotBlank(message = "好友用户ID为空") String friendUserId,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			this.sendIgnorOrRejectFriendMQ(userInfo.getUserId(), friendUserId);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/agreeApplyFriend")
	@ResponseBody
	public ResponseData<String> agreeApplyFriend(@NotBlank(message = "好友用户ID为空") String friendUserId,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			this.sendAgreeFriendMQ(userInfo.getUserId(), friendUserId);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/getMyFriends")
	@ResponseBody
	public ResponseData<JSONArray> getMyFriends(HttpServletRequest request) {
		ResponseData<JSONArray> responseData = null;
		try {
			Map<String, JSONArray> m = new TreeMap<String, JSONArray>();
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Set<String> set = HyUserUtil.getUserFriends(userInfo.getUserId());
			for (String userId : set) {
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
					d.put("abroadCountryRGB", u.getAbroadCountryRGB());

					char firstChar = Pinyin.getPinyin(u.getEnName()).toUpperCase().charAt(0);
					String fc = String.valueOf(firstChar);
					if (m.containsKey(fc)) {
						m.get(fc).add(d);
					} else {
						JSONArray arr = new JSONArray();
						arr.add(d);
						m.put(fc, arr);
					}

				}
			}
			Map<String, JSONArray> newMap = this.sortByKey(m);
			JSONArray a = new JSONArray();
			for (String key : newMap.keySet()) {
				JSONObject o = new JSONObject();
				o.put("letter", key);
				o.put("friends", m.get(key));
				a.add(o);
			}

			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", a);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
		}
		return responseData;
	}

	@RequestMapping("/getMyFriendsApplies")
	@ResponseBody
	public ResponseData<JSONArray> getMyFriendsApplies(HttpServletRequest request) {
		ResponseData<JSONArray> responseData = null;
		try {
			JSONArray arr = new JSONArray();
			// 获取当前登录的用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Set<String> set = HyUserUtil.getUserFriendApplies(userInfo.getUserId());
			for (String userId : set) {
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
					d.put("abroadCountryRGB", u.getAbroadCountryRGB());
					arr.add(d);
				}
			}
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", arr);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
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
		DoUserFans body = new DoUserFans();
		body.setFansUserId(fansUserId);
		body.setUserId(userId);
		body.setTime(DateUtil.getSysDate());
		body.setHandleType(DoUserFans.HandleType.GUANZHU.name());
		UserInteractionMQSend.sendMQ(body);

	}

	/**
	 * 发送删除粉丝消息
	 * 
	 * @param userId
	 * @param fansUserId
	 */
	private void sendDeleteFansMQ(String userId, String fansUserId) {
		DoUserFans body = new DoUserFans();
		body.setFansUserId(fansUserId);
		body.setUserId(userId);
		body.setTime(DateUtil.getSysDate());
		body.setHandleType(DoUserFans.HandleType.CANCEL.name());
		body.setMqId(UUIDUtil.genId32());
		body.setMqType(MQType.MQ_HY_USER_FANS.getValue());
		UserInteractionMQSend.sendMQ(body);
	}

	/**
	 * 发送一条加好友消息
	 * 
	 * @param userId
	 * @param friendUserId
	 */
	private void sendAddFriendMQ(String userId, String friendUserId, String applyMq) {
		DoUserFriend body = new DoUserFriend();
		body.setFriendUserId(friendUserId);
		body.setUserId(userId);
		body.setTime(DateUtil.getSysDate());
		body.setHandleType(DoUserFriend.HandleType.APPLY.name());
		body.setMqId(UUIDUtil.genId32());
		body.setMqType(MQType.MQ_HY_USER_FRIEND.getValue());
		body.setApplyMq(applyMq);
		UserInteractionMQSend.sendMQ(body);
	}

	/**
	 * 发送一条拒绝或忽略好友申请消息
	 * 
	 * @param userId
	 * @param friendUserId
	 */
	private void sendIgnorOrRejectFriendMQ(String userId, String friendUserId) {
		DoUserFriend body = new DoUserFriend();
		body.setFriendUserId(friendUserId);
		body.setUserId(userId);
		body.setTime(DateUtil.getSysDate());
		body.setHandleType(DoUserFriend.HandleType.REJECT.name());
		body.setMqId(UUIDUtil.genId32());
		body.setMqType(MQType.MQ_HY_USER_FRIEND.getValue());
		UserInteractionMQSend.sendMQ(body);
	}

	/**
	 * 发送一条同意好友申请消息
	 * 
	 * @param userId
	 * @param friendUserId
	 */
	private void sendAgreeFriendMQ(String userId, String friendUserId) {
		DoUserFriend body = new DoUserFriend();
		body.setFriendUserId(friendUserId);
		body.setUserId(userId);
		body.setTime(DateUtil.getSysDate());
		body.setHandleType(DoUserFriend.HandleType.AGREE.name());
		body.setMqId(UUIDUtil.genId32());
		body.setMqType(MQType.MQ_HY_USER_FRIEND.getValue());
		UserInteractionMQSend.sendMQ(body);
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

	private Map<String, JSONArray> sortByKey(Map<String, JSONArray> m) {
		Map<String, JSONArray> sortMap = new TreeMap<String, JSONArray>(new MapKeyComparator());
		sortMap.putAll(m);
		return sortMap;
	}

	class MapKeyComparator implements Comparator<String> {
		@Override
		public int compare(String key1, String key2) {
			return key1.compareTo(key2);
		}
	}

	@RequestMapping("/listenerUserNotify")
	public @ResponseBody String listenerUserNotify(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/event-stream; charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			LOG.error(e.getMessage());
		}
		int notifyCount = 0;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			notifyCount = HyNotifyUtil.getUnReadNotifyCount(userInfo.getUserId());
		} catch (Exception ex) {

		}
		return "data:" + notifyCount + "\n\n";
	}

	@RequestMapping("/saveData")
	public ResponseData<String> saveData(HttpServletRequest request, HttpServletResponse response) {
		ResponseData<String> responseData = null;
		String param = request.getParameter("param");
		/** 存入数据 **/
		ICacheClient cacheClient = CacheFactory.getClient();

		cacheClient.set("test_lisener", param);
		responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", "");
		return responseData;
	}

	@RequestMapping("/createHaibeiPayOrder")
	@ResponseBody
	public ResponseData<JSONObject> createHaibeiPayOrder(HttpServletRequest request) {
		ResponseData<JSONObject> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			String count = request.getParameter("count");
			String price = request.getParameter("price");
			String nonceStr = request.getParameter("nonceStr");
			String timeStamp = request.getParameter("timeStamp");
			if (StringUtil.isBlank(count)) {
				throw new BusinessException("购买数量为空");
			}
			if (StringUtil.isBlank(price)) {
				throw new BusinessException("购买价格为空");
			}
			if (StringUtil.isBlank(nonceStr)) {
				throw new BusinessException("随机串为空");
			}
			if (StringUtil.isBlank(timeStamp)) {
				throw new BusinessException("时间戳为空");
			}
			String summary = "购买海贝" + count + "个";
			// 调用服务生成支付流水
			CreateUserBuyHBOrderReq createPaymentOrderReq = new CreateUserBuyHBOrderReq();
			createPaymentOrderReq.setPayAmount(Long.parseLong(price));
			createPaymentOrderReq.setPayType(PayType.WEIXIN.getValue());
			createPaymentOrderReq.setSummary(summary);
			createPaymentOrderReq.setUserId(userInfo.getUserId());
			createPaymentOrderReq.setBuyAmount(Integer.parseInt(count));
			createPaymentOrderReq.setFromSign(nonceStr);
			CreateUserBuyHBOrderResp resp = DubboConsumerFactory.getService(IUserSV.class)
					.createUserBuyHB(createPaymentOrderReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			// 组织支付认证信息
			String payOrderId = resp.getPayOrderId();
			String host = "192.168.1.1";
			String pkg = WXHelpUtil.getPackageOfWXJSSDKChoosePayAPI(summary, payOrderId, Integer.parseInt(price), host,
					userInfo.getWxOpenid(), GlobalSettings.getHarborWXPayNotifyURL(), nonceStr);
			String paySign = WXHelpUtil.getPaySignOfWXJSSDKChoosePayAPI(timeStamp, nonceStr, pkg);

			JSONObject d = new JSONObject();
			d.put("package", pkg);
			d.put("paySign", paySign);
			d.put("payOrderId", payOrderId);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"处理成功", d);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/unauthusers.html")
	public ModelAndView unauthusers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		boolean hasRight = HyCfgUtil.checkUserHasAuthCertRight(userInfo.getUserId());
		if (!hasRight) {
			throw new BusinessException("您没有审核权限哦");
		}
		ModelAndView view = new ModelAndView("user/unauthusers");
		return view;
	}

	@RequestMapping("/queryUnAuthUsers")
	public @ResponseBody ResponseData<List<UserViewInfo>> queryUnAuthUsers(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LOG.info("进入查询未认证用户表");
		ResponseData<List<UserViewInfo>> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean hasRight = HyCfgUtil.checkUserHasAuthCertRight(userInfo.getUserId());
			if (!hasRight) {
				throw new BusinessException("您无权查看未认证用户列表");
			}
			List<UserViewInfo> userViewInfos = DubboConsumerFactory.getService(IUserSV.class).queryUnAuthUsers();
			responseData = new ResponseData<List<UserViewInfo>>(ResponseData.AJAX_STATUS_SUCCESS,
					ExceptCodeConstants.SUCCESS, "查询成功", userViewInfos);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<List<UserViewInfo>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/toCertficate.html")
	public ModelAndView toCertficate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserViewInfo loginUser = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		boolean hasRight = HyCfgUtil.checkUserHasAuthCertRight(loginUser.getUserId());
		if (!hasRight) {
			throw new BusinessException("您无权查看未认证用户资料信息");
		}
		String userId = request.getParameter("userId");
		UserViewResp resp = DubboConsumerFactory.getService(IUserSV.class).queryUserViewByUserId(userId);
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(resp.getResponseHeader().getResultCode(),
					resp.getResponseHeader().getResultMessage());
		}
		UserViewInfo userInfo = resp.getUserInfo();
		if (userInfo == null) {
			throw new BusinessException("待审核用户不存在");
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
		ModelAndView view = new ModelAndView("user/certficate");
		return view;
	}

	/**
	 * 提交审核认证
	 * 
	 * @param req
	 * @return
	 */
	@RequestMapping("/submitUserAuthInfo")
	@ResponseBody
	public ResponseData<String> submitUserAuthInfo(@NotNull(message = "参数为空") UserAuthReq req,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo loginUser = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean hasRight = HyCfgUtil.checkUserHasAuthCertRight(loginUser.getUserId());
			if (!hasRight) {
				throw new BusinessException("您无权认证此用户");
			}
			Response rep = DubboConsumerFactory.getService(IUserSV.class).submitUserAuthInfo(req);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"审核成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/toUserInviteCode.html")
	public ModelAndView toUserInviteCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserViewInfo userInfo = WXUserUtil.getUserViewInfoByWXAuth(request);
		request.setAttribute("islogin", userInfo != null);
		ModelAndView view = new ModelAndView("user/inviteRegisterCode");
		return view;
	}

	@RequestMapping("/checkUserInviteCode")
	@ResponseBody
	public ResponseData<String> checkUserInviteCode(HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			String inviteCode = request.getParameter("inviteCode");
			if (StringUtil.isBlank(inviteCode)) {
				throw new BusinessException("请输入您的邀请码");
			}
			UserInviteReq req = new UserInviteReq();
			UserInviteInfo userInvite = new UserInviteInfo();
			userInvite.setStatus(UserInviteStatus.NOT_USE.getValue());
			userInvite.setInviteCode(inviteCode);
			req.setUserInviteInfo(userInvite);
			List<UserInviteInfo> rep = DubboConsumerFactory.getService(IUserSV.class).queryUserInvite(req);
			if (CollectionUtil.isEmpty(rep)) {
				throw new BusinessException("邀请码不正确或已经被使用");
			}

			String sign = SignUtil.getUserInviteSign("", inviteCode);
			JSONObject json = new JSONObject();
			json.put("userId", "");
			json.put("inviteCode", inviteCode);
			json.put("sign", sign);
			String descparam = Java3DESUtil.encryptThreeDESECB(json.toJSONString());
			descparam = java.net.URLEncoder.encode(descparam);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"邀请码校验成功", descparam);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

}
