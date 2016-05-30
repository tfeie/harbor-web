package com.the.harbor.web.system.wechatutils.req;

/**
* @Title: ImageMessage.java 
* @Package com.ailk.weixin.crm.message.req 
* @Description: 图片消息
* @author lifeng lifeng3@asiainfo.com
* @date 2014年9月3日 下午4:07:51 
* @version V1.0
 */
public class ImageMessage extends BaseMessage {

	// 图片链接
	private String PicUrl;

	public String getPicUrl() {
		return PicUrl;
	}

	public void setPicUrl(String picUrl) {
		PicUrl = picUrl;
	}
}
