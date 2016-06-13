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
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;

public class WXAuthFilter extends OncePerRequestFilter {

	private static final Logger LOG = LoggerFactory.getLogger(WXAuthFilter.class);

	public static String[] IGNORE = {};

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		LOG.info("开始执行微信认证拦截器...");
		String[] notFilter = new String[] { "/images", "/js", "/css", "/login/tologin", "/login/mainframe",
				"/user/pages", "/user/checkPassword", "/signcode" };
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String actionURL = uri.substring(contextPath.length());
		boolean doFilter = true;
		for (String s : notFilter) {
			if (uri.indexOf(s) != -1) {
				doFilter = false;
				break;
			}
		}

		if (doFilter && !isAjaxRequest(request)) {
			LOG.debug("当前请求的地址需要处理");
			String redirectURL = URLEncoder.encode(GlobalSettings.getHarborDomain() + actionURL, "utf-8");
			String authorURL = GlobalSettings.getWeiXinConnectAuthorizeAPI() + "?appid="
					+ GlobalSettings.getWeiXinAppId()
					+ "&response_type=code&scope=snsapi_userinfo&state=haigui&redirect_uri=" + redirectURL
					+ "#wechat_redirect";
			/* 1.获取地址中传递的微信用户网页授权CODE */
			String code = request.getParameter("code");
			/* 2.根据是否有网页授权码来处理 */
			if (StringUtil.isBlank(code)) {
				LOG.debug("没有从请求地址中获取授权CODE，执行重定向授权");
				/* 2.1 如果没有传入网页授权CODE，则表示没有经过网页授权，需要跳转到授权页面 */
				response.sendRedirect(authorURL);
				return;
			} else {
				LOG.debug("根据传入的CODE=" + code + "获取access_token和openId");
				/*
				 * 2.2
				 * 如果传入了code，则根据code获取特殊的网页授权access_code。如果不能获取，则表示CODE不正确或者已经过期
				 */
				WeixinOauth2Token wtoken = WXRequestUtil.refreshAccessToken(code);
				if (wtoken == null) {
					LOG.debug("根据传入的CODE=" + code + "没有获取access_token和openId，执行重定向授权");
					response.sendRedirect(authorURL);
					return;
				}
				request.setAttribute("wtoken", wtoken);
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

	public static void main(String[] agrs) {
		String url = "/harbor-web/be/index.html";
		String contextPath = "/harbor-web";
		if (url.startsWith(contextPath)) {
			url.substring(contextPath.length() - 1);
		}
		System.out.println(url.substring(contextPath.length()));

	}

}
