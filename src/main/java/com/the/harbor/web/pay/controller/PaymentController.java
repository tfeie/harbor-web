package com.the.harbor.web.pay.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
    private static final Logger log = Logger.getLogger(PaymentController.class);

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
		}
		
		String openId = wtoken.getOpenId();
		log.info("支付授权openid="+openId);
		String notifyUrl = "http://harbor.tfeie.com/payment/notifyUrl";
		JSONObject json = WXRequestUtil.wxUnifiedorder(openId,notifyUrl,request);
		if("FAILD".equals(json.getString("STATE"))) {
			log.error("获取预支付流水失败");
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
	
}
