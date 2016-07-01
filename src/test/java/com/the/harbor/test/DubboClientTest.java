package com.the.harbor.test;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.the.harbor.api.go.IGoSV;
import com.the.harbor.api.go.param.GoCreateReq;
import com.the.harbor.api.go.param.GoCreateResp;
import com.the.harbor.api.go.param.GoTag;
import com.the.harbor.api.go.param.UpdateGoOrderPayReq;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.util.ExceptionUtil;

public class DubboClientTest {

	public static void main(String[] args) {
		UpdateGoOrderPayReq updateGoOrderPayReq = new UpdateGoOrderPayReq();
		updateGoOrderPayReq.setPayOrderId("7B810C32459B44F0B820C6B51A4DDBF8");
		updateGoOrderPayReq.setGoOrderId("6F0DBDFB848C42F7926A2BD999FDBAFA");
		updateGoOrderPayReq.setPayStatus("SUCCESS");
		
		Response rep = DubboConsumerFactory.getService(IGoSV.class).updateGoOrderPay(updateGoOrderPayReq);
	}

}
