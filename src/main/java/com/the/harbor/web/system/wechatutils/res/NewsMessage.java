package com.the.harbor.web.system.wechatutils.res;

import java.util.Date;
import java.util.List;

import com.the.harbor.web.system.wechatutils.MessageUtil;


public class NewsMessage extends BaseMessage {
    
    public NewsMessage(String fromUserName, String toUserName){
        this.setFromUserName(fromUserName);
        this.setToUserName(toUserName);
        this.setCreateTime(new Date().getTime());
        this.setMsgType(MessageUtil.ResponseMsgType.RESP_MESSAGE_TYPE_NEWS);
    }
    public NewsMessage(){
        
    }
	// 图文消息个数，限制为10条以内
	private int ArticleCount;
	// 多条图文消息信息，默认第一个item为大图
	private List<Article> Articles;

	public int getArticleCount() {
		return ArticleCount;
	}

	public void setArticleCount(int articleCount) {
		ArticleCount = articleCount;
	}

	public List<Article> getArticles() {
		return Articles;
	}

	public void setArticles(List<Article> articles) {
		Articles = articles;
	}
}
