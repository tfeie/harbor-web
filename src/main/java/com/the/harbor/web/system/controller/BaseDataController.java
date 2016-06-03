package com.the.harbor.web.system.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.the.harbor.commons.redisdata.def.HyCountryVo;
import com.the.harbor.commons.redisdata.def.HyIndustryVo;
import com.the.harbor.commons.redisdata.util.HyCountryUtil;
import com.the.harbor.commons.redisdata.util.HyIndustryUtil;
import com.the.harbor.commons.web.model.ResponseData;

@RestController
@RequestMapping("/sys")
public class BaseDataController {

	private static final Logger LOG = Logger.getLogger(BaseDataController.class);

	@RequestMapping("/getAllHyCountries")
	public ResponseData<List<HyCountryVo>> getAllHyCountries() {
		ResponseData<List<HyCountryVo>> responseData = null;
		try {
			List<HyCountryVo> countries = HyCountryUtil.getAllHyCountries();
			responseData = new ResponseData<List<HyCountryVo>>(ResponseData.AJAX_STATUS_SUCCESS, "获取国家列表成功", countries);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyCountryVo>>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getAllHyIndustries")
	public ResponseData<List<HyIndustryVo>> getAllHyIndustries() {
		ResponseData<List<HyIndustryVo>> responseData = null;
		try {
			List<HyIndustryVo> countries = HyIndustryUtil.getAllHyIndustries();
			responseData = new ResponseData<List<HyIndustryVo>>(ResponseData.AJAX_STATUS_SUCCESS, "获取行业列表成功",
					countries);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyIndustryVo>>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

}
