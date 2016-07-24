package com.the.harbor.web.go.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotNull;

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
import com.the.harbor.api.go.IGoSV;
import com.the.harbor.api.go.param.CreateGoPaymentOrderReq;
import com.the.harbor.api.go.param.CreateGoPaymentOrderResp;
import com.the.harbor.api.go.param.DoGoComment;
import com.the.harbor.api.go.param.DoGoFavorite;
import com.the.harbor.api.go.param.DoGoJoinConfirm;
import com.the.harbor.api.go.param.GiveHBReq;
import com.the.harbor.api.go.param.Go;
import com.the.harbor.api.go.param.GoComment;
import com.the.harbor.api.go.param.GoCreateReq;
import com.the.harbor.api.go.param.GoCreateResp;
import com.the.harbor.api.go.param.GoJoin;
import com.the.harbor.api.go.param.GoOrder;
import com.the.harbor.api.go.param.GoOrderConfirmReq;
import com.the.harbor.api.go.param.GoOrderCreateReq;
import com.the.harbor.api.go.param.GoOrderCreateResp;
import com.the.harbor.api.go.param.GoOrderFinishReq;
import com.the.harbor.api.go.param.GoOrderMeetLocaltionConfirmReq;
import com.the.harbor.api.go.param.GoOrderMeetLocaltionReq;
import com.the.harbor.api.go.param.GroupApplyReq;
import com.the.harbor.api.go.param.GroupApplyResp;
import com.the.harbor.api.go.param.QueryGoReq;
import com.the.harbor.api.go.param.QueryGoResp;
import com.the.harbor.api.go.param.QueryMyFavorGoReq;
import com.the.harbor.api.go.param.QueryMyFavorGoResp;
import com.the.harbor.api.go.param.QueryMyGoReq;
import com.the.harbor.api.go.param.QueryMyGoResp;
import com.the.harbor.api.go.param.QueryMyJointGoReq;
import com.the.harbor.api.go.param.QueryMyJointGoResp;
import com.the.harbor.api.go.param.QueryOrderGoRecordReq;
import com.the.harbor.api.go.param.QueryOrderGoRecordResp;
import com.the.harbor.api.go.param.SubmitGoHelpReq;
import com.the.harbor.api.go.param.UpdateGoJoinPayReq;
import com.the.harbor.api.go.param.UpdateGoOrderPayReq;
import com.the.harbor.api.user.param.UserViewInfo;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.enumeration.dict.ParamCode;
import com.the.harbor.base.enumeration.dict.TypeCode;
import com.the.harbor.base.enumeration.hygo.GoType;
import com.the.harbor.base.enumeration.hygoorder.OrderStatus;
import com.the.harbor.base.enumeration.hypaymentorder.BusiType;
import com.the.harbor.base.enumeration.hypaymentorder.PayType;
import com.the.harbor.base.enumeration.mns.MQType;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.vo.PageInfo;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.redisdata.def.HyDictsVo;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyDictUtil;
import com.the.harbor.commons.redisdata.util.HyGoUtil;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
import com.the.harbor.commons.util.AmountUtils;
import com.the.harbor.commons.util.CollectionUtil;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.commons.util.UUIDUtil;
import com.the.harbor.commons.web.model.ResponseData;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.system.utils.WXUserUtil;
import com.the.harbor.web.util.DubboServiceUtil;
import com.the.harbor.web.util.UserCommentMQSend;
import com.the.harbor.web.util.UserFavorMQSend;
import com.the.harbor.web.util.UserGroupJoinConfirmMQSend;

@RestController
@RequestMapping("/go")
public class GoController {

	private static final Logger LOG = Logger.getLogger(GoController.class);

	@RequestMapping("/mygroup.html")
	public ModelAndView mygroup(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		String type = request.getParameter("type");
		request.setAttribute("type", type);
		ModelAndView view = new ModelAndView("go/mygroup");
		return view;
	}

	@RequestMapping("/myono.html")
	public ModelAndView myono(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		String type = request.getParameter("type");
		request.setAttribute("type", type);
		ModelAndView view = new ModelAndView("go/myono");
		return view;
	}

