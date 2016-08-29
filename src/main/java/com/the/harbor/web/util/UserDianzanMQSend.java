package com.the.harbor.web.util;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.mns.client.CloudQueue;
import com.aliyun.mns.client.MNSClient;
import com.aliyun.mns.common.ClientException;
import com.aliyun.mns.common.ServiceException;
import com.aliyun.mns.model.Message;
import com.the.harbor.api.be.param.DoBeLikes;
import com.the.harbor.base.enumeration.mns.MQType;
import com.the.harbor.commons.components.aliyuncs.mns.MNSFactory;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.indices.mq.MNSRecord;
import com.the.harbor.commons.indices.mq.MNSRecordHandle;
import com.the.harbor.commons.util.UUIDUtil;

public class UserDianzanMQSend {

	private static final Logger LOG = Logger.getLogger(UserDianzanMQSend.class);

	public static void sendMQ(DoBeLikes body) {
		MNSClient client = MNSFactory.getMNSClient();
		String sendStatus = MNSRecord.Status.SEND_SUCCESS.name();
		String sendError = null;
		try {
			body.setMqId(UUIDUtil.genId32());
			body.setMqType(MQType.MQ_HY_BE_LIKES.getValue());
			CloudQueue queue = client.getQueueRef(GlobalSettings.getDianzanQueueName());
			Message message = new Message();
			message.setMessageBody(JSONObject.toJSONString(body));
			queue.putMessage(message);
		} catch (ClientException ce) {
			sendStatus = MNSRecord.Status.SEND_FAIL.name();
			sendError = "ClientException:" + ce.getMessage();
			LOG.error("Something wrong with the network connection between client and MNS service."
					+ "Please check your network and DNS availablity.", ce);
		} catch (ServiceException se) {
			if (se.getErrorCode().equals("QueueNotExist")) {
				LOG.error("Queue is not exist.Please create before use", se);
			} else if (se.getErrorCode().equals("TimeExpired")) {
				LOG.error("The request is time expired. Please check your local machine timeclock", se);
			}
			LOG.error("message put in Queue error", se);
			sendStatus = MNSRecord.Status.SEND_FAIL.name();
			sendError = "ServiceException:" + se.getMessage();
		} catch (Exception e) {
			LOG.error("Unknown exception happened!", e);
			sendStatus = MNSRecord.Status.SEND_FAIL.name();
			sendError = e.getMessage();
		}

		MNSRecord mns = new MNSRecord();
		mns.setMqId(body.getMqId());
		mns.setMqType(body.getMqType());
		mns.setSendStatus(sendStatus);
		mns.setSendError(sendError);
		mns.setMqBody(body);
		MNSRecordHandle.sendMNSRecord(mns);

		client.close();
	}

}
