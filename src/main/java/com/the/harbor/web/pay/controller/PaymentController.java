package com.the.harbor.web.pay.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.the.harbor.web.pay.param.WeixinOauth2Token;
import com.the.harbor.web.system.utils.CommonUtil;
import com.the.harbor.web.system.utils.StringUtil;
import com.the.harbor.web.system.utils.WXRequestUtil;


@RestController
@RequestMapping("/payment")
public class PaymentController {
	private static final Log log = LogFactory.getLog(PaymentController.class);

	@RequestMapping(value="/creatOrder")
	public @ResponseBody Object creatOrder(HttpServletRequest request) {
		Map result = new HashMap();
		try {
			log.debug("生成订单开始========");
		} catch(Exception ex) {
			
		}
		
		return result;
	}
	
	@RequestMapping(value="/testpay")
	public ModelAndView testpay(HttpServletRequest request) {
		log.debug("支付开始================");
		ModelAndView view = new ModelAndView("pay/payment");
        return view;
	}
	
	/**
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getAuthorizeCode")
	public void getAuthorizeCode(HttpServletRequest request,HttpServletResponse response) {
		log.debug("支付授权==========开始===========");
		String orderId = request.getParameter("orderId");
		String orderAmount = request.getParameter("orderAmount");

		String backUri = "http://harbor.tfeie.com/payment/toPay";
		backUri = backUri + "?orderId="+ orderId + "&orderAmount=" + orderAmount;
                
		backUri = URLEncoder.encode(backUri);
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?"
                + "appid="
                + "wxbec41326662016d1"
                + "&redirect_uri="
                + backUri
                + "&response_type=code&scope="
                + "snsapi_base"
                + "&state=haigui#wechat_redirect";
        log.info("授权跳转！！！！");
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            log.error("授权失败！！！！",e);
        }
	}
	
	@RequestMapping(value="/toPay")
	public ModelAndView toPay(HttpServletRequest request,HttpServletResponse response) {
		String orderId = request.getParameter("orderId");
		String orderAmount = request.getParameter("orderAmount");
		String code = request.getParameter("code");
		log.info("支付授权==========结束===========:orderId=" + 
				orderId + ",orderAmount=" + orderAmount + ",code=" + code);
		WeixinOauth2Token wtoken = WXRequestUtil.refreshAccessToken(code);
		if(wtoken == null) {
			log.error("获取token失败");
			request.setAttribute("errmsg", "获取token失败");
			ModelAndView view = new ModelAndView("pay/error");
			return view;
		}
		
		String openId = wtoken.getOpenId();
		log.info("支付授权openid="+openId);
		String notifyUrl = "http://harbor.tfeie.com/payment/notifyUrl";
		JSONObject json = WXRequestUtil.wxUnifiedorder(openId,notifyUrl,request);
		if("FAILD".equals(json.getString("STATE"))) {
			log.error("获取预支付流水失败");
			request.setAttribute("errmsg", "获取预支付流水失败");
			ModelAndView view = new ModelAndView("pay/error");
			return view;
		}
		String nonceStr = StringUtil.getRandomNumStr();
		String timestamp = String.valueOf(System.currentTimeMillis() / 1000);
		SortedMap<String, String> finalpackage = new TreeMap<String, String>();
        finalpackage.put("appId","wxbec41326662016d1");
        finalpackage.put("timeStamp", timestamp);
        finalpackage.put("nonceStr", nonceStr);
        finalpackage.put("package", "prepay_id=" + json.get("MSG"));
        finalpackage.put("signType", "MD5");
        String finalSign = CommonUtil.createSign(finalpackage,"Tgbnhy21qwerty39jjygbnh77ijnbvcx");
        finalpackage.put("sign", finalSign);
        log.info("支付参数：" + JSONObject.toJSONString(finalpackage));
        /*组织跳转密码输入页面参数*/
        request.setAttribute("appId", "wxbec41326662016d1");
        request.setAttribute("timeStamp", timestamp);
        request.setAttribute("nonceStr", nonceStr);
        request.setAttribute("packageValue", "prepay_id=" + json.get("MSG"));
        request.setAttribute("signType", "MD5");
        request.setAttribute("sign", finalSign);
		ModelAndView view = new ModelAndView("pay/topay");
	    return view;
	}
	
	@RequestMapping(value = "/notifyUrl")
    public void notifyUrl(HttpServletRequest request, HttpServletResponse response)throws Exception {
        log.info("==================订单支付 开始调用后台通知=======================================");
        /**************************************从返回报文中获取数据****************************************/
        String outOrderId_ = request.getParameter("outOrderId");             //  第三方支付平台交易流水号
        String orderId_ = request.getParameter("orderId");                   //  订单号
        String subject_ = request.getParameter("subject");                   //  订单名称
        String orderAmount_ = request.getParameter("orderAmount");           //  订单金额
        String payStates_ = request.getParameter("payStates");               //  交易状态
        String notifyTime_ = request.getParameter("notifyTime");             //  交易时间
        String payType_ = request.getParameter("payType");                   //  交易类型
        String infoMd5_ = request.getParameter("infoMd5");                   //  加密信息
        
        log.info("第三方支付平台交易流水号："+outOrderId_);
        log.info("订单号："+orderId_);
        log.info("订单名称："+subject_);
        log.info("订单金额："+orderAmount_);
        log.info("交易状态："+payStates_);
        log.info("交易时间："+notifyTime_);
        log.info("交易类型："+payType_);
        log.info("加密信息："+infoMd5_);
        
        log.error("加密信息不匹配：orderId="+orderId_);
        //response.getWriter().print("error");
        return;
	}
	
}
