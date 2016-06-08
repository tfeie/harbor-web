package com.the.harbor.web.system.utils;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;

import com.the.harbor.base.exception.BusinessException;


public class HttpUtil {
	static Logger logger = Logger.getLogger(HttpUtil.class);
	public static final String TN_STATE = "state";
    public static final String TN_MESSAG = "message"; 
	public static String http(String url, Map<String, String> params) {
		URL u = null;
		HttpURLConnection con = null;
		// 构建请求参数
		StringBuffer sb = new StringBuffer();
		if (params != null) {
			for (Entry<String, String> e : params.entrySet()) {
				sb.append(e.getKey());
				sb.append("=");
				sb.append(e.getValue());
				sb.append("&");
			}
			sb.deleteCharAt(sb.length()-1);
		}

		// 尝试发送请求
		try {
			u = new URL(url);
			con = (HttpURLConnection) u.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(false);
			con.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			OutputStreamWriter osw = new OutputStreamWriter(
					con.getOutputStream(), "UTF-8");
			String cont = sb.toString();
			logger.debug("send_data:" + cont);
			osw.write(cont.toString());
			osw.flush();
			osw.close();
		} catch (Exception e) {
		    throw new BusinessException("8888",e.getMessage());
		} finally {
			if (con != null) {
				con.disconnect();
			}
		}

		// 读取返回内容
		StringBuffer buffer = new StringBuffer();
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(
					con.getInputStream(), "UTF-8"));
			String temp;
			while ((temp = br.readLine()) != null) {
				buffer.append(temp);
				buffer.append("\n");
			}
		} catch (Exception e) {
	         throw new BusinessException("8888",e.getMessage());
		}

		return buffer.toString();
	}

	public static Map<String,String> httpGetMap(String url, Map<String, String> params) {
		Map<String,String> map =new HashMap<String, String>();
		map.put(TN_MESSAG, "");
		map.put(TN_STATE,"1");
		URL u = null;
		HttpURLConnection con = null;
		//构建请求参数
		StringBuffer sb = new StringBuffer();
		if(params!=null){
		for (Entry<String, String> e : params.entrySet()) {
			sb.append(e.getKey());
			sb.append("=");
			sb.append(e.getValue());
			sb.append("&");
		  }
		  sb.substring(0, sb.length() - 1);
		}
		
		//尝试发送请求
		try {
			u = new URL(url);
			con = (HttpURLConnection) u.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(false);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
			String cont =sb.substring(0, sb.length() - 1).toString();
			System.out.println("send_data:"+cont);
			osw.write(cont.toString());
			osw.flush();
			osw.close();
		} catch (Exception e){
			e.printStackTrace();
			map.put(TN_MESSAG, e.getMessage());
			map.put(TN_STATE,"-1");
		} finally {
		  if (con != null) {
		       con.disconnect();
		     }
		}
		//读取返回内容
		StringBuffer buffer = new StringBuffer();
		try {
		BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
		String temp;
		while ((temp = br.readLine()) != null){
			buffer.append(temp);
			buffer.append("\n");
			}
		}catch (Exception e){
			e.printStackTrace();
			map.put(TN_MESSAG, e.getMessage());
			map.put(TN_STATE,"-1");
		}
		if(!"-1".equals(map.get("state"))){
			map.put(TN_MESSAG, buffer.toString());
			map.put(TN_STATE, "1");
		}
		return map;
		}
	
	/**
	 * @Descrption 发送HTTP请求，返回字符串
	 * @author caiyt
	 * @Date 2014-8-18 上午10:44:01
	 */
	public static String httpReq(String serviceUrl, String parameter,
			String restMethod) {
		try {
			logger.info("request url is : " + serviceUrl);
			// 如果请求方法为PUT,POST和DELETE设置DoOutput为真
			if (!HTTPReqMethod.METHOD_GET.equals(restMethod)) {
				URL url = new URL(serviceUrl);
				HttpURLConnection con = (HttpURLConnection) url
						.openConnection();
				con.setRequestMethod(restMethod);
				con.setDoOutput(true);
				if (!HTTPReqMethod.METHOD_DELETE
						.equals(restMethod)) { // 请求方法为PUT或POST时执行
					OutputStream os = con.getOutputStream();
					os.write(parameter.getBytes("UTF-8"));
					os.close();
				}
				// 获取返回结果
				String encoding = con.getContentEncoding();
				InputStream is = con.getInputStream();
				int read = -1;
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				while ((read = is.read()) != -1) {
					baos.write(read);
				}
				byte[] data = baos.toByteArray();
				baos.close();
				String content = null;
				if (encoding != null) {
					content = new String(data, encoding);
				} else {
					content = new String(data);
				}
				logger.info("响应内容:" + content);
				con.disconnect();
				return content;
			} else { // 请求方法为GET时执行
				logger.info("get请求获得token参数。");
				URL url = new URL((serviceUrl).trim());
				java.net.URLEncoder.encode(url.toString(), "UTF-8");
				HttpURLConnection connection = (HttpURLConnection) url
						.openConnection();
				connection.setDoInput(true);
				connection
						.setRequestMethod(HTTPReqMethod.METHOD_GET);
				connection.connect();
				// 接收返回请求
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(connection.getInputStream(),
								"UTF-8"));
				logger.info("reader:"+reader);
				String line = "";
				StringBuffer buffer = new StringBuffer();
				while ((line = reader.readLine()) != null) {
					buffer.append(line);
				}
				String responseData = buffer.toString();
				logger.info("响应内容:" + responseData);
				connection.disconnect();
				logger.info("responseData:"+responseData);
				return responseData;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("获取token失败");
		}
	}
	
    public static class HTTPReqMethod {
        public final static String METHOD_GET = "GET";

        public final static String METHOD_PUT = "PUT";

        public final static String METHOD_DELETE = "DELETE";

        public final static String METHOD_POST = "POST";
    }
}
