package com.the.harbor.web.user.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.commons.components.aliyuncs.sms.SMSSender;
import com.the.harbor.commons.components.aliyuncs.sms.param.SMSSendRequest;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.redisdata.util.SMSRandomCodeUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;
import com.the.harbor.web.weixin.param.WeixinUserInfo;

@RestController
@RequestMapping("/user")
public class UserController {

	private static final Logger LOG = Logger.getLogger(UserController.class);

	@RequestMapping("/toUserRegisterTest.html")
	public ModelAndView toUserRegisterTest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView view = new ModelAndView("user/toUserRegister");
		return view;
	}

	@RequestMapping("/toUserRegister.html")
	public ModelAndView toUserRegister(HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOG.debug("用户注册授权==========开始===========");
		String redirectURL = URLEncoder.encode(GlobalSettings.getHarborDomain() + "/user/toUserRegister.html", "utf-8");
		String authorURL = GlobalSettings.getWeiXinConnectAuthorizeAPI() + "?appid=" + GlobalSettings.getWeiXinAppId()
				+ "&response_type=code&scope=snsapi_userinfo&state=haigui&redirect_uri=" + redirectURL
				+ "#wechat_redirect";

		String code = request.getParameter("code");
		if (StringUtil.isBlank(code)) {
			// 如果没有，则说明没有经过授权，进行授权
			response.sendRedirect(authorURL);
			return null;
			// request.setAttribute("authorURL", authorURL);
		} else {
			// 如果传入了code，则可能是授权过的，获取access_token
			WeixinOauth2Token wtoken = WXRequestUtil.refreshAccessToken(code);
			if (wtoken == null) {
				// 如果获取不到access_token,说明是非法入侵的，重定向到微信授权
				LOG.error("获取token失败，可能是认证失效或者token是侵入的");
				// request.setAttribute("authorURL", authorURL);
				response.sendRedirect(authorURL);
				return null;
			} else {
				// 如果可以获取到，则获取用户信息
				WeixinUserInfo wxUserInfo = WXRequestUtil.getWxUserInfo(wtoken.getAccessToken(), wtoken.getOpenId());
				if (wxUserInfo == null) {
					// request.setAttribute("authorURL", authorURL);
					response.sendRedirect(authorURL);
					return null;
				} else {
					request.setAttribute("userInfo", wxUserInfo);
					ModelAndView view = new ModelAndView("user/toUserRegister");
					return view;
				}
			}
		}

	}

	@RequestMapping("/getRandomCode")
	public ResponseData<String> getRandomCode(String phoneNumber) {
		ResponseData<String> responseData = null;
		try {
			if (StringUtil.isBlank(phoneNumber)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "请输入您的手机号码");
			}
			String randomCode = SMSRandomCodeUtil.getSmsRandomCode(phoneNumber);
			if (!StringUtil.isBlank(randomCode)) {
				throw new BusinessException("SMS-10000", "验证码已经发送，一分钟内不要重复获取");
			}
			// 生成随机验证码，并且存入到缓存中
			//randomCode = SMSRandomCodeUtil.createRandomCode();
			/* 调用API发送短信 */
			/*SMSSendRequest req = new SMSSendRequest();
			List<String> recNumbers = new ArrayList<String>();
			recNumbers.add(phoneNumber);
			JSONObject smsParams = new JSONObject();
			smsParams.put("randomCode", randomCode);
			req.setRecNumbers(recNumbers);
			req.setSmsFreeSignName(GlobalSettings.getSMSFreeSignName());
			req.setSmsParams(smsParams);
			req.setSmsTemplateCode(GlobalSettings.getSMSUserRandomCodeTemplate());
			SMSSender.send(req);
			SMSRandomCodeUtil.setSmsRandomCode(phoneNumber, randomCode);*/
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "验证码发送成功", randomCode);
		} catch (BusinessException e) {
			LOG.error(e);
			e.printStackTrace();
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, e.getMessage());
		} catch (Exception e) {
			LOG.error(e);
			e.printStackTrace();
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}
	
	public static void main(String[] agrs){
		System.out.println(GlobalSettings.getSMSUserRandomCodeTemplate());
	}

	@RequestMapping("/toRegister")
	public ModelAndView toRegister(HttpServletRequest request) {
		String code = request.getParameter("code");
		request.setAttribute("userInfo1", null);
		WeixinOauth2Token wtoken = WXRequestUtil.refreshAccessToken(code);
		if (wtoken == null) {
			LOG.error("获取token失败");
			ModelAndView view = new ModelAndView("user/toUserRegister");
			return view;
		}
		LOG.info("注册openid=" + JSONObject.toJSONString(wtoken));
		WeixinUserInfo wxUserInfo = WXRequestUtil.getWxUserInfo(wtoken.getAccessToken(), wtoken.getOpenId());
		if (wxUserInfo == null) {
			LOG.error("获取微信用户信息失败");
			ModelAndView view = new ModelAndView("user/toUserRegister");
			return view;
		}
		request.setAttribute("userInfo", wxUserInfo);
		LOG.info("微信用户信息：" + JSONObject.toJSONString(wxUserInfo));
		request.setAttribute("userInfo2", new WeixinUserInfo());

		ModelAndView view = new ModelAndView("user/toUserRegister");
		return view;
	}

	@RequestMapping("/toApplyCertficate.html")
	public ModelAndView toApplyCertficate(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/toApplyCertficate");
		return view;
	}

	@RequestMapping("/userInfo.html")
	public ModelAndView userInfo(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/userInfo");
		return view;
	}

	@RequestMapping("/memberCenter.html")
	public ModelAndView memberCenter(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/memberCenter");
		return view;
	}

	@RequestMapping("/userCenter.html")
	public ModelAndView userCenter(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/userCenter");
		return view;
	}

	@RequestMapping("/editUserInfo.html")
	public ModelAndView editUserInfo(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/editUserInfo");
		return view;
	}

	@RequestMapping("/getUserCard.html")
	public ModelAndView getUserCard(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/userCard");
		return view;
	}

	@RequestMapping("/userWealth.html")
	public ModelAndView userWealth(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/userWealth");
		return view;
	}

	@RequestMapping("/setUserSkills.html")
	public ModelAndView setUserSkills(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("user/setUserSkills");
		return view;
	}

}
