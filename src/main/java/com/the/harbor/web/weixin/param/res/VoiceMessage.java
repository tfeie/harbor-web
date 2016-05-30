package com.the.harbor.web.weixin.param.res;

import java.util.Date;

import com.the.harbor.web.system.wechatutils.MessageConstants;


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
        this.setMsgType(MessageConstants.ResponseMsgType.RESP_MESSAGE_TYPE_VOICE);
    }
    
    public Media getVoice() {
        return Voice;
    }

    public void setVoice(Media voice) {
        Voice = voice;
    }
}
