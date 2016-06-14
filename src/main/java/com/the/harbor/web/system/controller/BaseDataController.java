package com.the.harbor.web.system.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.the.harbor.commons.components.globalconfig.GlobalSettings;
import com.the.harbor.commons.components.globalconfig.MemeberPrice;
import com.the.harbor.commons.indices.hyuniversity.UniversityHandler;
import com.the.harbor.commons.redisdata.def.HyCountryVo;
import com.the.harbor.commons.redisdata.def.HyIndustryVo;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyCountryUtil;
import com.the.harbor.commons.redisdata.util.HyIndustryUtil;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
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

	@RequestMapping("/getAllBaseInterestTags")
	@ResponseBody
	public ResponseData<List<HyTagVo>> getAllBaseInterestTags() {
		ResponseData<List<HyTagVo>> responseData = null;
		try {
			List<HyTagVo> tags = HyTagUtil.getAllBaseInterestTags();
			responseData = new ResponseData<List<HyTagVo>>(ResponseData.AJAX_STATUS_SUCCESS, "获取标签成功", tags);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyTagVo>>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getAllBaseSkillTags")
	@ResponseBody
	public ResponseData<List<HyTagVo>> getAllBaseSkillTags() {
		ResponseData<List<HyTagVo>> responseData = null;
		try {
			List<HyTagVo> tags = HyTagUtil.getAllBaseSkillTags();
			responseData = new ResponseData<List<HyTagVo>>(ResponseData.AJAX_STATUS_SUCCESS, "获取标签成功", tags);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyTagVo>>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getMemberCanByMonths")
	@ResponseBody
	public ResponseData<List<MemeberPrice>> getMemberCanByMonths() {
		ResponseData<List<MemeberPrice>> responseData = null;
		try {
			List<MemeberPrice> tags = GlobalSettings.getMemeberPrices();
			responseData = new ResponseData<List<MemeberPrice>>(ResponseData.AJAX_STATUS_SUCCESS, "获取会员购买价格成功", tags);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<MemeberPrice>>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/querySuggestByUniversityName1")
	@ResponseBody
	public ResponseData<List<String>> querySuggestByUniversityName1(String universityName) {
		ResponseData<List<String>> responseData = null;
		try {
			List<String> list = UniversityHandler.querySuggestByUniversityName(universityName);
			responseData = new ResponseData<List<String>>(ResponseData.AJAX_STATUS_SUCCESS, "获取搜索建议成功", list);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<String>>(ResponseData.AJAX_STATUS_FAILURE, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/querySuggestByUniversityName")
	@ResponseBody
	public void querySuggestByUniversityName(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PrintWriter printWriter = response.getWriter();
		String universityName = request.getParameter("universityName");
		List<String> list = UniversityHandler.querySuggestByUniversityName(universityName);
		JSONArray d= new JSONArray();
		for(String n:list){
			JSONObject o = new JSONObject();
			o.put("id", n);
			o.put("data", n);
			d.add(o);
		}
		printWriter.write(JSON.toJSONString(d));
		printWriter.flush();
		printWriter.close();
	}

}
