package com.the.harbor.web.util;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.mns.client.CloudQueue;
import com.aliyun.mns.client.MNSClient;
import com.aliyun.mns.common.ClientException;
import com.aliyun.mns.common.ServiceException;
import com.aliyun.mns.model.Message;
import com.the.harbor.api.user.param.DoUserFans;
import com.the.harbor.api.user.param.DoUserFriend;
import com.the.harbor.base.enumeration.mns.MQType;
import com.the.harbor.commons.components.aliyuncs.mns.MNSFactory;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.util.UUIDUtil;

public class UserInteractionMQSend {

	private static final Logger LOG = Logger.getLogger(UserInteractionMQSend.class);

	public static void sendMQ(DoUserFans body) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_USER_FANS.getValue());
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserInteractionQueueName());
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
			LOG.error("user fans message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

	public static void sendMQ(DoUserFriend body) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_USER_FRIEND.getValue());
			CloudQueue queue = client.getQueueRef(GlobalSettings.getUserInteractionQueueName());
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
			LOG.error("user friend message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

}
