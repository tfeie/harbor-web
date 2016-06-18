package com.the.harbor.web.pay.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.the.harbor.api.pay.IPaymentSV;
import com.the.harbor.api.pay.param.NotifyPaymentReq;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.exception.SystemException;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.util.RandomUtil;
import com.the.harbor.web.system.utils.CommonUtil;
import com.the.harbor.web.system.utils.WXRequestUtil;
import com.the.harbor.web.weixin.param.WeixinOauth2Token;

import net.sf.json.xml.XMLSerializer;

@RestController
@RequestMapping("/payment")
public class PaymentController {

	private static final Logger LOG = LoggerFactory.getLogger(PaymentController.class);

	/**
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getAuthorizeCode")
	public void getAuthorizeCode(HttpServletRequest request, HttpServletResponse response) {
		LOG.debug("支付授权==========开始===========");
		String orderId = request.getParameter("orderId");
		String orderAmount = request.getParameter("orderAmount");

		String backUri = "http://harbor.tfeie.com/payment/toPay";
		backUri = backUri + "?orderId=" + orderId + "&orderAmount=" + orderAmount;

		backUri = URLEncoder.encode(backUri);
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" + "appid=" + "wxbec41326662016d1"
				+ "&redirect_uri=" + backUri + "&response_type=code&scope=" + "snsapi_base"
				+ "&state=haigui#wechat_redirect";
		LOG.info("授权跳转！！！！");
		try {
			response.sendRedirect(url);
		} catch (IOException e) {
			LOG.error("授权失败！！！！", e);
		}
	}

	@RequestMapping(value = "/toPay")
	public ModelAndView toPay(HttpServletRequest request, HttpServletResponse response) {
		String orderId = request.getParameter("orderId");
		String orderAmount = request.getParameter("orderAmount");
		String code = request.getParameter("code");
		LOG.info("支付授权==========结束===========:orderId=" + orderId + ",orderAmount=" + orderAmount + ",code=" + code);
		WeixinOauth2Token wtoken = WXRequestUtil.refreshAccessToken(code);
		if (wtoken == null) {
			LOG.error("获取token失败");
			request.setAttribute("errmsg", "获取token失败");
			ModelAndView view = new ModelAndView("pay/error");
			return view;
		}

		String openId = wtoken.getOpenId();
		LOG.info("支付授权openid=" + openId);
		String notifyUrl = "http://harbor.tfeie.com/payment/notifyUrl";
		JSONObject json = WXRequestUtil.wxUnifiedorder(openId, notifyUrl, request);
		if ("FAILD".equals(json.getString("STATE"))) {
			LOG.error("获取预支付流水失败");
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
		LOG.info("支付参数：" + JSONObject.toJSONString(finalpackage));
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
		LOG.info("==================订单支付 开始调用后台通知=======================================");
		String notityXml = "";
		String inputLine;
		PrintWriter printWriter = null;
		HashMap<String, String> remap = new HashMap<String, String>();
		remap.put("return_code", "SUCCESS");
		remap.put("return_msg", "OK");
		try {
			try {
				while ((inputLine = request.getReader().readLine()) != null) {
					notityXml += inputLine;
				}
				request.getReader().close();
			} catch (Exception e) {
				e.printStackTrace();
				request.getReader().close();
			}

			LOG.error("订单支付返回：" + notityXml);
			printWriter = response.getWriter();
			String jsonStr = new XMLSerializer().read(notityXml).toString();
			JSONObject data = JSON.parseObject(jsonStr);
			String returnCode = data.getString("return_code");
			String resultCode = data.getString("result_code");
			if ("SUCCESS".equals(resultCode) && "SUCCESS".equals(returnCode)) {
				// 交易失败处理
			}
			// 遍历jsonObject数据，添加到Map对象
			SortedMap<String, Object> map = new TreeMap<String, Object>();
			for (java.util.Map.Entry<String, Object> entry : data.entrySet()) {
				map.put(entry.getKey(), entry.getValue());
			}

			// 校验签名
			String sign = map.get("sign").toString();
			map.remove("sign");
			String paysecret = GlobalSettings.getWeiXinPaySecret();
			String signcheck = WXHelpUtil.createSign(map, paysecret);
			if (!sign.equals(signcheck)) {
				LOG.info("支付回调签名错误");
				throw new BusinessException("", "签名错误");
			}

			// 判断订单是否处理过

			// 业务逻辑处理

			String rexml = CommonUtil.ArrayToXml(remap);
			LOG.info("支付回调返回xml:" + rexml);
			printWriter.write(rexml);
			printWriter.flush();
			printWriter.close();
		} catch (Exception e) {
			remap.put("return_code", "FAIL");
			remap.put("return_msg", e.getMessage());
			String rexml = CommonUtil.ArrayToXml(remap);
			printWriter.write(rexml);
			printWriter.flush();
			printWriter.close();
		} finally {
			if (printWriter != null) {
				printWriter.close();
			}
		}
	}

	@RequestMapping(value = "/notifyPayResult")
	public void notifyPayResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOG.info("开始处理支付平台结果回调");
		PrintWriter printWriter = response.getWriter();
		HashMap<String, String> remap = new HashMap<String, String>();
		String inputLine;
		try {
			StringBuffer sb = new StringBuffer();
			try {
				while ((inputLine = request.getReader().readLine()) != null) {
					sb.append(inputLine);
				}
			} catch (Exception ex) {
				throw new SystemException("读取通知结果异常信息:" + ex.getMessage());
			} finally {
				request.getReader().close();
			}
			String jsonStr = new XMLSerializer().read(sb.toString()).toString();
			JSONObject data = JSON.parseObject(jsonStr);
			if (data == null) {
				throw new SystemException("读取通知结果转换错误");
			}
			LOG.debug("支付平台支付结果通知的数据包:" + data.toJSONString());
			if ("FAIL".equals(data.getString("return_code"))) {
				throw new SystemException("微信通知结果return_code=FAIL，业务系统无法正常处理");
			}
			// 解析入库操作
			NotifyPaymentReq req = new NotifyPaymentReq();
			req.setNotifyParam(data.toJSONString());
			req.setPayOrderId(data.getString("out_trade_no"));
			req.setResultCode(data.getString("result_code"));
			req.setReturnCode(data.getString("return_code"));
			req.setReturnMsg(data.getString("return_msg	"));
			req.setTimeEnd(data.getString("time_end"));
			req.setTransactionId(data.getString("transaction_id"));
			Response resp = DubboConsumerFactory.getService(IPaymentSV.class).notifyPayResult(req);
			if (!ExceptCodeConstants.SUCCESS.equals(resp.getResponseHeader().getResultCode())) {
				remap.put("return_code", "FAIL");
				remap.put("return_msg", resp.getResponseHeader().getResultMessage());
			} else {
				remap.put("return_code", "SUCCESS");
				remap.put("return_msg", "OK");
			}
			String rexml = CommonUtil.ArrayToXml(remap);
			LOG.info("支付回调返回xml:" + rexml);
			printWriter.write(rexml);
			printWriter.flush();
			printWriter.close();
		} catch (Exception e) {
			remap.put("return_code", "FAIL");
			remap.put("return_msg", "支付回调结果处理异常:" + e.getMessage());
			String rexml = CommonUtil.ArrayToXml(remap);
			printWriter.write(rexml);
			printWriter.flush();
		} finally {
			if (printWriter != null) {
				printWriter.close();
			}
		}

	}
	
	
	@RequestMapping("/success.html")
	public ModelAndView success(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView view = new ModelAndView("pay/success");
		return view;
	}

}
