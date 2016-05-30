package com.the.harbor.web.system.wechatutils.req;

/**
 * 
* @ClassName: LinkMessage 
* @Description: 链接消息
* @author lifeng lifeng3@asiainfo.com
* @date 2014年9月3日 下午5:15:01
 */
public class LinkMessage extends BaseMessage {

	// 消息标题
	private String Title;
	// 消息描述
	private String Description;
	// 消息链接
	private String Url;

	public String getTitle() {
		return Title;
	}

	public void setTitle(String title) {
		Title = title;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public String getUrl() {
		return Url;
	}

	public void setUrl(String url) {
		Url = url;
	}
}

