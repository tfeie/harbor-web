package com.the.harbor.web.system.wechatutils;

import java.io.InputStream;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.the.harbor.web.system.utils.StringUtil;
import com.the.harbor.web.system.wechatutils.req.BaseMessage;
import com.the.harbor.web.system.wechatutils.req.ImageMessage;
import com.the.harbor.web.system.wechatutils.req.VoiceMessage;
import com.the.harbor.web.system.wechatutils.res.Article;
import com.the.harbor.web.system.wechatutils.res.MusicMessage;
import com.the.harbor.web.system.wechatutils.res.NewsMessage;
import com.the.harbor.web.system.wechatutils.res.TextMessage;
import com.the.harbor.web.weixin.param.MenuClickRequest;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;

/**
 * 
 * @ClassName: MessageUtil
 * @Description: 消息处理工具类
 */
public class MessageUtil {
	
    private static Log log = LogFactory.getLog(MessageUtil.class);

    
	/**
	 * 绑定账户类型
	 */
	public static final String BIND_ACC_TYPE_WECHAT = "WECHAT";// 微信绑定
	
	/** 微信广告类 菜单前缀*/
	public static final String WX_AD_MENU_PERFIX = "AD_M_";
	
	/**
	 * @ClassName: RequestMsgType
	 * @Description: 请求消息类型
	 * */
	public class RequestMsgType {
		/** 请求消息类型：文本 */
		public static final String REQ_MESSAGE_TYPE_TEXT = "text";

		/** 请求消息类型：图片 */
		public static final String REQ_MESSAGE_TYPE_IMAGE = "image";

		/** 请求消息类型：语音 */
		public static final String REQ_MESSAGE_TYPE_VOICE = "voice";

		/** 请求消息类型：视频 */
		public static final String REQ_MESSAGE_TYPE_VIDEO = "video";

		/** 请求消息类型：小视频 */
		public static final String REQ_MESSAGE_TYPE_SVIDEO = "shortvideo";

		/** 请求消息类型：定位 */
		public static final String REQ_MESSAGE_TYPE_LOCATION = "location";

		/** 请求消息类型：链接 */
		public static final String REQ_MESSAGE_TYPE_LINK = "link";

		/** 请求消息类型：事件推送 */
		public static final String REQ_MESSAGE_TYPE_EVENT = "event";
	}

	/**
	 * @ClassName: ResponceMsgType
	 * @Description: 返回消息类型
	 * */
	public class ResponseMsgType {
		/** 返回消息类型：文本 */
		public static final String RESP_MESSAGE_TYPE_TEXT = "text";

		/** 返回消息类型：图片 */
		public static final String RESP_MESSAGE_TYPE_IMAGE = "image";

		/** 返回消息类型：语音 */
		public static final String RESP_MESSAGE_TYPE_VOICE = "voice";

		/** 返回消息类型：视频 */
		public static final String RESP_MESSAGE_TYPE_VIDEO = "video";

		/** 返回消息类型：音乐 */
		public static final String RESP_MESSAGE_TYPE_MUSIC = "music";

		/** 返回消息类型：图文 */
		public static final String RESP_MESSAGE_TYPE_NEWS = "news";
		
		/**返回消息类型 ：转发至多客服*/
		public static final String RESP_MESSAGE_TYPE_CUSTOMSERVICE = "transfer_customer_service";
	}

	/**
	 * @ClassName: EventType
	 * @Description: 事件类型定义
	 * */
	public class EventType {
		/** 事件类型：subscribe(订阅) */
		public static final String EVENT_TYPE_SUBSCRIBE = "subscribe";

		/** 事件类型：unsubscribe(取消订阅) */
		public static final String EVENT_TYPE_UNSUBSCRIBE = "unsubscribe";

		/** 事件类型：LOCATION(上报地理位置) */
		public static final String EVENT_TYPE_LOCATION = "LOCATION";

		/** 事件类型：CLICK(自定义菜单点击事件) */
		public static final String EVENT_TYPE_CLICK = "CLICK";

		/** 事件类型：VIEW(点击菜单跳转链接事件) */
		public static final String EVENT_TYPE_VIEW = "VIEW";
	}

	/**
	 * @ClassName: EventKey
	 * @Description: 事件KEY值定义
	 * */
	public class EventKey {
		/** 账单查询 */
		public static final String MVNE_ACCOUNT_SEARCH = "MVNE_ACCOUNT_SEARCH";

		/** 账户余额查询 */
		public static final String MVNE_USER_BALANCE_SEARCH = "MVNE_USER_BALANCE_SEARCH";

		/** 使用量查询 */
		public static final String MVNE_USAGE_REST_QUERY = "MVNE_USAGE_REST_QUERY";

		/** 产品订购查询 */
		public static final String MVNE_PRODUCT_ORDER_QUERY = "MVNE_PRODUCT_ORDER_QUERY";
		
