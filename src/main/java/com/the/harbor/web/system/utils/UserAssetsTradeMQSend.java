package com.the.harbor.web.system.utils;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.mns.client.CloudQueue;
import com.aliyun.mns.client.MNSClient;
import com.aliyun.mns.common.ClientException;
import com.aliyun.mns.common.ServiceException;
import com.aliyun.mns.model.Message;
import com.the.harbor.api.user.param.DoUserAssetsTrade;
import com.the.harbor.commons.components.aliyuncs.mns.MNSFactory;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;

public class UserAssetsTradeMQSend {

	private static final Logger LOG = Logger.getLogger(UserAssetsTradeMQSend.class);

	public static void sendMQ(DoUserAssetsTrade body) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserAssetsTradeQueueName());
			Message message = new Message();
			message.setMessageBody(JSONObject.toJSONString(body));
			queue.putMessage(message);
		} catch (ClientException ce) {
			LOG.error("Something wrong with the network connection between client and MNS service."
					+ "Please check your network and DNS availablity.", ce);
		} catch (ServiceException se) {
			if (se.getErrorCode().equals("QueueNotExist")) {
				LOG.error("Queue is not exist.Please create before use", se);
			} else if (se.getErrorCode().equals("TimeExpired")) {
				LOG.error("The request is time expired. Please check your local machine timeclock", se);
			}
			LOG.error("user assets trade message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

}
