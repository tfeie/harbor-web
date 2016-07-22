package com.the.harbor.web.weixin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.the.harbor.commons.util.StringUtil;
import com.the.harbor.web.system.utils.CommonUtil;
import com.the.harbor.web.system.wechatutils.MessageUtil;
import com.the.harbor.web.system.wechatutils.res.TextMessage;
import com.the.harbor.web.weixin.param.MenuClickRequest;

@Controller
@RequestMapping("/harbor")
public class WeiXinCoreController {
	
    private static Log log = LogFactory.getLog(WeiXinCoreController.class);
    
    private static String POST_REQUEST = "POST";

    private static String GET_REQUEST = "GET";
	/**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/entrance")
    public void customComplain(HttpServletRequest request, HttpServletResponse response) {
        try {
            String method = request.getMethod();
            if (method.endsWith(GET_REQUEST)) {
                log.info("来自微信的 GET请求");
                this.doGet(request, response);
            } else if (method.endsWith(POST_REQUEST)) {
                log.info("来着微信的 POST请求");
                this.doPost(request, response);
            }
            log.info("微信请求结束");
        } catch (Exception e) {
            log.error("请求异常：" + e);
        }
    }
    
    /**
     * 确认请求来自微信服务器
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String,String> msg = new HashMap<String,String>();
        // 微信加密签名
        String signature = request.getParameter("signature");
        // 时间戳
        String timestamp = request.getParameter("timestamp");
        // 随机数
        String nonce = request.getParameter("nonce");
        // 随机字符串
        String echostr = request.getParameter("echostr");
        PrintWriter out = response.getWriter();
        log.info("微信验证连接成功");
        msg.put("signatura", signature);
        msg.put("timestamp", timestamp);
        msg.put("nonce", nonce);
        msg.put("echostr", echostr);
        log.info(msg.toString());
        // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
        if (CommonUtil.checkSignature(signature, timestamp, nonce)) {
        	log.debug("自微信服务器GET请求校验成功");
            out.print(echostr);
        }
        out.close();
        out = null;
    }
    
    /**
     * 处理微信服务器发来的消息
     * 
     * @throws Exception
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        // response.setCharacterEncoding("UTF-8");
        String respMessage = "";
        MenuClickRequest requestObject = MessageUtil.parseObject(request);
        log.info("微信请求参数： " + JSONObject.toJSONString(requestObject));
        if (requestObject == null) {
            log.error("请求异常,未能得到请求参数.");
            return;
        }
        // 事件类消息
        if (MessageUtil.RequestMsgType.REQ_MESSAGE_TYPE_EVENT.equals(requestObject.getMsgType())) {
            // 订阅事件
            if (MessageUtil.EventType.EVENT_TYPE_SUBSCRIBE.equals(requestObject.getEvent())) {
                //订阅之后推送欢迎页.
            	String fromUserName = requestObject.getFromUserName();
            	String toUserName = requestObject.getToUserName();
        		// 默认返回的文本消息内容
        		StringBuffer respContent = new StringBuffer();
        		TextMessage textMessage = new TextMessage(fromUserName,toUserName);
        		textMessage.setToUserName(fromUserName);
        		textMessage.setFromUserName(toUserName);
        		respContent.append("感谢您的关注，海归港湾欢迎您！\r\n");
        		textMessage.setContent(respContent.toString());
        		respMessage = MessageUtil.textMessageToXml(textMessage);
            }
            // 退订事件
            if (MessageUtil.EventType.EVENT_TYPE_UNSUBSCRIBE.equals(requestObject.getEvent())) {
                // 退订解绑关系
            }
            // 点击类事件
            if (MessageUtil.EventType.EVENT_TYPE_CLICK.equals(requestObject.getEvent())) {
                // 根据事件KEY来处理点击事物.;
            }
            // 跳转类事件
            if (MessageUtil.EventType.EVENT_TYPE_VIEW.equals(requestObject.getEvent())) {
                // 根据事件KEY来处理点击事物.;
                
            }
        }else {// 其他类型消息统一从这里回复 有业务之后再拆分
        	if (MessageUtil.RequestMsgType.REQ_MESSAGE_TYPE_TEXT.equals(requestObject.getMsgType())){
        		log.info("++++++++++++++自动回复开始fromUserName:"+requestObject.getFromUserName()+"toUserName:"+requestObject.getToUserName()+"content:"+requestObject.getContent());
        		respMessage = MessageUtil.getConfigMsg("", "", requestObject.getToUserName(), requestObject.getFromUserName());
            	log.info("++++++++++++++自动回复结束:"+respMessage);
            }
        	if (StringUtil.isBlank(respMessage)){
        		log.info("++++++++++++++转发多客服开始");
        		log.info("++++++++++++++转发多客服结束:respMessage:"+respMessage);
        	}
        }
        PrintWriter out = response.getWriter();
        out.print(respMessage);
        out.close();
    }
}
