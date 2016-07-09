package com.the.harbor.test;

import com.alibaba.fastjson.JSONObject;

public class UserTest {

	public static void main(String[] args) {
		JSONObject d = new JSONObject();
		d.put("count", 1);
		d.put("discount", "无折扣");
		d.put("prices", 1);
		d.put("priceYuan", "0.01");
		System.out.println(d.toJSONString());
	}

}
