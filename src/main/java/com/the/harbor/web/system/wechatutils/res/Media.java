package com.the.harbor.web.system.wechatutils.res;

/**
 */
public class Media {

	// 素材id
	private String MediaId;
	
	public Media(){}
	public Media(String mid)
	{
	    MediaId = mid;
	}

    public String getMediaId() {
        return MediaId;
    }

    public void setMediaId(String mediaId) {
        MediaId = mediaId;
    }

}
