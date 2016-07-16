package com.the.harbor.web.system.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.the.harbor.base.constants.ExceptCodeConstants;
import com.the.harbor.base.enumeration.dict.ParamCode;
import com.the.harbor.base.enumeration.dict.TypeCode;
import com.the.harbor.commons.indices.hyuniversity.UniversityHandler;
import com.the.harbor.commons.redisdata.def.HyCountryVo;
import com.the.harbor.commons.redisdata.def.HyDictsVo;
import com.the.harbor.commons.redisdata.def.HyIndustryVo;
import com.the.harbor.commons.redisdata.def.HyTagVo;
import com.the.harbor.commons.redisdata.util.HyCountryUtil;
import com.the.harbor.commons.redisdata.util.HyDictUtil;
import com.the.harbor.commons.redisdata.util.HyIndustryUtil;
import com.the.harbor.commons.redisdata.util.HyTagUtil;
import com.the.harbor.commons.util.CollectionUtil;
import com.the.harbor.commons.util.ExceptionUtil;
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
			responseData = new ResponseData<List<HyCountryVo>>(ResponseData.AJAX_STATUS_SUCCESS,
					ExceptCodeConstants.SUCCESS, "获取国家列表成功", countries);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyCountryVo>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getAllHyIndustries")
	public ResponseData<List<HyIndustryVo>> getAllHyIndustries() {
		ResponseData<List<HyIndustryVo>> responseData = null;
		try {
			List<HyIndustryVo> countries = HyIndustryUtil.getAllHyIndustries();
			responseData = new ResponseData<List<HyIndustryVo>>(ResponseData.AJAX_STATUS_SUCCESS,
					ExceptCodeConstants.SUCCESS, "获取行业列表成功", countries);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyIndustryVo>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getAllBaseInterestTags")
	@ResponseBody
	public ResponseData<List<HyTagVo>> getAllBaseInterestTags() {
		ResponseData<List<HyTagVo>> responseData = null;
		try {
			List<HyTagVo> tags = HyTagUtil.getAllBaseInterestTags();
			responseData = new ResponseData<List<HyTagVo>>(ResponseData.AJAX_STATUS_SUCCESS,
					ExceptCodeConstants.SUCCESS, "获取标签成功", tags);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyTagVo>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getAllBaseSkillTags")
	@ResponseBody
	public ResponseData<List<HyTagVo>> getAllBaseSkillTags() {
		ResponseData<List<HyTagVo>> responseData = null;
		try {
			List<HyTagVo> tags = HyTagUtil.getAllBaseSkillTags();
			responseData = new ResponseData<List<HyTagVo>>(ResponseData.AJAX_STATUS_SUCCESS,
					ExceptCodeConstants.SUCCESS, "获取标签成功", tags);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<HyTagVo>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getMemberCanByMonths")
	@ResponseBody
	public ResponseData<JSONArray> getMemberCanByMonths() {
		ResponseData<JSONArray> responseData = null;
		try {
			JSONArray a = new JSONArray();
			List<HyDictsVo> dicts = HyDictUtil.getHyDicts(TypeCode.HY_COMMON.getValue(),
					ParamCode.MEMBER_PRICES.getValue());
			if (!CollectionUtil.isEmpty(dicts)) {
				for (HyDictsVo dict : dicts) {
					JSONObject o = JSON.parseObject(dict.getParamValue());
					a.add(o);
				}
			}
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取会员购买价格成功", a);
		} catch (Exception e) {
			LOG.error(e);
			responseData = ExceptionUtil.convert(e, JSONArray.class);
		}
		return responseData;
	}

	@RequestMapping("/querySuggestByUniversityName")
	@ResponseBody
	public ResponseData<List<String>> querySuggestByUniversityName(String universityName) {
		ResponseData<List<String>> responseData = null;
		try {
			List<String> list = UniversityHandler.querySuggestByUniversityName(universityName);
			responseData = new ResponseData<List<String>>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取搜索建议成功", list);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<List<String>>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

	@RequestMapping("/getHyDicts")
	@ResponseBody
	public ResponseData<JSONObject> getHyDicts(String queryDictKeys) {
		ResponseData<JSONObject> responseData = null;
		try {
			List<String> keys = JSON.parseArray(queryDictKeys, String.class);
			JSONObject d = new JSONObject();
			if (!CollectionUtil.isEmpty(keys)) {
				for (String key : keys) {
					List<HyDictsVo> list = HyDictUtil.getHyDicts(key);
					d.put(key, list);
				}
			}
			responseData = new ResponseData<JSONObject>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取字典参数成功", d);
		} catch (Exception e) {
			LOG.error(e);
			responseData = ExceptionUtil.convert(e, JSONObject.class);
		}
		return responseData;
	}

	@RequestMapping("/getHaibeiCanBuy")
	@ResponseBody
	public ResponseData<JSONArray> getHaibeiCanBuy() {
		ResponseData<JSONArray> responseData = null;
		try {
			JSONArray a = new JSONArray();
			List<HyDictsVo> dicts = HyDictUtil.getHyDicts(TypeCode.HY_COMMON.getValue(),
					ParamCode.HAIBEI_PRICES.getValue());
			if (!CollectionUtil.isEmpty(dicts)) {
				for (HyDictsVo dict : dicts) {
					JSONObject o = JSON.parseObject(dict.getParamValue());
					a.add(o);
				}
			}
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_SUCCESS, ExceptCodeConstants.SUCCESS,
					"获取海贝购买价格成功", a);
		} catch (Exception e) {
			LOG.error(e);
			responseData = new ResponseData<JSONArray>(ResponseData.AJAX_STATUS_FAILURE,
					ExceptCodeConstants.SYSTEM_ERROR, "系统繁忙，请重试");
		}
		return responseData;
	}

}
