package com.the.harbor.web.weixin.param.req;

/**
 * 
* @ClassName: VoiceMessage 
* @Description: 文本消息
* @author lifeng lifeng3@asiainfo.com
* @date 2014年9月3日 下午5:15:43
 */
public class VoiceMessage extends BaseMessage {

	// 媒体ID
	private String MediaId;
	// 语音格式
	private String Format;

	public String getMediaId() {
		return MediaId;
	}

	public void setMediaId(String mediaId) {
		MediaId = mediaId;
	}

	public String getFormat() {
		return Format;
	}

	public void setFormat(String format) {
		Format = format;
	}
}