		/** 产品订购与退订 */
		public static final String MVNE_PRODUCT_ORDER_UNSUBSCRIBE = "MVNE_PRODUCT_ORDER_UNSUBSCRIBE";

		/** 修改服务密码 */
		public static final String MVNE_CHANGE_SERVICE_PWD = "MVNE_CHANGE_SERVICE_PWD";

		/** 充值缴费 */
		public static final String MVNE_RECHARGE = "MVNE_RECHARGE";

		/**  */
		public static final String MVNE_COMBO_MARGIN_SEARCH = "MVNE_COMBO_MARGIN_SEARCH";

		/** 余量查询 */
		public static final String MVNE_RESOURCE_BALANCE_SEARCH = "MVNE_RESOURCE_BALANCE_SEARCH";

		/** 虚商简介 */
		public static final String MVNE_INTRODUCTION = "MVNE_INTRODUCTION";
		
		/** 其他信息1 */
		public static final String MVNE_OTHER_INFO_1 = "MVNE_OTHER_INFO_1";
		
		/** 其他信息2 */
		public static final String MVNE_OTHER_INFO_2 = "MVNE_OTHER_INFO_2";
		
		/** 其他信息3 */
		public static final String MVNE_OTHER_INFO_3 = "MVNE_OTHER_INFO_3";
	}
	
	public class AdMenuKey
	{
	    /** 中间菜单定义*/
        public static final String AD_M_MID_1 = "AD_M_MID_1";
        public static final String AD_M_MID_2 = "AD_M_MID_2";
        public static final String AD_M_MID_3 = "AD_M_MID_3";
        public static final String AD_M_MID_4 = "AD_M_MID_4";
        public static final String AD_M_MID_5 = "AD_M_MID_5";
	   
	    /** 右侧菜单定义*/
        public static final String AD_M_RIT_1 = "AD_M_RIT_1";
        public static final String AD_M_RIT_2 = "AD_M_RIT_2";
        public static final String AD_M_RIT_3 = "AD_M_RIT_3";
        public static final String AD_M_RIT_4 = "AD_M_RIT_4";
        public static final String AD_M_RIT_5 = "AD_M_RIT_5";
	}

	/**
	 * 解析微信发来的请求（XML）
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> parseXml(HttpServletRequest request)
			throws Exception {
		// 将解析结果存储在HashMap中
		Map<String, String> map = new HashMap<String, String>();

		// 从request中取得输入流
		InputStream inputStream = request.getInputStream();
		// 读取输入流
		SAXReader reader = new SAXReader();
		Document document = reader.read(inputStream);
		// 得到xml根元素
		Element root = document.getRootElement();
		// 得到根元素的所有子节点
		List<Element> elementList = root.elements();

		// 遍历所有子节点
		for (Element e : elementList)
			map.put(e.getName(), e.getText());

		// 释放资源
		inputStream.close();
		inputStream = null;

		return map;
	}

	/**
	 * 将微信的请求格式化成,MenuClickRequest对象
	 * 
	 * @throws Exception
	 */
	public static MenuClickRequest parseObject(HttpServletRequest request) {
		MenuClickRequest obj = new MenuClickRequest();
		Map<String, String> mapInfo = null;
		try {
			mapInfo = parseXml(request);
		} catch (Exception e) {
			log.info("[请求报文转换异常]:" + e.getMessage());
			e.printStackTrace();
		}
		if (mapInfo != null) {
			obj.setFromUserName(mapInfo.get("FromUserName"));
			obj.setToUserName(mapInfo.get("ToUserName"));
			obj.setMsgType(mapInfo.get("MsgType"));
			obj.setEvent(mapInfo.get("Event"));
			obj.setEventKey(mapInfo.get("EventKey"));
			if(!StringUtil.isBlank(mapInfo.get("Content"))){
				obj.setContent(mapInfo.get("Content"));
			}
		} else
			obj = null;
		return obj;
	}

	/**
	 * 文本消息对象转换成xml
	 * 
	 * @param textMessage
	 *            文本消息对象
	 * @return xml
	 */
	public static String textMessageToXml(TextMessage textMessage) {
		xstream.alias("xml", textMessage.getClass());
		return xstream.toXML(textMessage);
	}

	/**
	 * 通用消息对象转换成xml
	 * 
	 * @param textMessage
	 *            文本消息对象
	 * @return xml
	 */
	public static String baseMessageToXml(BaseMessage baseMessage) {
		xstream.alias("xml", baseMessage.getClass());
		return xstream.toXML(baseMessage);
	}
	
	/**
	 * 音乐消息对象转换成xml
	 * 
	 * @param musicMessage
	 *            音乐消息对象
	 * @return xml
	 */
	public static String musicMessageToXml(MusicMessage musicMessage) {
		xstream.alias("xml", musicMessage.getClass());
		return xstream.toXML(musicMessage);
	}
	
   /**
     * 图片消息对象转换成xml
     * 
     * @param imageMessage
     * 图片消息对象
     * @return xml
     */
    public static String imageMessageToXml(ImageMessage imageMessage) {
        xstream.alias("xml", imageMessage.getClass());
        return xstream.toXML(imageMessage);
    }
    
