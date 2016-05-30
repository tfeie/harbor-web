package com.the.harbor.web.system.wechatutils.res;

import java.util.Date;

import com.the.harbor.web.system.wechatutils.MessageUtil;


/**
 * 
* @ClassName: VoiceMessage 
 */
public class VoiceMessage extends BaseMessage {

	// 媒体ID
    private Media Voice;
    
    public VoiceMessage(){}
    public VoiceMessage(String fromUserName, String toUserName)
    {
        this.setFromUserName(fromUserName);
        this.setToUserName(toUserName);
        this.setCreateTime(new Date().getTime());
        this.setMsgType(MessageUtil.ResponseMsgType.RESP_MESSAGE_TYPE_VOICE);
    }
    
    public Media getVoice() {
        return Voice;
    }

    public void setVoice(Media voice) {
        Voice = voice;
    }
}
