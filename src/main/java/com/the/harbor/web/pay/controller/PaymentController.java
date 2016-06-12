package com.the.harbor.web.pay.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.xml.XMLSerializer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.util.RandomUtil;
import com.the.harbor.web.system.utils.CommonUtil;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;

@RestController
@RequestMapping("/payment")
public class PaymentController {
	private static final Log log = LogFactory.getLog(PaymentController.class);

	/**
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getAuthorizeCode")
	public void getAuthorizeCode(HttpServletRequest request, HttpServletResponse response) {
		log.debug("支付授权==========开始===========");
		String orderId = request.getParameter("orderId");
		String orderAmount = request.getParameter("orderAmount");

		String backUri = "http://harbor.tfeie.com/payment/toPay";
		backUri = backUri + "?orderId=" + orderId + "&orderAmount=" + orderAmount;

		backUri = URLEncoder.encode(backUri);
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" + "appid=" + "wxbec41326662016d1"
				+ "&redirect_uri=" + backUri + "&response_type=code&scope=" + "snsapi_base"
				+ "&state=haigui#wechat_redirect";
		log.info("授权跳转！！！！");
		try {
			response.sendRedirect(url);
		} catch (IOException e) {
			log.error("授权失败！！！！", e);
		}
	}

	@RequestMapping(value = "/toPay")
	public ModelAndView toPay(HttpServletRequest request, HttpServletResponse response) {
		String orderId = request.getParameter("orderId");
		String orderAmount = request.getParameter("orderAmount");
		String code = request.getParameter("code");
		log.info("支付授权==========结束===========:orderId=" + orderId + ",orderAmount=" + orderAmount + ",code=" + code);
		WeixinOauth2Token wtoken = WXRequestUtil.refreshAccessToken(code);
		if (wtoken == null) {
			log.error("获取token失败");
			request.setAttribute("errmsg", "获取token失败");
			ModelAndView view = new ModelAndView("pay/error");
			return view;
		}

		String openId = wtoken.getOpenId();
		log.info("支付授权openid=" + openId);
		String notifyUrl = "http://harbor.tfeie.com/payment/notifyUrl";
		JSONObject json = WXRequestUtil.wxUnifiedorder(openId, notifyUrl, request);
		if ("FAILD".equals(json.getString("STATE"))) {
			log.error("获取预支付流水失败");
			request.setAttribute("errmsg", "获取预支付流水失败");
			ModelAndView view = new ModelAndView("pay/error");
			return view;
		}
		String nonceStr = RandomUtil.generateString(32);
		String timestamp = String.valueOf(System.currentTimeMillis() / 1000);
		SortedMap<String, String> finalpackage = new TreeMap<String, String>();
		finalpackage.put("appId", "wxbec41326662016d1");
		finalpackage.put("timeStamp", timestamp);
		finalpackage.put("nonceStr", nonceStr);
		finalpackage.put("package", "prepay_id=" + json.get("MSG"));
		finalpackage.put("signType", "MD5");
		String finalSign = CommonUtil.createSign(finalpackage, "Tgbnhy21qwerty39jjygbnh77ijnbvcx");
		finalpackage.put("sign", finalSign);
		log.info("支付参数：" + JSONObject.toJSONString(finalpackage));
		/* 组织跳转密码输入页面参数 */
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
	public void notifyUrl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("==================订单支付 开始调用后台通知=======================================");
		String notityXml = "";
		String inputLine;
        PrintWriter printWriter = null;
        HashMap<String,String> remap = new HashMap<String,String>();
        remap.put("return_code", "SUCCESS");
		remap.put("return_msg", "OK");
		try {
			try {
				while ((inputLine = request.getReader().readLine()) != null) 
				{
					notityXml += inputLine;
				}
				request.getReader().close();
			} catch (Exception e) {
				e.printStackTrace();
				request.getReader().close();
			}
			
			log.error("订单支付返回：" + notityXml);
            printWriter = response.getWriter();
			String jsonStr = new XMLSerializer().read(notityXml).toString();
			JSONObject data = JSON.parseObject(jsonStr);
		    // 遍历jsonObject数据，添加到Map对象  
			SortedMap<String, Object> map = new TreeMap<String, Object>();
			for(java.util.Map.Entry<String,Object> entry:data.entrySet()){
				map.put(entry.getKey(), entry.getValue());  
	        }
			if("FAIL".equals(map.get("return_code")) || 
					(map.containsKey("result_code") && "FAIL".equals(map.get("result_code")))) {
				// 交易失败处理
			}
			// 判断订单是否处理过
			
			//校验签名
			String sign = map.get("sign").toString();
			map.remove("sign");
			String paysecret = GlobalSettings.getWeiXinPaySecret();
			String signcheck = WXHelpUtil.createSign(map, paysecret);
			if(!sign.equals(signcheck)) {
				log.info("支付回调签名错误");
				throw new BusinessException("","签名错误");
			}
			
			// 业务逻辑处理
			
			String rexml = CommonUtil.ArrayToXml(remap);
			log.info("支付回调返回xml:" + rexml);
			printWriter.write(rexml);
			printWriter.flush();
			printWriter.close();
		} catch(Exception e) {
			remap.put("return_code", "FAIL");
			remap.put("return_msg", e.getMessage());
			String rexml = CommonUtil.ArrayToXml(remap);
			printWriter.write(rexml);
			printWriter.flush();
			printWriter.close();
		}finally{
			if(printWriter != null){
				printWriter.close();
			}
		}
	}

}