    /**
     * 声音消息对象转换成xml
     * 
     * @param voiceMessage
     * 声音消息对象
     * @return xml
     */
    public static String voiceMessageToXml(VoiceMessage voiceMessage) {
        xstream.alias("xml", voiceMessage.getClass());
        return xstream.toXML(voiceMessage);
    }

	/**
	 * 图文消息对象转换成xml
	 * 
	 * @param newsMessage
	 *            图文消息对象
	 * @return xml
	 */
	public static String newsMessageToXml(NewsMessage newsMessage) {
		xstream.alias("xml", newsMessage.getClass());
		xstream.alias("item", new Article().getClass());
		return xstream.toXML(newsMessage);
	}

	/**
	 * 扩展xstream，使其支持CDATA块
	 * 
	 * @date 2013-05-19
	 */
	private static XStream xstream = new XStream(new XppDriver() {
		public HierarchicalStreamWriter createWriter(Writer out) {
			return new PrettyPrintWriter(out) {
				// 对所有xml节点的转换都增加CDATA标记
				boolean cdata = true;

				@SuppressWarnings("unchecked")
				public void startNode(String name, Class clazz) {
					super.startNode(name, clazz);
				}

				protected void writeText(QuickWriter writer, String text) {
					if (cdata) {
						writer.write("<![CDATA[");
						writer.write(text);
						writer.write("]]>");
					} else {
						writer.write(text);
					}
				}
			};
		}
	});
	
    /*// 将配置中心的json转换成对应的消息
    public static String getConfigMsg(String cfjson, String eventKey, String fromUserName, String toUserName) {
        // 从配置中心读取该菜单 配置的返回消息
        // step 1.从配置中心读取配置 生成消息Map<String,BaseMessage>
        String menuConfig = UniConfig.getValue(cfjson, eventKey);
        if (StringUtil.isBlank(menuConfig)) {
            throw new BusinessException("无法找到"+cfjson+"的配置:"+eventKey);
        }
        JSONObject json = new JSONObject(menuConfig);
        String type = json.get("MsgType").toString();
        if (type.equals(MessageUtil.ResponseMsgType.RESP_MESSAGE_TYPE_TEXT)) {// 将配置解析为文本消息
            TextMessage textMessage = new TextMessage(fromUserName, toUserName);
            String content = json.optString("Content", "");
            try {
                content = new String(content.getBytes("ISO8859_1"), "UTF-8");
            } catch (UnsupportedEncodingException e) {
                content = "";
            }
            textMessage.setContent(content);
            return MessageUtil.textMessageToXml(textMessage);
        } else if (type.equals(MessageUtil.ResponseMsgType.RESP_MESSAGE_TYPE_NEWS)) {// 将配置解析为新闻消息
            NewsMessage newsMessage = new NewsMessage(fromUserName, toUserName);
            int articleCount = json.optInt("ArticleCount", 0);
            newsMessage.setArticleCount(articleCount);
            JSONArray articleJArray = json.optJSONArray("Articles");
            List<Article> articles = new ArrayList<Article>();
            for (int i = 0; articleJArray != null && i < articleJArray.length(); i++) {
                JSONObject articlejson = articleJArray.getJSONObject(i);
                Article article = new Article();
                String title = articlejson.optString("Title", "");
                String desc = articlejson.optString("Description", "");
                try {
                    title = new String(title.getBytes("ISO8859_1"), "UTF-8");
                    desc = new String(desc.getBytes("ISO8859_1"), "UTF-8");
                } catch (UnsupportedEncodingException e) {
                    title = "";
                    desc = "";
                }
                article.setTitle(title);
                article.setDescription(desc);
                article.setPicUrl(articlejson.optString("PicUrl", ""));
                article.setUrl(articlejson.optString("Url", ""));
                articles.add(article);
            }
            newsMessage.setArticles(articles);
            return MessageUtil.newsMessageToXml(newsMessage);
        } else if (type.equals(MessageUtil.ResponseMsgType.RESP_MESSAGE_TYPE_IMAGE)) {// 将配置解析为 图片消息
            ImageMessage imageMessage = new ImageMessage(fromUserName, toUserName);
            String mediaId = json.optString("MediaId", "");
            Media media = new Media(mediaId);
            imageMessage.setImage(media);
            ;
            return MessageUtil.imageMessageToXml(imageMessage);
        } else if (type.equals(MessageUtil.ResponseMsgType.RESP_MESSAGE_TYPE_VOICE)) {// 将配置解析为语音消息
            VoiceMessage voiceMessage = new VoiceMessage(fromUserName, toUserName);
            String mediaId = json.optString("MediaId", "");
            Media media = new Media(mediaId);
            voiceMessage.setVoice(media);
            return MessageUtil.voiceMessageToXml(voiceMessage);
        } else {// 其他类型消息处理
            return "";
        }
    }*/
}