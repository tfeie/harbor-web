package com.the.harbor.web.system.utils;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.event.ProgressEvent;
import com.aliyun.oss.event.ProgressEventType;
import com.aliyun.oss.event.ProgressListener;
import com.aliyun.oss.model.PutObjectRequest;
import com.the.harbor.base.exception.BusinessException;
import com.the.harbor.base.exception.SystemException;
import com.the.harbor.commons.components.weixin.WXHelpUtil;
import com.the.harbor.commons.exception.SDKException;
import com.the.harbor.commons.ssl.MyX509TrustManager;
import com.the.harbor.commons.util.RandomUtil;

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
			sb.deleteCharAt(sb.length() - 1);
		}

		// 尝试发送请求
		try {
			u = new URL(url);
			con = (HttpURLConnection) u.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(false);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
			String cont = sb.toString();
			logger.debug("send_data:" + cont);
			osw.write(cont.toString());
			osw.flush();
			osw.close();
		} catch (Exception e) {
			throw new BusinessException("8888", e.getMessage());
		} finally {
			if (con != null) {
				con.disconnect();
			}
		}

		// 读取返回内容
		StringBuffer buffer = new StringBuffer();
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String temp;
			while ((temp = br.readLine()) != null) {
				buffer.append(temp);
				buffer.append("\n");
			}
		} catch (Exception e) {
			throw new BusinessException("8888", e.getMessage());
		}

		return buffer.toString();
	}

	public static Map<String, String> httpGetMap(String url, Map<String, String> params) {
		Map<String, String> map = new HashMap<String, String>();
		map.put(TN_MESSAG, "");
		map.put(TN_STATE, "1");
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
			sb.substring(0, sb.length() - 1);
		}

		// 尝试发送请求
		try {
			u = new URL(url);
			con = (HttpURLConnection) u.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(false);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
			String cont = sb.substring(0, sb.length() - 1).toString();
			System.out.println("send_data:" + cont);
			osw.write(cont.toString());
			osw.flush();
			osw.close();
		} catch (Exception e) {
			e.printStackTrace();
			map.put(TN_MESSAG, e.getMessage());
			map.put(TN_STATE, "-1");
		} finally {
			if (con != null) {
				con.disconnect();
			}
		}
		// 读取返回内容
		StringBuffer buffer = new StringBuffer();
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String temp;
			while ((temp = br.readLine()) != null) {
				buffer.append(temp);
				buffer.append("\n");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put(TN_MESSAG, e.getMessage());
			map.put(TN_STATE, "-1");
		}
		if (!"-1".equals(map.get("state"))) {
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
	public static String httpReq(String serviceUrl, String parameter, String restMethod) {
		try {
			logger.info("request url is : " + serviceUrl);
			// 如果请求方法为PUT,POST和DELETE设置DoOutput为真
			if (!HTTPReqMethod.METHOD_GET.equals(restMethod)) {
				URL url = new URL(serviceUrl);
				HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod(restMethod);
				con.setDoOutput(true);
				if (!HTTPReqMethod.METHOD_DELETE.equals(restMethod)) { // 请求方法为PUT或POST时执行
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
				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				connection.setDoInput(true);
				connection.setRequestMethod(HTTPReqMethod.METHOD_GET);
				connection.connect();
				// 接收返回请求
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
				logger.info("reader:" + reader);
				String line = "";
				StringBuffer buffer = new StringBuffer();
				while ((line = reader.readLine()) != null) {
					buffer.append(line);
				}
				String responseData = buffer.toString();
				logger.info("响应内容:" + responseData);
				connection.disconnect();
				logger.info("responseData:" + responseData);
				return responseData;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("获取token失败");
		}
	}

	public static void uploadFile2OSS1(String url) {
		HttpURLConnection conn = null;
		try {
			URL url1 = new URL(url);
			conn = (HttpURLConnection) url1.openConnection();
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(30000);
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Connection", "Keep-Alive");
			conn.setRequestProperty("Cache-Control", "no-cache");
			String boundary = "-----------------------------" + System.currentTimeMillis();
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
			InputStream in = conn.getInputStream();
			try {
				putOSS(in);
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				throw new SystemException(e.getMessage());
			}
		} catch (IOException e) {
			throw new SystemException(e);
		} finally {
			conn.disconnect();
		}
	}

	public static JSONObject uploadFile2OSS(String requestUrl) {
		JSONObject jsonObject = null;
		try {
			// 创建SSLContext对象，并使用我们制定的新人管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new SecureRandom());
			// 从上述SSLContext对象中得到SSLSockedFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);

			// 设置请求方式（GET/POST）
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Connection", "Keep-Alive");
			conn.setRequestProperty("Cache-Control", "no-cache");
			String boundary = "-----------------------------" + System.currentTimeMillis();
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
			InputStream in = conn.getInputStream();
			try {
				TrustStrategy a = null;
				putOSS(in);
			} catch (Throwable e) {
				e.printStackTrace();
				throw new SystemException(e.getMessage());
			}
		} catch (ConnectException ce) {
			throw new SDKException("连接异常", ce);
		} catch (Exception e) {
			throw new SDKException("请求异常", e);
		}
		return jsonObject;
	}

	public static void putOSS(InputStream inputStream) throws Throwable {
		// endpoint以杭州为例，其它region请按实际情况填写
		String endpoint = "oss-cn-beijing.aliyuncs.com";
		// accessKey请登录https://ak-console.aliyun.com/#/查看
		String accessKeyId = "9iqLEjXb3mC9s6rP";
		String accessKeySecret = "XPazTTqPAhLa5GfSmkuYRwLeLdoiWC";
		// 创建OSSClient实例
		OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);

		long time1 = System.currentTimeMillis();
		ossClient.putObject(new PutObjectRequest("harbor-images", RandomUtil.generateNumber(6) + ".png", inputStream)
				.<PutObjectRequest> withProgressListener(new PutObjectProgressListener()));

		long time2 = System.currentTimeMillis();
		System.out.println(time2 - time1);
		// 关闭client
		ossClient.shutdown();
	}

	/**
	 * 获取上传进度回调
	 *
	 */
	static class PutObjectProgressListener implements ProgressListener {

		private long bytesWritten = 0;
		private long totalBytes = -1;
		private boolean succeed = false;

		@Override
		public void progressChanged(ProgressEvent progressEvent) {
			long bytes = progressEvent.getBytes();
			ProgressEventType eventType = progressEvent.getEventType();
			switch (eventType) {
			case TRANSFER_STARTED_EVENT:
				System.out.println("Start to upload......");
				break;

			case REQUEST_CONTENT_LENGTH_EVENT:
				this.totalBytes = bytes;
				System.out.println(this.totalBytes + " bytes in total will be uploaded to OSS");
				break;

			case REQUEST_BYTE_TRANSFER_EVENT:
				this.bytesWritten += bytes;
				if (this.totalBytes != -1) {
					int percent = (int) (this.bytesWritten * 100.0 / this.totalBytes);
					System.out.println(bytes + " bytes have been written at this time, upload progress: " + percent
							+ "%(" + this.bytesWritten + "/" + this.totalBytes + ")");
				} else {
					System.out.println(bytes + " bytes have been written at this time, upload ratio: unknown" + "("
							+ this.bytesWritten + "/...)");
				}
				break;

			case TRANSFER_COMPLETED_EVENT:
				this.succeed = true;
				System.out.println("Succeed to upload, " + this.bytesWritten + " bytes have been transferred in total");
				break;

			case TRANSFER_FAILED_EVENT:
				System.out.println("Failed to upload, " + this.bytesWritten + " bytes have been transferred");
				break;

			default:
				break;
			}
		}

		public boolean isSucceed() {
			return succeed;
		}
	}

	public static void main(String[] agrs) {
		String media_id = "ag9uZlrPMq_OEfgBbhEHoX9GKhFeh3f8Ej2WlsGa8JPBVA-596Aw7TXavYVtPy9d";
		String access_token = WXHelpUtil.getCommonAccessToken();
		String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?" + "access_token=" + access_token + "&media_id="
				+ media_id;
		HttpUtil.uploadFile2OSS(url);
	}

	public static class HTTPReqMethod {
		public final static String METHOD_GET = "GET";

		public final static String METHOD_PUT = "PUT";

		public final static String METHOD_DELETE = "DELETE";

		public final static String METHOD_POST = "POST";
	}
}
