package com.the.harbor.web.system.utils;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.json.JSONArray;
import org.json.JSONObject;

public class StringUtil {
	/**
	 * 文件名加后缀
	 * @param filePathString
	 * @param addString
	 * @return
	 */
	public String addForFilePath(String filePathString,String addString){
		int dotaIndex=filePathString.lastIndexOf(".");
		if(dotaIndex!=-1){
			return filePathString.substring(0,dotaIndex)+addString+filePathString.substring(dotaIndex);
		}else {
			return filePathString+addString;
		}		
	}
	public static String getCapitalize(String srcString,String addString){
		return addString+(srcString.charAt(0)+"").toUpperCase()+srcString.substring(1);
	}
	public static String getNoCapitalize(String srcString,String addString){
		return addString+(srcString.charAt(0)+"").toLowerCase()+srcString.substring(1);
	}
	public static String addWhenUpper(String srcString,String addString){
		StringBuilder returnStringBuilder=new StringBuilder();
		for (int i = 0; i < srcString.length(); i++) {
			char c=srcString.charAt(i);
			if (Character.isUpperCase(c)) {
				returnStringBuilder.append(addString+c);
			}else {
				returnStringBuilder.append(c);
			}
		}
		return returnStringBuilder.toString();
	}
	/**
	 * 获取一个字符串首字母大写的格式
	 * 例如：输入adminInfo将返回AdminInfo
	 * @param srcString
	 * @return
	 */
	public static String getFirstUp(String srcString){
		return (srcString.charAt(0)+"").toUpperCase()+srcString.substring(1);
	}
	/**
	 * 获取一个字符串首字母小写的格式
	 * 例如：输入AdminInfo将返回adminInfo
	 * @param srcString
	 * @return
	 */
	public static String getFirstLower(String srcString){
		return (srcString.charAt(0)+"").toLowerCase()+srcString.substring(1);
	}
	/**
	 * 判断一个字符串是否为空，如果为空返回true,否则返回false.
	 * @param str
	 * @return
	 */
	public static boolean isBlank(String str){
		boolean flag = false;
		if(str==null || "".equals(str.trim())){
			flag = true;
		}
		return flag;
	}
	/**
	 * 该方法主要用于把key1=value&key2=value2字符串转化成map
	 * @param param
	 * @return
	 */
	public static Map<String, String> transformParam(String param){
		Map<String, String> paramMap=new HashMap<String, String>();
		String[] arr=param.split("&");
		for (int i=0;i<arr.length;i++) {
			String[] array=arr[i].split("=");
			if(array.length>0){
				if(array.length==2){
					paramMap.put(array[0], array[1]);
				}else{
					paramMap.put(array[0], "");
				}
			}
		}
		return paramMap;
	}
	
	/**
	 * 该方法主要用于把{"name":"xxx","value":"xxx"}字符串转化成map
	 * @param aoData
	 * @return
	 */
	public static Map<String, String> transformData(String aoData){
		Map<String, String> paramMap=new HashMap<String, String>();
		JSONArray jsonArray=new JSONArray(aoData);
		for(int i=0;i<jsonArray.length();i++){
			JSONObject obj=jsonArray.getJSONObject(i);
			paramMap.put(obj.get("name").toString(), obj.get("value").toString());
		}
		return paramMap;
	}
	public static String removeComma(String number){
		String result = number.replace(",", "");
		return result;
	}
	
	// unicode码转化为汉字
	public static String reconvert(String str){  
        char[]c=str.toCharArray();  
        String resultStr= "";  
        for(int i=0;i<c.length;i++)  
          resultStr += String.valueOf(c[i]);  
        return resultStr;  
	} 
	public static String toString(Object obj) {
        if (obj == null) {
            return "";
        }
        return obj.toString();
    }
	
	/**
     * 生成随机数
     * return String
     */
    public static String getRandomNumStr(){
        return DateUtil.getFormatDate(new Date(), "yyyyMMddhhmmss") + getRandomNum(4) + "";
    }
    public static int getRandomNum(int length) {
        int num = 1;
        double random = Math.random();
        if (random < 0.1) {
            random = random + 0.1;
        }
        for (int i = 0; i < length; i++) {
            num = num * 10;
        }
        return (int) ((random * num));
    }
    
    /**
     * java生成随机数字和字母组合
     * @param length[生成随机数的长度]
     * @return
     */
    public static String getCharAndNumr(int length) {
        String val = "";
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            // 输出字母还是数字
            String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num"; 
            // 字符串
            if ("char".equalsIgnoreCase(charOrNum)) {
                // 取得大写字母还是小写字母
                int choice = random.nextInt(2) % 2 == 0 ? 65 : 97; 
                val += (char) (choice + random.nextInt(26));
            } else if ("num".equalsIgnoreCase(charOrNum)) { // 数字
                val += String.valueOf(random.nextInt(10));
            }
        }
        return val;
    }
	
}

