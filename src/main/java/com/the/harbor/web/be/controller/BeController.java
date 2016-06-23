package com.the.harbor.web.be.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.the.harbor.api.be.IBeSV;
import com.the.harbor.api.be.param.Be;
import com.the.harbor.api.be.param.BeCreateReq;
import com.the.harbor.api.be.param.BeCreateResp;
import com.the.harbor.api.be.param.BeDetail;
import com.the.harbor.api.be.param.QueryMyBeReq;
import com.the.harbor.api.be.param.QueryMyBeResp;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.enumeration.hybe.BeDetailType;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.vo.PageInfo;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
import com.the.harbor.commons.util.CollectionUtil;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.go.controller.GoController;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.system.utils.WXUserUtil;
import com.the.harbor.web.util.DubboServiceUtil;

@RestController
@RequestMapping("/be")
public class BeController {

	private static final Logger LOG = Logger.getLogger(GoController.class);

	@RequestMapping("/index.html")
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("be/index");
		return view;
	}

	@RequestMapping("/detail.html")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("be/detail");
		return view;
	}

	@RequestMapping("/publishbe.html")
	public ModelAndView publishbe(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.getUserViewInfoByWXAuth(request);
		if (userInfo == null) {
			throw new BusinessException("您的微信还没注册成湾民,请先注册", true, "../user/toUserRegister.html");
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
		ModelAndView view = new ModelAndView("be/publishbe");
		return view;
	}

	@RequestMapping("/mybe.html")
	public ModelAndView mybe(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.getUserViewInfoByWXAuth(request);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("be/mybe");
		return view;
	}

	@RequestMapping("/mytimeline.html")
	public ModelAndView mytimeline(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.getUserViewInfoByWXAuth(request);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("be/mytimeline");
		return view;
	}

	@RequestMapping("/getBeSystemTags")
	@ResponseBody
	public ResponseData<JSONObject> getBeSystemTags() {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		try {
			List<HyTagVo> allBeTags = HyTagUtil.getAllBeTags();
			data.put("allBeTags", allBeTags);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, "获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/uploadBeImgToOSS")
	public ResponseData<String> uploadBeImgToOSS(HttpServletRequest request) {
		ResponseData<String> responseData = null;
		String mediaId = request.getParameter("mediaId");
		String userId = request.getParameter("userId");
		try {
			if (StringUtil.isBlank(userId)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "用户标识不存在");
			}
			String fileName = WXHelpUtil.uploadBeImgToOSS(mediaId, userId);
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName + "@!pipe1";
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "上传到OSS成功", fileURL);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/submitNewBe")
	@ResponseBody
	public ResponseData<String> submitNewBe(String beData) {
		ResponseData<String> responseData = null;
		try {
			if (StringUtil.isBlank(beData)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "B&E信息为空");
			}
			BeCreateReq request = JSON.parseObject(beData, BeCreateReq.class);
			BeCreateResp rep = DubboConsumerFactory.getService(IBeSV.class).createBe(request);
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

	@RequestMapping("/getMyBes")
	@ResponseBody
	public ResponseData<JSONObject> getMyBes(QueryMyBeReq queryMyBeReq) {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		JSONArray arr = new JSONArray();
		try {
			// 获取用户资料
			UserViewInfo userInfo = DubboServiceUtil.queryUserViewInfoByUserId(queryMyBeReq.getUserId());
			if (userInfo == null) {
				throw new BusinessException("非法查询:缺少用户信息");
			}
			QueryMyBeResp resp = DubboConsumerFactory.getService(IBeSV.class).queryMyBe(queryMyBeReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_FAILURE,
						resp.getResponseHeader().getResultMessage());
			} else {
				PageInfo<Be> pagInfo = resp.getPagInfo();
				if (!CollectionUtil.isEmpty(pagInfo.getResult())) {
					for (Be be : pagInfo.getResult()) {
						JSONObject d = new JSONObject();
						// 获取第一个文本内容
						BeDetail firstTextDetail = null;
						BeDetail firstImgDetail = null;
						if (!CollectionUtil.isEmpty(be.getBeDetails())) {
							for (BeDetail detail : be.getBeDetails()) {
								if (BeDetailType.TEXT.getValue().equals(detail.getType())) {
									if (firstTextDetail == null)
										firstTextDetail = detail;
								} else if (BeDetailType.IMAGE.getValue().equals(detail.getType())) {
									if (firstImgDetail == null)
										firstImgDetail = detail;
								}
							}
						}
						// 获取标签
						d.put("publishdate", DateUtil.getInterval(be.getCreateDate()));
						d.put("tags", be.getBeTags());
						d.put("hastext", !(firstTextDetail == null));
						d.put("hasimg", !(firstImgDetail == null));
						d.put("firstTextDetail", firstTextDetail);
						d.put("firstImgDetail", firstImgDetail);
						arr.add(d);
					}
				}
				data.put("userInfo", userInfo);
				data.put("belist", arr);
				responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功", data);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/getMyTimeLine")
	@ResponseBody
	public ResponseData<JSONObject> getMyTimeLine(QueryMyBeReq queryMyBeReq) {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		JSONArray arr = new JSONArray();
		try {
			// 获取用户资料
			UserViewInfo userInfo = DubboServiceUtil.queryUserViewInfoByUserId(queryMyBeReq.getUserId());
			if (userInfo == null) {
				throw new BusinessException("非法查询:缺少用户信息");
			}
			QueryMyBeResp resp = DubboConsumerFactory.getService(IBeSV.class).queryMyBe(queryMyBeReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_FAILURE,
						resp.getResponseHeader().getResultMessage());
			} else {
				Map<String, String> dayMap = new HashMap<String, String>();
				PageInfo<Be> pagInfo = resp.getPagInfo();
				if (!CollectionUtil.isEmpty(pagInfo.getResult())) {
					for (Be be : pagInfo.getResult()) {
						JSONObject d = new JSONObject();
						// 获取第一个文本内容
						BeDetail firstTextDetail = null;
						BeDetail firstImgDetail = null;
						if (!CollectionUtil.isEmpty(be.getBeDetails())) {
							for (BeDetail detail : be.getBeDetails()) {
								if (BeDetailType.TEXT.getValue().equals(detail.getType())) {
									if (firstTextDetail == null)
										firstTextDetail = detail;
								} else if (BeDetailType.IMAGE.getValue().equals(detail.getType())) {
									if (firstImgDetail == null)
										firstImgDetail = detail;
								}
							}
						}
						//获取创建日期,标记是否显示时间线日期
						boolean showtime = false;
						String t = DateUtil.getDateString(DateUtil.YYYYMMDD);
						if(!dayMap.containsKey(t)){
							showtime = true;
							dayMap.put(t, t);
						}
						// 获取标签
						long days = DateUtil.getTimeDifference(DateUtil.getTheDayFirstSecond(DateUtil.getSysDate()), be.getCreateDate());
						String publishDay = "";
						if (days == 0) {
							publishDay = "今天";
						} else if (days == 1) {
							publishDay = "昨天";
						} else {
							int day = DateUtil.getDay(be.getCreateDate());
							int month = DateUtil.getMonth(be.getCreateDate());
							publishDay = day + "/<font>" + month + "月</font>";
						}
						d.put("showtime", showtime);
						d.put("publishDay", publishDay);
						d.put("hastext", !(firstTextDetail == null));
						d.put("hasimg", !(firstImgDetail == null));
						d.put("firstTextDetail", firstTextDetail);
						d.put("firstImgDetail", firstImgDetail);
						arr.add(d);
					}
				}
				data.put("belist", arr);
				responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功", data);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

}
