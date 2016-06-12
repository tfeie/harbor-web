package com.the.harbor.web.go.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.util.DateUtil;
import com.the.harbor.commons.util.ExceptionUtil;
import com.the.harbor.commons.util.RandomUtil;
import com.the.harbor.commons.web.model.ResponseData;

@RestController
@RequestMapping("/go")
public class GoController {

	private static final Logger LOG = Logger.getLogger(GoController.class);

	@RequestMapping("/toConfirm.html")
	public ModelAndView toConfirm(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/confirm");
		return view;
	}

	@RequestMapping("/toOrder.html")
	public ModelAndView toOrder(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/order");
		return view;
	}

	@RequestMapping("/toAppointment.html")
	public ModelAndView toAppointment(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/appointment");
		return view;
	}
	
	@RequestMapping("/toPay.html")
	public ModelAndView toPay(HttpServletRequest request) {
		String payamount = "0.01";
		long timestamp = DateUtil.getCurrentTimeMillis();
		String nonceStr = WXHelpUtil.createNoncestr();
		String jsapiTicket = WXHelpUtil.getJSAPITicket();
		String url = "http://harbor.tfeie.com/go/toPay.html";
		String signature = WXHelpUtil.createJSSDKSignatureSHA(nonceStr, jsapiTicket, timestamp, url);
		request.setAttribute("appId", GlobalSettings.getWeiXinAppId());
		request.setAttribute("timestamp", timestamp);
		request.setAttribute("nonceStr", nonceStr);
		request.setAttribute("signature", signature);
		request.setAttribute("payamount", payamount);
		ModelAndView view = new ModelAndView("go/pay");
		return view;
	}
	
	@RequestMapping("/createPayOrder")
	@ResponseBody
	public ResponseData<JSONObject> createPayOrder(HttpServletRequest request){
		ResponseData<JSONObject> responseData = null;
		LOG.info("预约支付===============开始=====================");
		try{
			String price = request.getParameter("price");
			String nonceStr = request.getParameter("nonceStr");
			long timestamp = DateUtil.getCurrentTimeMillis();
			String orderId = RandomUtil.generateNumber(32);	
			String notifyUrl = "http://harbor.tfeie.com/payment/notifyUrl";
			String pkg = WXHelpUtil.getPackageOfWXJSSDKChoosePayAPI("购买", orderId,
					Integer.parseInt(price), request.getRemoteAddr(), "oztCUs7prwrkXp4tWsntCfg5fWpw",
					notifyUrl, nonceStr);
			LOG.info("支付订单：" + pkg);

			String paySign = WXHelpUtil.getPaySignOfWXJSSDKChoosePayAPI(String.valueOf(timestamp), nonceStr, pkg);
			JSONObject d = new JSONObject();
			d.put("package", pkg);
			d.put("paySign", paySign);
			d.put("timestamp", timestamp);
			LOG.info("支付参数：" + d.toJSONString());
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, "处理成功", d);

		} catch (Exception e) {
			LOG.error(e);
			LOG.info("支付失败：" + e.getMessage() +"e:" + e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		
		return responseData;
	}
	
	@RequestMapping("/publishGo.html")
	public ModelAndView publishGo(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/publishgo");
		return view;
	}
	
	@RequestMapping("/toFeedback.html")
	public ModelAndView toFeedback(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/feedback");
		return view;
	}
	
	@RequestMapping("/confirmlist.html")
	public ModelAndView confirmlist(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/confirmlist");
		return view;
	}
	
	@RequestMapping("/godetail.html")
	public ModelAndView godetail(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/godetail");
		return view;
	}

	
	@RequestMapping("/groupindex.html")
	public ModelAndView groupindex(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/groupindex");
		return view;
	}
	
	@RequestMapping("/oneononeindex.html")
	public ModelAndView oneononeindex(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/oneononeindex");
		return view;
	}
	
	@RequestMapping("/comments.html")
	public ModelAndView comments(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/comments");
		return view;
	}
	
	@RequestMapping("/invite.html")
	public ModelAndView invite(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/invite");
		return view;
	}
	
	@RequestMapping("/invite2.html")
	public ModelAndView invite2(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/invite2");
		return view;
	}
}