	/**
	 * OneOnOne活动参与者确认页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toConfirm.html")
	public ModelAndView toConfirm(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("不能查看确认信息:缺少预约单信息");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("不能查看确认信息,该预约单不存在。您可以前往预约", true, "../go/oneononeindex.html");
		}
		if (!userInfo.getUserId().equals(goOrder.getUserId())) {
			throw new BusinessException("不能查看确认信息,预约单不是您发起的。请可以前往预约", true,
					"../go/toOrder.html?goId=" + goOrder.getGoId());
		}
		// 活动发起者用户
		UserViewInfo publishUserInfo = WXUserUtil.getUserViewInfoByUserId(goOrder.getPublishUserId());
		if (publishUserInfo == null) {
			throw new BusinessException("不能查看确认信息:活动发起者信息不存在");
		}
		String tips = "";
		if (OrderStatus.WAIT_CONFIRM.getValue().equals(goOrder.getOrderStatus())) {
			tips = DateUtil.getDateString(goOrder.getCreateDate(), "yyyy-MM-dd HH:mm") + " 预约已提交，请等待海牛确认";
		} else if (OrderStatus.REJECT.getValue().equals(goOrder.getOrderStatus())) {
			tips = DateUtil.getDateString(goOrder.getStsDate(), "yyyy-MM-dd HH:mm") + " 海牛拒绝了您的预约,您支付的费用将在3个工作日内退款";
		} else if (OrderStatus.WAIT_MEET.getValue().equals(goOrder.getOrderStatus())) {
			tips = DateUtil.getDateString(goOrder.getStsDate(), "yyyy-MM-dd HH:mm")
					+ " 海牛已经确认，等待约见。<a href=\"../go/toAppointment.html?goOrderId=" + goOrderId
					+ "\" style=\"color:red\">进入约见</a>";
		} else if (OrderStatus.FINISH.getValue().equals(goOrder.getOrderStatus())) {
			tips = DateUtil.getDateString(goOrder.getStsDate(), "yyyy-MM-dd HH:mm")
					+ " 活动已经结束。<a href=\"../go/toFeedback.html?goOrderId=" + goOrderId
					+ "\" style=\"color:red\">进入点评</a>";
		}
		request.setAttribute("tips", tips);
		request.setAttribute("userInfo", publishUserInfo);
		request.setAttribute("goOrder", goOrder);
		ModelAndView view = new ModelAndView("go/confirm");
		return view;
	}

	/**
	 * OneOnOne活动发起者确认页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toHainiuConfirm.html")
	public ModelAndView toHainiuConfirm(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("不能确认活动预约信息:缺少预约单信息");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("不能确认活动预约信息:该预约单不存在。");
		}
		if (!userInfo.getUserId().equals(goOrder.getPublishUserId())) {
			throw new BusinessException("不能确认活动预约信息:您不是该活动的发起方");
		}
		// 活动参与方
		UserViewInfo joinUserInfo = WXUserUtil.getUserViewInfoByUserId(goOrder.getUserId());
		if (joinUserInfo == null) {
			throw new BusinessException("不能确认活动预约信息:活动预约方信息不存在");
		}
		// 如果不是待海牛确认的，则跳转到对应页面
		if (!OrderStatus.WAIT_CONFIRM.getValue().equals(goOrder.getOrderStatus())) {
			String statusName = HyDictUtil.getHyDictDesc(TypeCode.HY_GO_ORDER.getValue(),
					ParamCode.ORDER_STATUS.getValue(), goOrder.getOrderStatus());
			// 如果状态是待约见，提示跳转到约见
			if (OrderStatus.WAIT_MEET.getValue().equals(goOrder.getOrderStatus())) {
				throw new BusinessException("您已经确认。可以进一步设定约见地点", true,
						"../go/toHainiuAppointment.html?goOrderId=" + goOrderId + "");
			} else if (OrderStatus.FINISH.getValue().equals(goOrder.getOrderStatus())) {
				// 如果是完成，则进入评价
				throw new BusinessException("您已经确认。活动已经结束。您可以进行点评", true,
						"../go/toFeedback.html?goOrderId=" + goOrderId + "");
			} else {
				throw new BusinessException("不能确认活动预约信息:预约单的状态为[" + statusName + "]");
			}

		}
		String tips = DateUtil.getDateString(goOrder.getCreateDate(), "yyyy-MM-dd HH:mm") + " 预约已提交，等待您的确认";
		request.setAttribute("tips", tips);
		request.setAttribute("userInfo", joinUserInfo);
		request.setAttribute("goOrder", goOrder);
		ModelAndView view = new ModelAndView("go/hainiuconfirm");
		return view;
	}

	@RequestMapping("/toHainiuAppointment.html")
	public ModelAndView toHainiuAppointment(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("缺少预约单信息");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("该预约单不存在。");
		}
		if (!userInfo.getUserId().equals(goOrder.getPublishUserId())) {
			throw new BusinessException("您不是该活动的发起方");
		}
		// 活动参与方
		UserViewInfo joinUserInfo = WXUserUtil.getUserViewInfoByUserId(goOrder.getUserId());
		if (joinUserInfo == null) {
			throw new BusinessException("预约方信息不存在");
		}
		if (!OrderStatus.WAIT_MEET.getValue().equals(goOrder.getOrderStatus())) {
			throw new BusinessException("预约单状态不正确，不能设定约定地点");
		}

		// 判断小白是否已经选择了时间地点
		boolean confirm = !StringUtil.isBlank(goOrder.getConfirmLocation());
		boolean on1 = false;
		boolean on2 = false;
		if (confirm) {
			on1 = goOrder.getExpectedLocation1().equals(goOrder.getConfirmLocation());
			on2 = goOrder.getExpectedLocation2().equals(goOrder.getConfirmLocation());
		}
		request.setAttribute("on1", on1);
		request.setAttribute("on2", on2);
		request.setAttribute("confirm", confirm);
		request.setAttribute("userInfo", joinUserInfo);
		request.setAttribute("goOrder", goOrder);
		ModelAndView view = new ModelAndView("go/toHainiuAppointment");
		return view;
	}

	@RequestMapping("/toOrder.html")
	public ModelAndView toOrder(HttpServletRequest request) {
		String goId = request.getParameter("goId");
		if (StringUtil.isBlank(goId)) {
			throw new BusinessException("请先选择活动后才可以预约", true, "../go/oneononeindex.html");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 查询活动信息
		Go go = DubboServiceUtil.queryGo(goId);
		if (go == null) {
			throw new BusinessException("活动不存在，请重新选择", true, "../go/oneononeindex.html");
		}
		if (userInfo.getUserId().equals(go.getUserId())) {
			throw new BusinessException("此活动是您自己发布，不可预约，请重新选择", true, "../go/oneononeindex.html");
		}
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(userInfo.getUserId(), goId);
		if (goOrder != null) {
			String goOrderId = goOrder.getOrderId();
			String orderStatus = goOrder.getOrderStatus();
			Map<String, String> m = this.getJumpURLAndMessageForJoiner(orderStatus, goOrder.getGoId(), goOrderId);
			String jumpURL = m.get("jumpURL");
			String message = m.get("message");
			throw new BusinessException("您已经预约了此活动," + message, true, jumpURL);
		}
		request.setAttribute("goId", goId);
		request.setAttribute("userInfo", userInfo);
		ModelAndView view = new ModelAndView("go/order");
		return view;
	}

	private Map<String, String> getJumpURLAndMessageForJoiner(String orderStatus, String goId, String goOrderId) {
		Map<String, String> m = new HashMap<String, String>();
		String jumpURL = null;
		String message = null;
		if (OrderStatus.PAY_FAILURE.getValue().equals(orderStatus)
				|| OrderStatus.WAIT_PAY.getValue().equals(orderStatus)) {
			// 如果是支付失败或者待支付，直接进入支付页面
			jumpURL = "../go/toPay.html?goId=" + goId + "&goOrderId=" + goOrderId;
			message = "需要您进行支付,请前往";
		} else if (OrderStatus.WAIT_CONFIRM.getValue().equals(orderStatus)) {
			// 如果是待海牛确认，则跳转到确认页面
			jumpURL = "../go/toConfirm.html?goOrderId=" + goOrderId;
			message = "需要等待海牛确认,请前往";
		} else if ((OrderStatus.REJECT.getValue().equals(orderStatus))) {
			// 海牛已经拒绝
			message = "海牛拒绝了您的参与请求，请重新选择其他活动";
			jumpURL = "../go/oneononeindex.html";
		} else if ((OrderStatus.WAIT_MEET.getValue().equals(orderStatus))) {
			message = "海牛接收了您的请求，请前往";
			jumpURL = "../go/toAppointment.html";
		}
		m.put("jumpURL", jumpURL);
		m.put("message", message);
		return m;
	}

	@RequestMapping("/toAppointment.html")
	public ModelAndView toAppointment(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("缺少预约单信息");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("该预约单不存在");
		}
		if (!userInfo.getUserId().equals(goOrder.getUserId())) {
			throw new BusinessException("您不是预约活动人");
		}
		if (!OrderStatus.WAIT_MEET.getValue().equals(goOrder.getOrderStatus())) {
			throw new BusinessException("预约单状态不正确，不能选择约定地点");
		}
		UserViewInfo publishUserInfo = WXUserUtil.getUserViewInfoByUserId(goOrder.getPublishUserId());
		if (publishUserInfo == null) {
			throw new BusinessException("活动发起方信息不存在");
		}
		// 判断小白是否已经选择了时间地点
		boolean confirm = !StringUtil.isBlank(goOrder.getConfirmLocation());
		// 判断海牛是否设置了时间地点
		boolean setMeetLocalFlag = !(StringUtil.isBlank(goOrder.getExpectedLocation1())
				|| StringUtil.isBlank(goOrder.getExpectedLocation2()));
		// 如果已经设置判断
		boolean on1 = false;
		boolean on2 = false;
		if (setMeetLocalFlag) {
			on1 = goOrder.getExpectedLocation1().equals(goOrder.getConfirmLocation());
			on2 = goOrder.getExpectedLocation2().equals(goOrder.getConfirmLocation());
		}

		request.setAttribute("confirm", confirm);
		request.setAttribute("on1", on1);
		request.setAttribute("on2", on2);
		request.setAttribute("setMeetLocalFlag", setMeetLocalFlag);
		request.setAttribute("userInfo", publishUserInfo);
		request.setAttribute("goOrder", goOrder);
		ModelAndView view = new ModelAndView("go/appointment");
		return view;
	}

	@RequestMapping("/toPay.html")
	public ModelAndView toPay(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("支付失败:活动预约单号为空");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("支付失败:您没有对此活动进行预约", true, "../go/oneononeindex.html");
		}
		// 判断活动是否属于待支付或者支付失败状态
		if (!(OrderStatus.PAY_FAILURE.getValue().equals(goOrder.getOrderStatus())
				|| OrderStatus.WAIT_PAY.getValue().equals(goOrder.getOrderStatus()))) {
			Map<String, String> m = this.getJumpURLAndMessageForJoiner(goOrder.getOrderStatus(), goOrder.getGoId(),
					goOrder.getOrderId());
			String jumpURL = m.get("jumpURL");
			String message = m.get("message");
			throw new BusinessException("此活动预约单不可支付," + message, true, jumpURL);
		}
		// 获取预约信息
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
		request.setAttribute("openId", userInfo.getWxOpenid());
		request.setAttribute("topic", goOrder.getTopic());
		request.setAttribute("goId", goOrder.getGoId());
		request.setAttribute("goOrderId", goOrderId);
		request.setAttribute("orderStatus", goOrder.getOrderStatus());
		request.setAttribute("orderStatusName", goOrder.getOrderStatusName());
		request.setAttribute("price", AmountUtils.changeF2Y(goOrder.getFixedPrice()));
		ModelAndView view = new ModelAndView("go/pay");
		return view;
	}

	@RequestMapping("/publishGo.html")
	public ModelAndView publishGo(HttpServletRequest request) {
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
		ModelAndView view = new ModelAndView("go/publishgo");
		return view;
	}

	/**
	 * 小白评价页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toFeedback.html")
	public ModelAndView toFeedback(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("缺少预约单信息");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("该预约单不存在");
		}
		if (!userInfo.getUserId().equals(goOrder.getUserId())) {
			throw new BusinessException("您不是预约活动人");
		}
		if (!OrderStatus.FINISH.getValue().equals(goOrder.getOrderStatus())) {
			throw new BusinessException("海牛没有确认活动结束，还不能评价");
		}
		UserViewInfo publishUserInfo = WXUserUtil.getUserViewInfoByUserId(goOrder.getPublishUserId());
		if (publishUserInfo == null) {
			throw new BusinessException("活动发起方信息不存在");
		}
		request.setAttribute("userInfo", publishUserInfo);
		request.setAttribute("goOrder", goOrder);
		ModelAndView view = new ModelAndView("go/feedback");
		return view;
	}

	/**
	 * 海牛评价页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toHainiuFeedback.html")
	public ModelAndView toHainiuFeedback(HttpServletRequest request) {
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("缺少预约单信息");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 校验当前用户对于此活动的状态来执行处理
		GoOrder goOrder = DubboServiceUtil.queryGoOrder(goOrderId);
		if (goOrder == null) {
			throw new BusinessException("该预约单不存在");
		}
		if (!userInfo.getUserId().equals(goOrder.getPublishUserId())) {
			throw new BusinessException("您不是活动发起者");
		}
		if (!OrderStatus.FINISH.getValue().equals(goOrder.getOrderStatus())) {
			throw new BusinessException("您没有确认活动结束，还不能评价");
		}
		// 获取活动预约者信息
		UserViewInfo orderUserInfo = WXUserUtil.getUserViewInfoByUserId(goOrder.getUserId());
		if (orderUserInfo == null) {
			throw new BusinessException("活动预约者信息不存在");
		}
		request.setAttribute("userInfo", orderUserInfo);
		request.setAttribute("goOrder", goOrder);
		ModelAndView view = new ModelAndView("go/hainiufeedback");
		return view;
	}

	@RequestMapping("/confirmlist.html")
	public ModelAndView confirmlist(HttpServletRequest request) {
		String goId = request.getParameter("goId");
		if (StringUtil.isBlank(goId)) {
			throw new BusinessException("活动记录不存在");
		}
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		// 查询活动信息
		Go go = DubboServiceUtil.queryGo(goId);
		if (go == null) {
			throw new BusinessException("活动不存在，无法确认");
		}
		if (!userInfo.getUserId().equals(go.getUserId())) {
			throw new BusinessException("您不是活动的发起者，无法确认");
		}
		request.setAttribute("go", go);
		ModelAndView view = new ModelAndView("go/confirmlist");
		return view;
	}

	@RequestMapping("/onodetail.html")
	public ModelAndView onodetail(HttpServletRequest request) {
		String goId = request.getParameter("goId");
		if (StringUtil.isBlank(goId)) {
			throw new BusinessException("您查看的活动信息不存在");
		}
		Go go = DubboServiceUtil.queryGo(goId);
		if (go == null) {
			throw new BusinessException("您查看的活动信息不存在");
		}
		request.setAttribute("go", go);
		ModelAndView view = new ModelAndView("go/onodetail");
		return view;
	}

	@RequestMapping("/goindex.html")
	public ModelAndView goindex(HttpServletRequest request) {
		String goType = request.getParameter("goType");
		if (StringUtil.isBlank(goType)) {
			goType = "group";
		}
		request.setAttribute("goType", goType);
		ModelAndView view = new ModelAndView("go/goindex");
		return view;
	}

	@RequestMapping("/myjointgoes.html")
	public ModelAndView myjointgoes(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		String goType = request.getParameter("goType");
		if (StringUtil.isBlank(goType)) {
			goType = "group";
		}
		request.setAttribute("goType", goType);
		ModelAndView view = new ModelAndView("go/myjointgoes");
		return view;
	}

	@RequestMapping("/comments.html")
	public ModelAndView comments(HttpServletRequest request) {
		WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		String goOrderId = request.getParameter("goOrderId");
		if (StringUtil.isBlank(goOrderId)) {
			throw new BusinessException("活动预约单不存在");
		}
		GoJoin goJoin = DubboServiceUtil.queryGoJoin(goOrderId);
		if (goJoin == null) {
			throw new BusinessException("活动预约单不存在");
		}
		Go go = DubboServiceUtil.queryGo(goJoin.getGoId());
		if (go == null) {
			throw new BusinessException("您查看的活动信息不存在");
		}
		request.setAttribute("go", go);
		request.setAttribute("goOrderId", goOrderId);
		ModelAndView view = new ModelAndView("go/comments");
		return view;
	}

	@RequestMapping("/invite.html")
	public ModelAndView invite(HttpServletRequest request) {
		UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
		String goId = request.getParameter("goId");
		if (StringUtil.isBlank(goId)) {
			throw new BusinessException("您查看的活动信息不存在");
		}
		Go go = DubboServiceUtil.queryGo(goId);
		if (go == null) {
			throw new BusinessException("您查看的活动信息不存在");
		}
		boolean joint = HyGoUtil.checkUserHadJointGroup(goId, userInfo.getUserId());
		boolean applied = HyGoUtil.checkUserHadAppliedGroup(goId, userInfo.getUserId());
		request.setAttribute("applied", applied);
		request.setAttribute("joint", joint);
		request.setAttribute("go", go);

		long timestamp = DateUtil.getCurrentTimeMillis();
		String nonceStr = WXHelpUtil.createNoncestr();
		String jsapiTicket = WXHelpUtil.getJSAPITicket();
		String url = WXRequestUtil.getFullURL(request);
		String signature = WXHelpUtil.createJSSDKSignatureSHA(nonceStr, jsapiTicket, timestamp, url);
		request.setAttribute("appId", GlobalSettings.getWeiXinAppId());
		request.setAttribute("timestamp", timestamp);
		request.setAttribute("nonceStr", nonceStr);
		request.setAttribute("signature", signature);

		ModelAndView view = new ModelAndView("go/invite");
		return view;
	}

	@RequestMapping("/invite2.html")
	public ModelAndView invite2(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/invite2");
		return view;
	}

	@RequestMapping("/getGroupSystemTags")
	@ResponseBody
	public ResponseData<JSONObject> getGroupSystemTags() {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		try {
			List<HyTagVo> allGoTags = HyTagUtil.getAllGroupTags();
			data.put("allGoTags", allGoTags);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/getOnOSystemTags")
	@ResponseBody
	public ResponseData<JSONObject> getOnOSystemTags() {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		try {
			List<HyTagVo> allGoTags = HyTagUtil.getAllOnOTags();
			data.put("allGoTags", allGoTags);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/getAllGroupIndexPageTags")
	@ResponseBody
	public ResponseData<JSONObject> getAllGroupIndexPageTags() {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		try {
			List<HyTagVo> allGoTags = HyTagUtil.getAllGroupIndexPageTags();
			data.put("allGoTags", allGoTags);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/getAllOnOIndexPageTags")
	@ResponseBody
	public ResponseData<JSONObject> getAllOnOIndexPageTags() {
		ResponseData<JSONObject> responseData = null;
		JSONObject data = new JSONObject();
		try {
			List<HyTagVo> allGoTags = HyTagUtil.getAllOnOIndexPageTags();
			data.put("allGoTags", allGoTags);
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取标签成功", data);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/submitNewGo")
	@ResponseBody
	public ResponseData<String> submitNewGo(@NotNull(message = "参数为空") String goData) {
		ResponseData<String> responseData = null;
		try {
			if (StringUtil.isBlank(goData)) {
				throw new BusinessException(ExceptCodeConstants.PARAM_IS_NULL, "活动信息为空");
			}
			GoCreateReq request = JSON.parseObject(goData, GoCreateReq.class);
			GoCreateResp rep = DubboConsumerFactory.getService(IGoSV.class).createGo(request);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"提交成功", "");
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
			String fileURL = GlobalSettings.getHarborImagesDomain() + "/" + fileName;
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"上传到OSS成功", fileURL);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/orderOneOnOne")
	@ResponseBody
	public ResponseData<String> orderOneOnOne(@NotNull(message = "参数为空") GoOrderCreateReq goOrderCreateReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			goOrderCreateReq.setUserId(userInfo.getUserId());
			GoOrderCreateResp rep = DubboConsumerFactory.getService(IGoSV.class).orderOneOnOne(goOrderCreateReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"提交成功", rep.getOrderId());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/updateGoOrderPay")
	@ResponseBody
	public ResponseData<String> updateGoOrderPay(@NotNull(message = "参数为空") UpdateGoOrderPayReq updateGoOrderPayReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Response rep = DubboConsumerFactory.getService(IGoSV.class).updateGoOrderPay(updateGoOrderPayReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"提交成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
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
			String goId = request.getParameter("goId");
			String goOrderId = request.getParameter("goOrderId");
			if (StringUtil.isBlank(goId)) {
				throw new BusinessException("GO-100001", "生成支付流水失败:活动标识不存在");
			}
			if (StringUtil.isBlank(goOrderId)) {
				throw new BusinessException("GO-100001", "生成支付流水失败:活动预约流水不存在");
			}
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			String summary = "One on One活动预约支付";
			// 调用服务生成支付流水
			CreateGoPaymentOrderReq createGoPaymentOrderReq = new CreateGoPaymentOrderReq();
			createGoPaymentOrderReq.setBusiType(BusiType.PAY_FOR_ONO.getValue());
			createGoPaymentOrderReq.setPayAmount(Long.parseLong(AmountUtils.changeY2F(price)));
			createGoPaymentOrderReq.setPayType(PayType.WEIXIN.getValue());
			createGoPaymentOrderReq.setSummary(summary);
			createGoPaymentOrderReq.setUserId(userInfo.getUserId());
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
			String pkg = WXHelpUtil.getPackageOfWXJSSDKChoosePayAPI(summary, payOrderId,
					Integer.parseInt(AmountUtils.changeY2F(price)), host, userInfo.getWxOpenid(),
					GlobalSettings.getHarborWXPayNotifyURL(), nonceStr);
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

	@RequestMapping("/confirmGoOrder")
	@ResponseBody
	public ResponseData<String> confirmGoOrder(@NotNull(message = "参数为空") GoOrderConfirmReq goOrderConfirmReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			goOrderConfirmReq.setPublishUserId(userInfo.getUserId());
			Response rep = DubboConsumerFactory.getService(IGoSV.class).confirmGoOrder(goOrderConfirmReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"提交成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/confirmGoOrderMeetLocaltion")
	@ResponseBody
	public ResponseData<String> confirmGoOrderMeetLocaltion(
			@NotNull(message = "参数为空") GoOrderMeetLocaltionConfirmReq goOrderMeetLocaltionConfirmReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			goOrderMeetLocaltionConfirmReq.setUserId(userInfo.getUserId());
			Response rep = DubboConsumerFactory.getService(IGoSV.class)
					.confirmGoOrderMeetLocaltion(goOrderMeetLocaltionConfirmReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"提交成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/getMyGoes")
	@ResponseBody
	public ResponseData<PageInfo<Go>> getMyGoes(@NotNull(message = "参数为空") QueryMyGoReq queryMyGoReq,
			HttpServletRequest request) {
		ResponseData<PageInfo<Go>> responseData = null;
		try {
			// 获取用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			queryMyGoReq.setUserId(userInfo.getUserId());
			QueryMyGoResp rep = DubboConsumerFactory.getService(IGoSV.class).queryMyGoes(queryMyGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"查询成功", rep.getPagInfo());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getMyFavorGoes")
	@ResponseBody
	public ResponseData<PageInfo<Go>> getMyFavorGoes(@NotNull(message = "参数为空") QueryMyFavorGoReq queryMyGoReq,
			HttpServletRequest request) {
		ResponseData<PageInfo<Go>> responseData = null;
		try {
			// 获取用户信息
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			queryMyGoReq.setUserId(userInfo.getUserId());
			QueryMyFavorGoResp rep = DubboConsumerFactory.getService(IGoSV.class).queryMyFavorGoes(queryMyGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"查询成功", rep.getPagInfo());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getIndexPageSilders")
	@ResponseBody
	public ResponseData<JSONArray> getIndexPageSilders() {
		ResponseData<JSONArray> responseData = null;
		try {
			JSONArray array = new JSONArray();
			List<HyDictsVo> list = HyDictUtil.getHyDicts(TypeCode.HY_GO.getValue(), ParamCode.INDEX_SILDER.getValue());
			if (!CollectionUtil.isEmpty(list)) {
				for (HyDictsVo dict : list) {
					String value = dict.getParamValue();
					String[] arr = value.split("!!");
					String imgURL = "";
					String linkURL = "javascript:void(0)";
					if (arr.length == 1) {
						// throw new
						// BusinessException("首页轮播图配置错误，图片地址与超链接地址以$分隔");
						imgURL = arr[0];
					} else if (arr.length == 2) {
						imgURL = arr[0];
						linkURL = arr[1];
					}
					JSONObject d = new JSONObject();
					d.put("imgURL", imgURL);
					d.put("linkURL", linkURL);
					array.add(d);
				}
			}
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取轮播图成功", array);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
		}
		return responseData;
	}

	@RequestMapping("/queryGoes")
	@ResponseBody
	public ResponseData<PageInfo<Go>> queryGoes(@NotNull(message = "参数为空") QueryGoReq queryGoReq,
			HttpServletRequest request) {
		ResponseData<PageInfo<Go>> responseData = null;
		try {
			QueryGoResp rep = DubboConsumerFactory.getService(IGoSV.class).queryGoes(queryGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"查询成功", rep.getPagInfo());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/queryGo")
	@ResponseBody
	public ResponseData<Go> queryGo(@NotNull(message = "参数为空") String goId, HttpServletRequest request) {
		ResponseData<Go> responseData = null;
		try {
			Go go = DubboServiceUtil.queryGo(goId);
			responseData = new ResponseData<Go>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS, "查询成功",
					go);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, Go.class);
		}
		return responseData;
	}

	@RequestMapping("/getGoComments")
	@ResponseBody
	public ResponseData<List<GoComment>> getGoComments(@NotBlank(message = "GO标识为空") String goId) {
		ResponseData<List<GoComment>> responseData = null;
		try {
			/* 1.获取BE的所有评论集合 */
			Set<String> set = HyGoUtil.getGoCommentIds(goId, 0, -1);
			/* 2.获取所有评论数据 */
			List<GoComment> list = new ArrayList<GoComment>();
			for (String commentId : set) {
				String commentData = HyGoUtil.getGoComment(commentId);
				if (!StringUtil.isBlank(commentData)) {
					GoComment b = JSONObject.parseObject(commentData, GoComment.class);
					this.fillGoCommentInfo(b);
					list.add(b);
				}
			}
			responseData = new ResponseData<List<GoComment>>(ResponseData.AJAX_STATUS_SUCCESS,
					ExceptCodeConstants.SUCCESS, "操作成功", list);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<List<GoComment>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "操作失败");
		}
		return responseData;
	}

	@RequestMapping("/checkGoOrder")
	@ResponseBody
	public ResponseData<String> checkGoOrder(@NotBlank(message = "GO标识为空") String goId, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			GoOrder goOrder = DubboServiceUtil.queryGoOrder(userInfo.getUserId(), goId);
			if (goOrder != null && !OrderStatus.CANCEL.getValue().equals(goOrder.getOrderStatus())) {
				throw new BusinessException("您已经预约过此活动哦~");
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/setGoOrderMeetLocaltion")
	@ResponseBody
	public ResponseData<String> setGoOrderMeetLocaltion(
			@NotBlank(message = "参数为空") GoOrderMeetLocaltionReq goOrderMeetLocaltionReq, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			goOrderMeetLocaltionReq.setPublishUserId(userInfo.getUserId());
			Response resp = DubboConsumerFactory.getService(IGoSV.class)
					.setGoOrderMeetLocaltion(goOrderMeetLocaltionReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"提交成功");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/finishGoOrder")
	@ResponseBody
	public ResponseData<String> finishGoOrder(@NotBlank(message = "参数为空") GoOrderFinishReq goOrderFinishReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			goOrderFinishReq.setUserId(userInfo.getUserId());
			Response resp = DubboConsumerFactory.getService(IGoSV.class).finishGoOrder(goOrderFinishReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"提交成功");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	private void fillGoCommentInfo(GoComment b) {
		b.setCreateTimeInteval(DateUtil.getInterval(b.getCreateDate()));
		b.setIsreply(!StringUtil.isBlank(b.getParentCommentId()));
		// 发布人信息
		if (!StringUtil.isBlank(b.getPublishUserId())) {
			UserViewInfo userInfo = WXUserUtil.getUserViewInfoByUserId(b.getPublishUserId());
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

	@RequestMapping("/sendGoComment")
	@ResponseBody
	public ResponseData<GoComment> sendGoComment(@NotBlank(message = "评论内容为空") DoGoComment doGoComment,
			HttpServletRequest request) {
		ResponseData<GoComment> responseData = null;
		try {
			/* 1.获取当前操作的用户 */
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			/* 2.主要参数信息是否为空 */
			if (StringUtil.isBlank(doGoComment.getContent())) {
				throw new BusinessException("请输入评论内容");
			}
			if (StringUtil.isBlank(doGoComment.getGoId())) {
				throw new BusinessException("GO标识为空");
			}
			/* 2.组织消息 */
			doGoComment.setCommentId(UUIDUtil.genId32());
			doGoComment.setPublishUserId(userInfo.getUserId());
			doGoComment.setSysdate(DateUtil.getSysDate());
			doGoComment.setHandleType(DoGoComment.HandleType.PUBLISH.name());
			/* 3.发送评论消息 */
			UserCommentMQSend.sendMQ(doGoComment);
			/* 4.组织评论内容返回 */
			GoComment b = this.convertGoComment(doGoComment, userInfo);
			responseData = new ResponseData<GoComment>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", b);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, GoComment.class);
		}
		return responseData;
	}

	private GoComment convertGoComment(DoGoComment doGoComment, UserViewInfo userInfo) {
		GoComment b = new GoComment();
		BeanUtils.copyProperties(doGoComment, b);
		b.setCreateDate(doGoComment.getSysdate());
		b.setCreateTimeInteval(DateUtil.getInterval(doGoComment.getSysdate()));
		b.setIsreply(!StringUtil.isBlank(doGoComment.getParentCommentId()));
		// 发布人信息
		b.setUserStatusName(userInfo.getUserStatusName());
		b.setWxHeadimg(userInfo.getWxHeadimg());
		b.setEnName(userInfo.getEnName());
		b.setUserStatusName(userInfo.getUserStatusName());
		b.setAbroadCountryName(userInfo.getAbroadCountryName());
		// 回复上级信息
		if (!StringUtil.isBlank(doGoComment.getParentUserId())) {
			UserViewInfo puser = WXUserUtil.getUserViewInfoByUserId(doGoComment.getParentUserId());
			if (puser != null) {
				b.setPabroadCountryName(puser.getAbroadCountryName());
				b.setPenName(puser.getEnName());
				b.setPuserStatusName(puser.getUserStatusName());
				b.setPwxHeadimg(puser.getWxHeadimg());
			}
		}
		return b;
	}

	@RequestMapping("/getGoOrderComments")
	@ResponseBody
	public ResponseData<List<GoComment>> getGoOrderComments(@NotBlank(message = "GO预约标识为空") String orderId) {
		ResponseData<List<GoComment>> responseData = null;
		try {
			/* 1.获取GO的所有评论集合 */
			Set<String> set = HyGoUtil.getGoOrderCommentIds(orderId, 0, -1);
			/* 2.获取所有评论数据 */
			List<GoComment> list = new ArrayList<GoComment>();
			for (String commentId : set) {
				String commentData = HyGoUtil.getGoComment(commentId);
				if (!StringUtil.isBlank(commentData)) {
					GoComment b = JSONObject.parseObject(commentData, GoComment.class);
					this.fillGoCommentInfo(b);
					list.add(b);
				}
			}
			responseData = new ResponseData<List<GoComment>>(ResponseData.AJAX_STATUS_SUCCESS,
					ExceptCodeConstants.SUCCESS, "操作成功", list);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<List<GoComment>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "操作失败");
		}
		return responseData;
	}

	@RequestMapping("/applyGroup")
	@ResponseBody
	public ResponseData<JSONObject> applyGroup(HttpServletRequest request) {
		ResponseData<JSONObject> responseData = null;
		try {
			String nonceStr = request.getParameter("nonceStr");
			String timeStamp = request.getParameter("timeStamp");
			String goId = request.getParameter("goId");
			if (StringUtil.isBlank(goId)) {
				throw new BusinessException("活动标识不存在");
			}
			Go go = DubboServiceUtil.queryGo(goId);
			if (go == null) {
				throw new BusinessException("活动信息不存在");
			}
			UserViewInfo userInfo = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			if (go.getUserId().equals(userInfo.getUserId())) {
				throw new BusinessException("您是活动发起者，不能申请");
			}

			JSONObject d = new JSONObject();

			GroupApplyReq groupApplyReq = new GroupApplyReq();

			groupApplyReq.setUserId(userInfo.getUserId());
			groupApplyReq.setGoId(goId);
			GroupApplyResp resp = DubboConsumerFactory.getService(IGoSV.class).applyGroup(groupApplyReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			} else {
				if (resp.isNeedPay()) {
					if (StringUtil.isBlank(nonceStr)) {
						throw new BusinessException("支付随机串为空");
					}
					if (StringUtil.isBlank(timeStamp)) {
						throw new BusinessException("申请时间戳为空");
					}
					String summary = "Group活动报名支付";
					String payOrderId = resp.getPayOrderId();
					String host = "192.168.1.1";
					String pkg = WXHelpUtil.getPackageOfWXJSSDKChoosePayAPI(summary, payOrderId,
							Integer.parseInt(AmountUtils.changeY2F(resp.getPayAmount())), host, userInfo.getWxOpenid(),
							GlobalSettings.getHarborWXPayNotifyURL(), nonceStr);
					String paySign = WXHelpUtil.getPaySignOfWXJSSDKChoosePayAPI(timeStamp, nonceStr, pkg);

					d.put("package", pkg);
					d.put("paySign", paySign);
					d.put("payOrderId", payOrderId);
				}
				d.put("needPay", resp.isNeedPay());
				d.put("orderId", resp.getOrderId());
				d.put("payAmount", resp.getPayAmount());
				d.put("payOrderId", resp.getPayOrderId());
				responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS,
						ExceptCodeConstants.SUCCESS, "提交成功", d);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/updateGoJoinPay")
	@ResponseBody
	public ResponseData<String> updateGoJoinPay(@NotBlank(message = "参数为空") UpdateGoJoinPayReq updateGoJoinPayReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			Response resp = DubboConsumerFactory.getService(IGoSV.class).updateGoJoinPay(updateGoJoinPayReq);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				throw new BusinessException(resp.getResponseHeader().getResultCode(),
						resp.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"处理成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/getGroupJoinBeenConfirms")
	@ResponseBody
	public ResponseData<List<GoJoin>> getGroupJoinBeenConfirms(@NotBlank(message = "活动标识为空") String goId,
			HttpServletRequest request) {
		ResponseData<List<GoJoin>> responseData = null;
		try {
			WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			QueryOrderGoRecordReq req = new QueryOrderGoRecordReq();
			req.setGoId(goId);
			req.setGoType(GoType.GROUP.getValue());
			QueryOrderGoRecordResp rep = DubboConsumerFactory.getService(IGoSV.class).queryOrderGoRecords(req);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			List<GoJoin> list = rep.getGoJoins();
			List<GoJoin> ls = new ArrayList<GoJoin>();
			if (!CollectionUtil.isEmpty(list)) {
				for (GoJoin goOrder : list) {
					if (com.the.harbor.base.enumeration.hygojoin.OrderStatus.APPLIED.getValue()
							.equals(goOrder.getOrderStatus())
							|| com.the.harbor.base.enumeration.hygojoin.OrderStatus.AGREE.getValue()
									.equals(goOrder.getOrderStatus())
							|| com.the.harbor.base.enumeration.hygojoin.OrderStatus.FINISH.getValue()
									.equals(goOrder.getOrderStatus())) {
						ls.add(goOrder);
					}
				}
			}
			responseData = new ResponseData<List<GoJoin>>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", ls);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<List<GoJoin>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getGroupJoinWaitConfirms")
	@ResponseBody
	public ResponseData<JSONArray> getGroupJoinWaitConfirms(@NotBlank(message = "活动标识为空") String goId) {
		ResponseData<JSONArray> responseData = null;
		try {
			JSONArray array = new JSONArray();
			// 获取BE的点赞用户列表
			Set<String> users = HyGoUtil.getGroupWaitConfirmUsers(goId);
			for (String userId : users) {
				// 获取用户信息
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
					array.add(d);
				}
			}
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", array);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
		}
		return responseData;
	}

	@RequestMapping("/rejectUserJoinGroup")
	@ResponseBody
	public ResponseData<String> rejectUserJoinGroup(@NotBlank(message = "活动标识为空") String goId,
			@NotBlank(message = "活动名称为空") String topic, @NotBlank(message = "被拒绝用户标识为空") String userId,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo pUser = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			DoGoJoinConfirm doGoJoinConfirm = new DoGoJoinConfirm();
			doGoJoinConfirm.setGoId(goId);
			doGoJoinConfirm.setHandleType(DoGoJoinConfirm.HandleType.REJECT.name());
			doGoJoinConfirm.setMqId(UUIDUtil.genId32());
			doGoJoinConfirm.setMqType(MQType.MQ_HY_GO_JOIN_CONFIRM.getValue());
			doGoJoinConfirm.setUserId(userId);
			doGoJoinConfirm.setTopic(topic);
			doGoJoinConfirm.setPublishUserName(pUser.getEnName());
			doGoJoinConfirm.setPublishUserId(pUser.getUserId());
			UserGroupJoinConfirmMQSend.sendMQ(doGoJoinConfirm);
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"处理成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/agreeUserJoinGroup")
	@ResponseBody
	public ResponseData<JSONObject> agreeUserJoinGroup(@NotBlank(message = "活动标识为空") String goId,
			@NotBlank(message = "活动名称为空") String topic, @NotBlank(message = "用户标识为空") String userId,
			HttpServletRequest request) {
		ResponseData<JSONObject> responseData = null;
		try {
			UserViewInfo pUser = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			DoGoJoinConfirm doGoJoinConfirm = new DoGoJoinConfirm();
			doGoJoinConfirm.setGoId(goId);
			doGoJoinConfirm.setHandleType(DoGoJoinConfirm.HandleType.AGREE.name());
			doGoJoinConfirm.setMqId(UUIDUtil.genId32());
			doGoJoinConfirm.setMqType(MQType.MQ_HY_GO_JOIN_CONFIRM.getValue());
			doGoJoinConfirm.setUserId(userId);
			doGoJoinConfirm.setTopic(topic);
			doGoJoinConfirm.setPublishUserName(pUser.getEnName());
			doGoJoinConfirm.setPublishUserId(pUser.getUserId());
			UserGroupJoinConfirmMQSend.sendMQ(doGoJoinConfirm);

			UserViewInfo u = WXUserUtil.getUserViewInfoByUserId(userId);
			JSONObject d = new JSONObject();
			if (u != null) {
				d.put("userId", u.getUserId());
				d.put("wxHeadimg", u.getWxHeadimg());
				d.put("enName", u.getEnName());
				d.put("abroadCountryName", u.getAbroadCountryName());
				d.put("userStatusName", u.getUserStatusName());
				d.put("industryName", u.getIndustryName());
				d.put("title", u.getTitle());
				d.put("atCityName", u.getAtCityName());
			}
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"处理成功", d);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/doInterest")
	@ResponseBody
	public ResponseData<String> doInterest(@NotBlank(message = "参数为空") String goId, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo pUser = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			if (!HyGoUtil.checkUserGoFavorite(goId, pUser.getUserId())) {
				DoGoFavorite body = new DoGoFavorite();
				body.setHandleType(DoGoFavorite.HandleType.DO.name());
				body.setGoId(goId);
				body.setUserId(pUser.getUserId());
				UserFavorMQSend.sendMQ(body);
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"处理成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/queryMyJointGoes")
	@ResponseBody
	public ResponseData<PageInfo<Go>> queryMyJointGoes(@NotNull(message = "参数为空") QueryMyJointGoReq queryGoReq,
			HttpServletRequest request) {
		ResponseData<PageInfo<Go>> responseData = null;
		try {
			UserViewInfo user = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			queryGoReq.setUserId(user.getUserId());
			QueryMyJointGoResp rep = DubboConsumerFactory.getService(IGoSV.class).queryMyJointGoes(queryGoReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"查询成功", rep.getPagInfo());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<PageInfo<Go>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/submitGoHelp")
	@ResponseBody
	public ResponseData<String> submitGoHelp(@NotNull(message = "参数为空") SubmitGoHelpReq submitGoHelpReq,
			HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo user = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			submitGoHelpReq.setUserId(user.getUserId());
			Response rep = DubboConsumerFactory.getService(IGoSV.class).submitGoHelp(submitGoHelpReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/giveHaibei")
	@ResponseBody
	public ResponseData<String> giveHaibei(@NotNull(message = "参数为空") GiveHBReq giveHBReq, HttpServletRequest request) {
		ResponseData<String> responseData = null;
		try {
			UserViewInfo user = WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			giveHBReq.setUserId(user.getUserId());
			Response rep = DubboConsumerFactory.getService(IGoSV.class).giveHaibei(giveHBReq);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", "");
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = ExceptionUtil.convert(e, String.class);
		}
		return responseData;
	}

	@RequestMapping("/mycreateonodetail.html")
	public ModelAndView mycreateonodetail(HttpServletRequest request) {
		String goId = request.getParameter("goId");
		if (StringUtil.isBlank(goId)) {
			throw new BusinessException("活动信息不存在");
		}
		Go go = DubboServiceUtil.queryGo(goId);
		if (go == null) {
			throw new BusinessException("活动信息不存在");
		}
		request.setAttribute("go", go);
		ModelAndView view = new ModelAndView("go/mycreateonodetail");
		return view;
	}

	/**
	 * 我发表的ONO活动预约单信息
	 * 
	 * @param goId
	 * @param request
	 * @return
	 */
	@RequestMapping("/getMyOnoOrderRecords")
	@ResponseBody
	public ResponseData<List<GoOrder>> getMyOnoOrderRecords(@NotBlank(message = "活动ID不为空") String goId,
			HttpServletRequest request) {
		ResponseData<List<GoOrder>> responseData = null;
		try {
			WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			QueryOrderGoRecordReq req = new QueryOrderGoRecordReq();
			req.setGoId(goId);
			req.setGoType(GoType.ONE_ON_ONE.getValue());
			QueryOrderGoRecordResp rep = DubboConsumerFactory.getService(IGoSV.class).queryOrderGoRecords(req);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			List<GoOrder> list = rep.getGoOrders();
			List<GoOrder> ls = new ArrayList<GoOrder>();
			if (!CollectionUtil.isEmpty(list)) {
				for (GoOrder goOrder : list) {
					if (com.the.harbor.base.enumeration.hygoorder.OrderStatus.WAIT_CONFIRM.getValue()
							.equals(goOrder.getOrderStatus())
							|| com.the.harbor.base.enumeration.hygoorder.OrderStatus.WAIT_MEET.getValue()
									.equals(goOrder.getOrderStatus())
							|| com.the.harbor.base.enumeration.hygoorder.OrderStatus.FINISH.getValue()
									.equals(goOrder.getOrderStatus())) {
						ls.add(goOrder);
					}
				}
			}
			responseData = new ResponseData<List<GoOrder>>(ResponseData.AJAX_STATUS_SUCCESS,
					ExceptCodeConstants.SUCCESS, "操作成功", ls);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<List<GoOrder>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	/**
	 * 我发表的ONO活动预约单信息
	 * 
	 * @param goId
	 * @param request
	 * @return
	 */
	@RequestMapping("/getMyGroupJoinRecords")
	@ResponseBody
	public ResponseData<List<GoJoin>> getMyGroupJoinRecords(@NotBlank(message = "活动ID不为空") String goId,
			HttpServletRequest request) {
		ResponseData<List<GoJoin>> responseData = null;
		try {
			WXUserUtil.checkUserRegAndGetUserViewInfo(request);
			QueryOrderGoRecordReq req = new QueryOrderGoRecordReq();
			req.setGoId(goId);
			req.setGoType(GoType.GROUP.getValue());
			QueryOrderGoRecordResp rep = DubboConsumerFactory.getService(IGoSV.class).queryOrderGoRecords(req);
			if (!ExceptCodeConstants.SUCCESS.equals(rep.getResponseHeader().getResultCode())) {
				throw new BusinessException(rep.getResponseHeader().getResultCode(),
						rep.getResponseHeader().getResultMessage());
			}
			List<GoJoin> list = rep.getGoJoins();
			responseData = new ResponseData<List<GoJoin>>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"操作成功", list);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			responseData = new ResponseData<List<GoJoin>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}
}
