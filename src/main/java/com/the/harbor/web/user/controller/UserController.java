package com.the.harbor.web.user.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;
import com.the.harbor.web.weixin.param.WeixinUserInfo;

@RestController
@RequestMapping("/user")
public class UserController {

	private static final Logger LOG = Logger.getLogger(UserController.class);

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
		} else {
			// 如果传入了code，则可能是授权过的，获取access_token
			WeixinOauth2Token wtoken = WXRequestUtil.refreshAccessToken(code);
			if (wtoken == null) {
				// 如果获取不到access_token,说明是非法入侵的，重定向到微信授权
				LOG.error("获取token失败，可能是认证失效或者token是侵入的");
				response.sendRedirect(authorURL);
			} else {
				// 如果可以获取到，则获取用户信息
				WeixinUserInfo wxUserInfo = WXRequestUtil.getWxUserInfo(wtoken.getAccessToken(), wtoken.getOpenId());
				if (wxUserInfo == null) {
					response.sendRedirect(authorURL);
				} else {
					request.setAttribute("userInfo", wxUserInfo);
					ModelAndView view = new ModelAndView("user/toUserRegister");
					return view;
				}
			}
		}
		return null;

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
