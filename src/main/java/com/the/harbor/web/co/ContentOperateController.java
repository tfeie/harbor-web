package com.the.harbor.web.co;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotNull;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.the.harbor.api.be.IBeSV;
import com.the.harbor.api.be.param.HideBeReq;
import com.the.harbor.api.be.param.TopBeReq;
import com.the.harbor.api.go.IGoSV;
import com.the.harbor.api.go.param.HideGoReq;
import com.the.harbor.api.go.param.TopGoReq;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.util.HyCfgUtil;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.system.utils.WXUserUtil;

@RestController
@RequestMapping("/co")
public class ContentOperateController {

	private static final Logger LOG = Logger.getLogger(ContentOperateController.class);

	@RequestMapping("/bemain.html")
	public ModelAndView bemain(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.getUserViewInfoByWXAuth(request);
		boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
		if (!superUser) {
			throw new BusinessException("您无权进入");
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
		request.setAttribute("url", GlobalSettings.getHarborDomain() + "/co/bemain.html");
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("co/bemain");
		return view;
	}

	@RequestMapping("/gomain.html")
	public ModelAndView gooperateIndex(HttpServletRequest request) {
		String goType = request.getParameter("goType");
		if (StringUtil.isBlank(goType)) {
			goType = "group";
		}
		request.setAttribute("goType", goType);

		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
		if (!superUser) {
			throw new BusinessException("您无权进入");
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
		request.setAttribute("url", GlobalSettings.getHarborDomain() + "/co/gomain.html");
		request.setAttribute("userInfo", userInfo);

		ModelAndView view = new ModelAndView("co/gomain");
		return view;
	}

	@RequestMapping("/topBe")
	@ResponseBody
	public ResponseData<String> topBe(@NotNull(message = "参数为空") TopBeReq topBeReq, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
			if (!superUser) {
				throw new BusinessException("您无权置顶");
			}
			topBeReq.setTop(true);
			Response resp = DubboConsumerFactory.getService(IBeSV.class).topBe(topBeReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
					resp.getResponseHeader().getResultCode(), "置顶成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/cancelTopBe")
	@ResponseBody
	public ResponseData<String> cancelTopBe(@NotNull(message = "参数为空") TopBeReq topBeReq, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
			if (!superUser) {
				throw new BusinessException("您无权取消置顶");
			}
			topBeReq.setTop(false);
			Response resp = DubboConsumerFactory.getService(IBeSV.class).topBe(topBeReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
					resp.getResponseHeader().getResultCode(), "取消置顶成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/cancelHideBe")
	@ResponseBody
	public ResponseData<String> cancelHideBe(@NotNull(message = "参数为空") HideBeReq hideBeReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
			if (!superUser) {
				throw new BusinessException("您无权取消隐藏");
			}
			hideBeReq.setHide(false);
			Response resp = DubboConsumerFactory.getService(IBeSV.class).hideBe(hideBeReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
					resp.getResponseHeader().getResultCode(), "取消隐藏成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/hideBe")
	@ResponseBody
	public ResponseData<String> hideBe(@NotNull(message = "参数为空") HideBeReq hideBeReq, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
			if (!superUser) {
				throw new BusinessException("您无权取消隐藏");
			}
			hideBeReq.setHide(true);
			Response resp = DubboConsumerFactory.getService(IBeSV.class).hideBe(hideBeReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
					resp.getResponseHeader().getResultCode(), "取消隐藏成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/topGo")
	@ResponseBody
	public ResponseData<String> topGo(@NotNull(message = "参数为空") TopGoReq topGoReq, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
			if (!superUser) {
				throw new BusinessException("您无权置顶");
			}
			topGoReq.setTop(true);
			Response resp = DubboConsumerFactory.getService(IGoSV.class).topGo(topGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
					resp.getResponseHeader().getResultCode(), "置顶成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/cancelTopGo")
	@ResponseBody
	public ResponseData<String> cancelTopGo(@NotNull(message = "参数为空") TopGoReq topGoReq, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
			if (!superUser) {
				throw new BusinessException("您无权取消置顶");
			}
			topGoReq.setTop(false);
			Response resp = DubboConsumerFactory.getService(IGoSV.class).topGo(topGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
					resp.getResponseHeader().getResultCode(), "取消置顶成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/cancelHideGo")
	@ResponseBody
	public ResponseData<String> cancelHideGo(@NotNull(message = "参数为空") HideGoReq hideGoReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
			if (!superUser) {
				throw new BusinessException("您无权取消隐藏");
			}
			hideGoReq.setHide(false);
			Response resp = DubboConsumerFactory.getService(IGoSV.class).hideGo(hideGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
					resp.getResponseHeader().getResultCode(), "取消隐藏成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/hideGo")
	@ResponseBody
	public ResponseData<String> hideGo(@NotNull(message = "参数为空") HideGoReq hideGoReq, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			boolean superUser = HyCfgUtil.checkSuperUser(userInfo.getUserId());
			if (!superUser) {
				throw new BusinessException("您无权取消隐藏");
			}
			hideGoReq.setHide(true);
			Response resp = DubboConsumerFactory.getService(IGoSV.class).hideGo(hideGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
					resp.getResponseHeader().getResultCode(), "取消隐藏成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

}
