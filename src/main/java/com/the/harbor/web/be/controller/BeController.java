package com.the.harbor.web.be.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.beans.BeanUtils;
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
import com.the.harbor.api.be.IBeSV;
import com.the.harbor.api.be.param.Be;
import com.the.harbor.api.be.param.BeComment;
import com.the.harbor.api.be.param.BeCreateReq;
import com.the.harbor.api.be.param.BeCreateResp;
import com.the.harbor.api.be.param.BeDetail;
import com.the.harbor.api.be.param.DoBeComment;
import com.the.harbor.api.be.param.DoBeLikes;
import com.the.harbor.api.be.param.DoBeLikes.HandleType;
import com.the.harbor.api.be.param.QueryMyBeReq;
import com.the.harbor.api.be.param.QueryMyBeResp;
import com.the.harbor.api.be.param.QueryOneBeReq;
import com.the.harbor.api.be.param.QueryOneBeResp;
import com.the.harbor.api.user.param.UserInfo;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.enumeration.hybe.BeDetailType;
import com.the.harbor.base.enumeration.mns.MQType;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.vo.PageInfo;
import com.the.harbor.commons.components.aliyuncs.mns.MNSFactory;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyBeUtil;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
import com.the.harbor.commons.util.CollectionUtil;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.util.UUIDUtil;
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
		String beId = request.getParameter("beId");
		if (StringUtil.isBlank(beId)) {
			throw new BusinessException("B&E标识不存在");
		}
		QueryOneBeReq queryOneBeReq = new QueryOneBeReq();
		queryOneBeReq.setBeId(beId);
		QueryOneBeResp resp = DubboConsumerFactory.getService(IBeSV.class).queryOneBe(queryOneBeReq);
		if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
			throw new BusinessException(ResponseData.AJAX_STATUS_FAILURE, resp.getResponseHeader().getResultMessage());
		}
		Be be = resp.getBe();
		if (be == null) {
			throw new BusinessException("查看的B&E不存在");
		}
		UserViewInfo userInfo = WXUserUtil.getUserViewInfoByUserId(be.getUserId());
		if (userInfo == null) {
			throw new BusinessException("B&E发表的用户不存在");
		}
		request.setAttribute("beId", beId);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("be/detail");
		return view;
	}

	@RequestMapping("/publishbe.html")
	public ModelAndView publishbe(HttpServletRequest request) {
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
		ModelAndView view = new ModelAndView("be/publishbe");
		return view;
	}

	@RequestMapping("/mybe.html")
	public ModelAndView mybe(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("be/mybe");
		return view;
	}

	@RequestMapping("/mytimeline.html")
	public ModelAndView mytimeline(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
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
			UserViewInfo userInfo = WXUserUtil.getUserViewInfoByUserId(queryMyBeReq.getUserId());
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
						d.put("beId", be.getBeId());
						d.put("commentCount", HyBeUtil.getBeCommentsCount(be.getBeId()));
						d.put("dianzan", be.getDianzan());
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
			UserViewInfo userInfo = WXUserUtil.getUserViewInfoByUserId(queryMyBeReq.getUserId());
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
						// 获取创建日期,标记是否显示时间线日期
						boolean showtime = false;
						String t = DateUtil.getDateString(be.getCreateDate(), DateUtil.YYYYMMDD);
						if (!dayMap.containsKey(t)) {
							showtime = true;
							dayMap.put(t, t);
						}
						// 获取标签
						long days = DateUtil.getTimeDifference(DateUtil.getTheDayFirstSecond(DateUtil.getSysDate()),
								DateUtil.getTheDayFirstSecond(be.getCreateDate()));
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
						d.put("beId", be.getBeId());
						d.put("dianzan", be.getDianzan());
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

	@RequestMapping("/getOneBe")
	@ResponseBody
	public ResponseData<Be> getOneBe(QueryOneBeReq queryOneBeReq) {
		ResponseData<Be> responseData = null;
		try {
			QueryOneBeResp resp = DubboConsumerFactory.getService(IBeSV.class).queryOneBe(queryOneBeReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				responseData = new ResponseData<Be>(ResponseData.AJAX_STATUS_FAILURE,
						resp.getResponseHeader().getResultMessage());
			} else {
				responseData = new ResponseData<Be>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功", resp.getBe());
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, Be.class);
		}
		return responseData;
	}

	@RequestMapping("/dianzan")
	@ResponseBody
	public ResponseData<Long> dianzan(@NotBlank(message = "动态标识为空") String beId, HttpServletRequest request) {
		ResponseData<Long> responseData = null;
		try {
			/* 1.获取当前注册的用户 */
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			/* 2.判断用户是否已经点赞过了 */
			boolean had = HyBeUtil.checkUserDianzan(beId, userInfo.getUserId());
			if (!had) {
				// 记录用户一次点赞行为
				HyBeUtil.recordUserDianzan(beId, userInfo.getUserId());
				// 发送一条消息给MNS记录用户点赞数据
				this.sendBeDoLikesMQ(beId, userInfo.getUserId());
			}
			long count = HyBeUtil.getBeDianzanCount(beId);
			responseData = new ResponseData<Long>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", count);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, Long.class);
		}
		return responseData;
	}

	@RequestMapping("/cancelDianzn")
	@ResponseBody
	public ResponseData<Long> cancelDianzn(@NotBlank(message = "动态标识为空") String beId, HttpServletRequest request) {
		ResponseData<Long> responseData = null;
		try {
			/* 1.获取当前注册的用户 */
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			/* 2.判断用户是否已经点赞过了 */
			boolean had = HyBeUtil.checkUserDianzan(beId, userInfo.getUserId());
			if (!had) {
				// 记录用户一次点赞行为
				HyBeUtil.userCancelZan(beId, userInfo.getUserId());
				// 发送一条消息给MNS记录用户取消点赞数据
				this.sendBeCancelLikesMQ(beId, userInfo.getUserId());
			}
			long count = HyBeUtil.getBeDianzanCount(beId);
			responseData = new ResponseData<Long>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", count);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, Long.class);
		}
		return responseData;
	}

	@RequestMapping("/getDianzanUsers")
	@ResponseBody
	public ResponseData<JSONArray> getDianzanUsers(@NotBlank(message = "动态标识为空") String beId) {
		ResponseData<JSONArray> responseData = null;
		try {
			JSONArray array = new JSONArray();
			// 获取BE的点赞用户列表
			Set<String> users = HyBeUtil.getDianzanUsers(beId);
			for (String userId : users) {
				// 获取用户信息
				UserInfo userInfo = DubboServiceUtil.getUserInfoByUserId(userId);
				if (userInfo != null) {
					JSONObject d = new JSONObject();
					d.put("userId", userInfo.getUserId());
					d.put("enName", userInfo.getEnName());
					d.put("wxHeadimg", userInfo.getWxHeadimg());
					array.add(d);
				}
			}
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", array);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
		}
		return responseData;
	}

	@RequestMapping("/sendBeComment")
	@ResponseBody
	public ResponseData<BeComment> sendBeComment(@NotBlank(message = "评论内容为空") DoBeComment doBeComment,
			HttpServletRequest request) {
		ResponseData<BeComment> responseData = null;
		try {
			/* 1.获取当前操作的用户 */
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			/* 2.主要参数信息是否为空 */
			if (StringUtil.isBlank(doBeComment.getContent())) {
				throw new BusinessException("请输入评论内容");
			}
			if (StringUtil.isBlank(doBeComment.getBeId())) {
				throw new BusinessException("B&E标识为空");
			}
			/* 2.组织消息 */
			doBeComment.setCommentId(UUIDUtil.genId32());
			doBeComment.setUserId(userInfo.getUserId());
			doBeComment.setSysdate(DateUtil.getSysDate());
			doBeComment.setHandleType(DoBeComment.HandleType.PUBLISH.name());
			/* 3.发送评论消息 */
			this.sendDoBeCommentMQ(doBeComment);
			/* 4.组织评论内容返回 */
			BeComment b = this.convertBeComment(doBeComment, userInfo);
			responseData = new ResponseData<BeComment>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", b);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, BeComment.class);
		}
		return responseData;
	}

	@RequestMapping("/deleteBeComment")
	@ResponseBody
	public ResponseData<String> deleteBeComment(@NotBlank(message = "BE标识为空") String beId,
			@NotBlank(message = "评论标识为空") String commentId, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			/* 1.获取当前操作的用户 */
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			/* 3.发送评论消息 */
			this.sendBeCommentDelMQ(beId, commentId);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", commentId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/getBeComments")
	@ResponseBody
	public ResponseData<List<BeComment>> getBeComments(@NotBlank(message = "BE标识为空") String beId) {
		ResponseData<List<BeComment>> responseData = null;
		try {
			/* 1.获取BE的所有评论集合 */
			Set<String> set = HyBeUtil.getBeCommentIds(beId, 0, -1);
			/* 2.获取所有评论数据 */
			List<BeComment> list = new ArrayList<BeComment>();
			for (String commentId : set) {
				String commentData = HyBeUtil.getBeComment(commentId);
				if (!StringUtil.isBlank(commentData)) {
					BeComment b = JSONObject.parseObject(commentData, BeComment.class);
					this.fillBeCommentInfo(b);
					list.add(b);
				}
			}
			responseData = new ResponseData<List<BeComment>>(ResponseData.AJAX_STATUS_SUCCESS, "操作成功", list);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<List<BeComment>>(ResponseData.AJAX_STATUS_FAILURE, "操作失败");
		}
		return responseData;
	}

	private BeComment convertBeComment(DoBeComment doBeComment, UserViewInfo userInfo) {
		BeComment b = new BeComment();
		BeanUtils.copyProperties(doBeComment, b);
		b.setCreateDate(doBeComment.getSysdate());
		b.setCreateTimeInteval(DateUtil.getInterval(doBeComment.getSysdate()));
		// 发布人信息
		b.setUserStatusName(userInfo.getUserStatusName());
		b.setWxHeadimg(userInfo.getWxHeadimg());
		b.setEnName(userInfo.getEnName());
		b.setUserStatusName(userInfo.getUserStatusName());
		// 回复上级信息
		if (!StringUtil.isBlank(doBeComment.getParentUserId())) {
			UserViewInfo puser = WXUserUtil.getUserViewInfoByUserId(doBeComment.getParentUserId());
			if (puser != null) {
				b.setPabroadCountryName(puser.getAbroadCountryName());
				b.setPenName(puser.getEnName());
				b.setPuserStatusName(puser.getUserStatusName());
				b.setPwxHeadimg(puser.getWxHeadimg());
			}
		}
		return b;
	}

	private void fillBeCommentInfo(BeComment b) {
		b.setCreateTimeInteval(DateUtil.getInterval(b.getCreateDate()));
		// 发布人信息
		if (!StringUtil.isBlank(b.getUserId())) {
			UserViewInfo userInfo = WXUserUtil.getUserViewInfoByUserId(b.getUserId());
			if (userInfo != null) {
				b.setUserStatusName(userInfo.getUserStatusName());
				b.setWxHeadimg(userInfo.getWxHeadimg());
				b.setEnName(userInfo.getEnName());
				b.setAbroadCountryName(userInfo.getAbroadCountryName());
			}

		}

		// 回复上级信息
		if (!StringUtil.isBlank(b.getParentUserId())) {
			UserViewInfo puser = WXUserUtil.getUserViewInfoByUserId(b.getParentUserId());
			if (puser != null) {
				b.setPabroadCountryName(puser.getAbroadCountryName());
				b.setPenName(puser.getEnName());
				b.setPuserStatusName(puser.getUserStatusName());
				b.setPwxHeadimg(puser.getWxHeadimg());
			}
		}
	}

	/**
	 * 发送一条BE点赞数据
	 * 
	 * @param beId
	 * @param userId
	 */
	private void sendBeDoLikesMQ(String beId, String userId) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserInteractionQueueName());
			Message message = new Message();
			DoBeLikes body = new DoBeLikes();
			body.setBeId(beId);
			body.setUserId(userId);
			body.setTime(DateUtil.getSysDate());
			body.setHandleType(HandleType.ZAN.name());
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_BE_LIKES.getValue());
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
			LOG.error("BE dianzan add message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

	/**
	 * 发送一条取消BE点赞数据
	 * 
	 * @param beId
	 * @param userId
	 */
	private void sendBeCancelLikesMQ(String beId, String userId) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserInteractionQueueName());
			Message message = new Message();
			DoBeLikes body = new DoBeLikes();
			body.setBeId(beId);
			body.setUserId(userId);
			body.setTime(DateUtil.getSysDate());
			body.setHandleType(HandleType.CANCEL.name());
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_BE_LIKES.getValue());
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
			LOG.error("BE dianzan cancel message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

	/**
	 * 发送BE评论消息
	 * 
	 * @param doBeComment
	 */
	private void sendDoBeCommentMQ(DoBeComment doBeComment) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserInteractionQueueName());
			Message message = new Message();
			doBeComment.setMqId(UUIDUtil.genId32());
			doBeComment.setMqType(MQType.MQ_HY_BE_COMMENT.getValue());
			message.setMessageBody(JSONObject.toJSONString(doBeComment));
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
			LOG.error("BE comments add  message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

	/**
	 * 发送BE评论删除消息
	 * 
	 * @param beId
	 * @param commentId
	 */
	private void sendBeCommentDelMQ(String beId, String commentId) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserInteractionQueueName());
			Message message = new Message();
			DoBeComment body = new DoBeComment();
			body.setBeId(beId);
			body.setCommentId(commentId);
			body.setSysdate(DateUtil.getSysDate());
			body.setHandleType(DoBeComment.HandleType.CANCEL.name());
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_BE_COMMENT.getValue());
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
			LOG.error("BE comment delete  message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

}
