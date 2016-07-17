package com.the.harbor.web.util;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.mns.client.CloudQueue;
import com.aliyun.mns.client.MNSClient;
import com.aliyun.mns.common.ClientException;
import com.aliyun.mns.common.ServiceException;
import com.aliyun.mns.model.Message;
import com.the.harbor.api.be.param.DoBeFavorite;
import com.the.harbor.api.go.param.DoGoFavorite;
import com.the.harbor.base.enumeration.mns.MQType;
import com.the.harbor.commons.components.aliyuncs.mns.MNSFactory;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.util.UUIDUtil;

public class UserFavorMQSend {

	private static final Logger LOG = Logger.getLogger(UserFavorMQSend.class);

	public static void sendMQ(DoBeFavorite body) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_BE_FAVORITE.getValue());
			CloudQueue queue = client.getQueueRef(GlobalSettings.getFavorQueueName());
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
			LOG.error("be favor message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

	public static void sendMQ(DoGoFavorite body) {
		MNSClient client = MNSFactory.getMNSClient();
		try {
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_GO_FAVORITE.getValue());
			CloudQueue queue = client.getQueueRef(GlobalSettings.getFavorQueueName());
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
			LOG.error("go favor message put in Queue error", se);
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
		}
		client.close();
	}

}
