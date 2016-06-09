package com.the.harbor.web.system.utils;

import com.the.harbor.commons.components.weixin.WXHelpUtil;

public class AliyunOSSTest {

	public static void main(String[] args) {
		String mediaId = "w9enyrJJsgmjJL33F7M176Z4dLIqihSZ8pwDFWAGzFYF_uMf7GW4cuZUyaQ6UyQN";
		String userId = "zhangchao";
		String fileName = WXHelpUtil.uploadUserAuthFileToOSS(mediaId, userId);
		System.out.println(fileName);
	}

}
