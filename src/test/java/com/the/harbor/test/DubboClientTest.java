package com.the.harbor.test;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.the.harbor.api.go.IGoSV;
import com.the.harbor.api.go.param.GoCreateReq;
import com.the.harbor.api.go.param.GoCreateResp;
import com.the.harbor.api.go.param.GoTag;
import com.the.harbor.base.vo.Response;
import com.the.harbor.commons.dubbo.util.DubboConsumerFactory;
import com.the.harbor.commons.util.ExceptionUtil;

public class DubboClientTest {

	public static void main(String[] args) {
		try {
			GoCreateReq req = new GoCreateReq();
			List<GoTag> goTags = new ArrayList<GoTag>();
			GoTag tag = new GoTag();
			goTags.add(tag);
			req.setGoTags(goTags);
			GoCreateResp resp = DubboConsumerFactory.getService(IGoSV.class).createGo(req);
			System.out.println(JSON.toJSONString(resp));
		} catch (Exception ex) {
			Response resp = ExceptionUtil.convert(ex, String.class);
			System.out.println(JSON.toJSONString(resp));
		}
	}

}
