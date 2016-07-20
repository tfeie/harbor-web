package com.the.harbor.web.system.filter;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.filter.OncePerRequestFilter;

import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.web.constants.WXConstants;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;

public class WXAuthFilter extends OncePerRequestFilter {

	private static final Logger LOG = LoggerFactory.getLogger(WXAuthFilter.class);

	public static String[] IGNORE = {};

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		LOG.info("开始判测请求是否要进行微信网页授权认证...");
		String[] shouldFilter = new String[] { "/user/toUserRegister.html", "/user/toApplyCertficate.html",
				"/user/editUserInfo.html", "/user/previewUserInfo.html", "/user/memberCenter.html",
				"/user/messagecenter.html", "/user/userCenter.html", "/user/setUserSkills.html",
				"/user/getUserCard.html", "/user/userWealth.html", "/user/myhaiyou.html", "/user/myfans.html",
				"/user/buyhaibei.html", "/user/myguanzhu.html", "/go/publishGo.html", "/go/toOrder.html",
				"/go/toPay.html", "/go/toConfirm.html", "/go/mygroup.html", "/go/myono.html", "/go/comments.html",
				"/go/goindex.html", "/go/invite.html", "/go/toFeedback.html", "/go/toHainiuFeedback.html",
				"/go/confirmlist.html", "/go/toHainiuAppointment.html", "/go/toAppointment.html",
				"/go/myjointgoes.html", "/go/toHainiuConfirm.html", "/be/publishbe.html", "/be/mybe.html",
				"/be/mytimeline.html", "/be/index.html" };
		String uri = request.getRequestURI();
		boolean doFilter = false;
		for (String s : shouldFilter) {
			if (uri.indexOf(s) != -1) {
				doFilter = true;
				break;
			}
		}
		//initSession(request);

		if (doFilter) {
			LOG.info("当前地址在需要认证的地址列表中，需要进行认证。开始判断session是否有会话信息");
			// 判断会话中，是否有已经获取的openId
			if (request.getSession().getAttribute(WXConstants.SESSION_WX_WEB_AUTH) == null) {
				/* 1.如果会话中没有OPEN_ID，则需要进行授权认证 */
				LOG.info("当前请求会话中没有已经认证过的信息，进行微信网页授权认证");
				String fullUrl = WXRequestUtil.getFullURL(request);
				String redirectURL = "";
				int index = fullUrl.indexOf("?");
				if(index != -1){
					String beforUrl = fullUrl.substring(0, index);
					String param = uri.substring(index+1);
					redirectURL = URLEncoder.encode(beforUrl, "utf-8");
				} else {
					redirectURL = fullUrl;
				}
				String authorURL = GlobalSettings.getWeiXinConnectAuthorizeAPI() + "?appid="
						+ GlobalSettings.getWeiXinAppId()
						+ "&response_type=code&scope=snsapi_userinfo&state=haigui&redirect_uri=" + redirectURL
						+ "#wechat_redirect";
				/* 1.获取地址中传递的微信用户网页授权CODE */
				String code = request.getParameter("code");
				/* 2.根据是否有网页授权码来处理 */
				if (StringUtil.isBlank(code)) {
					LOG.info("没有从请求地址中获取授权CODE，执行重定向授权");
					/* 2.1 如果没有传入网页授权CODE，则表示没有经过网页授权，需要跳转到授权页面 */
					response.sendRedirect(authorURL);
					return;
				} else {
					LOG.info("根据传入的CODE=" + code + "获取access_token和openId");
					/*
					 * 2.2 如果传入了code，则根据code获取特殊的网页授权access_code。如果不能获取，
					 * 则表示CODE不正确或者已经过期
					 */
					WeixinOauth2Token wtoken = WXRequestUtil.refreshAccessToken(code);
					if (wtoken == null) {
						LOG.info("根据传入的CODE=" + code + "没有获取access_token和openId，执行重定向授权");
						response.sendRedirect(authorURL);
						return;
					}
					request.getSession().setAttribute(WXConstants.SESSION_WX_WEB_AUTH, wtoken);
				}
			}
			filterChain.doFilter(request, response);
		} else {
			filterChain.doFilter(request, response);
		}

	}

	public static boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("X-Requested-With");
		if (header != null && "XMLHttpRequest".equals(header))
			return true;
		else
			return false;
	}

	public static void initSession(HttpServletRequest request) {
		WeixinOauth2Token wtoken = new WeixinOauth2Token();
		// wtoken.setOpenId("oztCUs2X5d-j0Ykczx0eUXJmlzcA");
		wtoken.setOpenId("oztCUs_Ci25lT7IEMeDLtbK6nr1M");
		request.getSession().setAttribute(WXConstants.SESSION_WX_WEB_AUTH, wtoken);
	}

}
