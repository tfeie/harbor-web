package com.the.harbor.web.system.utils;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.KeyStore;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.Set;
import java.util.SortedMap;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.alibaba.fastjson.JSONObject;
import com.the.harbor.web.system.http.HttpClientConnectionManager;
import com.the.harbor.web.system.http.MyX509TrustManager;


public class CommonUtil {
	private static Log log = LogFactory.getLog(CommonUtil.class);

    public static DefaultHttpClient httpclient;

    private static Logger logger = Logger.getLogger(CommonUtil.class);

    public static String CreateNoncestr(int length) {
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String res = "";
        for (int i = 0; i < length; i++) {
            Random rd = new Random();
            res += chars.indexOf(rd.nextInt(chars.length() - 1));
        }
        return res;
    }

    public static String CreateNoncestr() {
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String res = "";
        for (int i = 0; i < 16; i++) {
            Random rd = new Random();
            res += chars.charAt(rd.nextInt(chars.length() - 1));
        }
        return res;
    }
    
    public static boolean IsNumeric(String str) {
        if (str.matches("\\d *")) {
            return true;
        } else {
            return false;
        }
    }

    public static String ArrayToXml(HashMap<String, String> arr) {
        String xml = "<xml>";

        Iterator<Entry<String, String>> iter = arr.entrySet().iterator();
        while (iter.hasNext()) {
            Entry<String, String> entry = iter.next();
            String key = entry.getKey();
            String val = entry.getValue();
            if (IsNumeric(val)) {
                xml += "<" + key + ">" + val + "</" + key + ">";

            } else
                xml += "<" + key + "><![CDATA[" + val + "]]></" + key + ">";
        }

        xml += "</xml>";
        return xml;
    }
    
    public static String createSign(SortedMap<String, String> packageParams,String key) {
        StringBuffer sb = new StringBuffer();
        Set es = packageParams.entrySet();
        Iterator it = es.iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String k = (String) entry.getKey();
            String v = (String) entry.getValue();
            if (null != v && !"".equals(v) && !"sign".equals(k) && !"key".equals(k)) {
                sb.append(k + "=" + v + "&");
            }
        }
        sb.append("key=" + key);
        logger.info("转换前参数:" + sb);
        String sign = MD5Util.MD5Encode(sb.toString(), "UTF-8").toUpperCase();
        logger.info("packge签名:" + sign);
        return sign;

    }
    
    public static String createSignApp(SortedMap<String, String> packageParams) {
        StringBuffer sb = new StringBuffer();
        Set es = packageParams.entrySet();
        Iterator it = es.iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String k = (String) entry.getKey();
            String v = (String) entry.getValue();
            if (null != v && !"".equals(v) && !"sign".equals(k) && !"key".equals(k)) {
                sb.append(k + "=" + v + "&");
            }
        }
        sb.append("key=" + "");
        logger.info("转换前参数:" + sb);
        String sign = MD5Util.MD5Encode(sb.toString(), "UTF-8").toUpperCase();
        logger.info("packge签名:" + sign);
        return sign;

    }

    public static String getRequestXml(SortedMap<String, String> parameters)
            throws UnsupportedEncodingException {
        StringBuffer sb = new StringBuffer();
        sb.append("<xml>");
        Set es = parameters.entrySet();
        Iterator it = es.iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String k = (String) entry.getKey();
            String v = (String) entry.getValue();
            sb.append("<" + k + ">" + v + "</" + k + ">");
        }
        sb.append("</xml>");
        return sb.toString();
    }

    static {
        httpclient = new DefaultHttpClient();
        httpclient = (DefaultHttpClient) HttpClientConnectionManager.getSSLInstance(httpclient);
    }

    public static String getPayNo(String url, String xmlParam) {
        DefaultHttpClient client = new DefaultHttpClient();
        client.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);
        HttpPost httpost = HttpClientConnectionManager.getPostMethod(url);
        String prepay_id = "";
        try {
            httpost.setEntity(new StringEntity(xmlParam, "UTF-8"));
            HttpResponse response = httpclient.execute(httpost);
            String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");
            Map<String, Object> dataMap = new HashMap<String, Object>();
            logger.info("jsonStr:" + jsonStr);
            Map map = doXMLParse(jsonStr);
            String return_code = String.valueOf(map.get("return_code"));
            String result_code = String.valueOf(map.get("result_code"));
            if("SUCCESS".equals(return_code) && "SUCCESS".equals(result_code)){
                prepay_id = (String) map.get("prepay_id");
            }else{
            	log.error(map.get("return_msg")+",des:"+map.get("err_code_des"));
                prepay_id = "";
            }
        } catch (Exception e) {
            logger.error("微信请求异常:" + e.getMessage(),e);
        }finally{
            httpost.abort();
        }
        return prepay_id;
    }
    
    
    
    public static JSONObject getPayNo2(String url, String xmlParam) {
        
        JSONObject json = new JSONObject();
        json.put("STATE", "FAILD");
        json.put("MSG", "系统异常");
        DefaultHttpClient client = new DefaultHttpClient();
        client.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);
        HttpPost httpost = HttpClientConnectionManager.getPostMethod(url);
        String prepay_id = "";
        try {
            httpost.setEntity(new StringEntity(xmlParam, "UTF-8"));
            HttpResponse response = httpclient.execute(httpost);
            String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");
            Map<String, Object> dataMap = new HashMap<String, Object>();
            logger.info("jsonStr:" + jsonStr);
            Map map = doXMLParse(jsonStr);
            String return_code = String.valueOf(map.get("return_code"));
            String result_code = String.valueOf(map.get("result_code"));
            if("SUCCESS".equals(return_code) && "SUCCESS".equals(result_code)){
                prepay_id = (String) map.get("prepay_id");
                json.put("MSG",prepay_id);
                json.put("STATE","OK");
            }else{
                json.put("MSG","msg:"+map.get("return_msg")+",des:"+map.get("err_code_des"));
                return json;
            }
        } catch (Exception e) {
            logger.error("微信请求异常:" + e.getMessage(),e);
        }finally{
            httpost.abort();
        }
        return json;
    }
    
    

    public static String getCodeUrl(String url, String xmlParam) {
        DefaultHttpClient client = new DefaultHttpClient();
        client.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);
        HttpPost httpost = HttpClientConnectionManager.getPostMethod(url);
        String code_url = "";
        try {
            httpost.setEntity(new StringEntity(xmlParam, "UTF-8"));
            HttpResponse response = httpclient.execute(httpost);
            String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");

            logger.info("微信请求返回:" + jsonStr);
            if (jsonStr.indexOf("FAIL") != -1) {
                return code_url;
            }
            Map map = doXMLParse(jsonStr);
            code_url = (String) map.get("code_url");
        } catch (Exception e) {
            logger.error("微信请求异常:" + e.getMessage(),e);
        }finally{
            httpost.abort();
        }
        return code_url;
    }

    public static Map<String, String> doPost(String url, String xmlParam) {
        DefaultHttpClient client = new DefaultHttpClient();
        client.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);
        HttpPost httpost = HttpClientConnectionManager.getPostMethod(url);
        String code_url = "";
        Map<String, String> map = null;
        try {
            httpost.setEntity(new StringEntity(xmlParam, "UTF-8"));
            HttpResponse response = httpclient.execute(httpost);
            String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");

            logger.info("微信请求返回:" + jsonStr);
            map = doXMLParse(jsonStr);
        } catch (Exception e) {
            logger.error("微信请求异常:" + e.getMessage(),e);
        }finally{
            httpost.abort();
        }
        return map;
    }

    /**
     * 发送httpsPost请求
     * @param url
     * @param xmlParam
     * @param cerPath
     * @return
     * @throws Exception
     * @author LiangMeng
     */
    public static Map<String, String> doHttpsPost(String url, String xmlParam,String cerPath,String password) throws Exception {
        Map<String, String> map = new HashMap<String, String>();
        System.setProperty("javax.net.debug", "ssl,handshake");
        KeyStore keyStore = KeyStore.getInstance("PKCS12");
        FileInputStream instream = new FileInputStream(new File(cerPath));
        logger.info("instream："+instream);
        try {
            keyStore.load(instream, password.toCharArray());
        } finally {
            instream.close();
        }
        logger.info("keyStore："+keyStore);
        // Trust own CA and all self-signed certs
        SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, password.toCharArray()).build();
        logger.info("sslcontext："+sslcontext);
        // Allow TLSv1 protocol only
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext,new String[] { "TLSv1" }, null,
                SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
        logger.info("sslsf："+sslsf);
        CloseableHttpClient httpsclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
        logger.info("httpsclient："+httpsclient);
        try {

            HttpPost httpost = HttpClientConnectionManager.getPostMethod(url);
            logger.info("httpost："+httpost);
            httpost.setEntity(new StringEntity(xmlParam, "UTF-8"));

            CloseableHttpResponse response = httpsclient.execute(httpost);
            logger.info("response："+response);
            try {
                String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");
                logger.info("返回报文："+jsonStr);
                map = doXMLParse(jsonStr);
            }catch(Exception e){
                logger.error("报文解析异常："+e.getLocalizedMessage(),e);
            }finally {
                response.close();
            }
        }catch(Exception e){
            logger.error("https请求异常："+e.getLocalizedMessage(),e);
        } finally {
            httpsclient.close();
        }
        return map;
    }

    
    public static Map<String, String> doHttpsPost(String requestUrl ,String xmlParam){
        Map<String, String> map = new HashMap<String, String>();
        URL url;
        HttpURLConnection conn;
        String result = null;
        try {
            //忽略证书
            // Create a trust manager that does not validate certificate chains
            TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {

                public void checkClientTrusted(X509Certificate[] chain, String authType)
                        throws CertificateException {
                }

                public void checkServerTrusted(X509Certificate[] chain, String authType)
                        throws CertificateException {
                }

                public X509Certificate[] getAcceptedIssuers() {
                    return null;
                }

            } };
            // Install the all-trusting trust manager
            SSLContext sc = SSLContext.getInstance("TLS");
            sc.init(null, trustAllCerts, new SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
            /*1.初始化连接*/
            url = new URL(requestUrl);
            logger.info("请求地址：[ " + requestUrl+"]");
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setConnectTimeout(50000);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            
            /*3.发送报文*/
            OutputStreamWriter writer;
            writer = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
            logger.info("发送报文：[" + xmlParam+"]");
            writer.write(xmlParam);
            writer.flush();
            writer.close();
            String line;
            StringBuilder builder = new StringBuilder();
            /*4.接收返回报文*/
            BufferedReader reader;
            reader = new BufferedReader(new InputStreamReader(
                    conn.getInputStream(), "UTF-8"));
            while ((line = reader.readLine()) != null) {
                builder.append(line + "\n");
            }
            reader.close();
         // logger.info("接收报文: [" + URLDecoder.decode(builder.toString()+"]","UTF-8"));
         // return URLDecoder.decode(builder.toString(),"UTF-8");
            logger.info("接收报文: [" + builder.toString()+"]");
            map = doXMLParse(builder.toString());
        } catch (Exception e) { 
            logger.error("返回数据有误:" + e.getMessage(),e);
        }
        return map;
    }
    /**
     * 解析xml,返回第一级元素键值对。如果第一级元素有子节点，则此节点的值是子节点的xml数据。
     * 
     * @param strxml
     * @return
     * @throws JDOMException
     * @throws IOException
     */
    public static Map<String,String> doXMLParse(String strxml) throws Exception {
        if (null == strxml || "".equals(strxml)) {
            return null;
        }

        Map<String,String> m = new HashMap<String,String>();
        InputStream in = String2Inputstream(strxml);
        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(in);
        Element root = doc.getRootElement();
        List list = root.getChildren();
        Iterator it = list.iterator();
        while (it.hasNext()) {
            Element e = (Element) it.next();
            String k = e.getName();
            String v = "";
            List children = e.getChildren();
            if (children.isEmpty()) {
                v = e.getText();
            } else {
                v = getChildrenText(children);
            }

            m.put(k, v);
        }

        // 关闭流
        in.close();

        return m;
    }

    /**
     * 获取子结点的xml
     * 
     * @param children
     * @return String
     */
    public static String getChildrenText(List children) {
        StringBuffer sb = new StringBuffer();
        if (!children.isEmpty()) {
            Iterator it = children.iterator();
            while (it.hasNext()) {
                Element e = (Element) it.next();
                String name = e.getName();
                String value = e.getText();
                List list = e.getChildren();
                sb.append("<" + name + ">");
                if (!list.isEmpty()) {
                    sb.append(getChildrenText(list));
                }
                sb.append(value);
                sb.append("</" + name + ">");
            }
        }

        return sb.toString();
    }

    public static InputStream String2Inputstream(String str) {
        return new ByteArrayInputStream(str.getBytes());
    }


    /**
     * 发送https请求
     */
    public static JSONObject httpsRequest(String requestUrl, String rquestMethod, String outputStr) {
        JSONObject jsonObject = null;
        try {
            // 创建SSLContext对象，并使用我们制定的新人管理器初始化
            TrustManager[] tm = { new MyX509TrustManager() };
            SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
            sslContext.init(null, tm, new SecureRandom());
            // 从上述SSLContext对象中得到SSLSockedFactory对象
            SSLSocketFactory ssf = sslContext.getSocketFactory();

            URL url = new URL(requestUrl);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setSSLSocketFactory(ssf);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);

            // 设置请求方式（GET/POST）
            conn.setRequestMethod(rquestMethod);

            // 当outputStr不为空时，向输出流写数据
            if (null != outputStr) {
                OutputStream outputStream = conn.getOutputStream();
                outputStream.write(outputStr.getBytes("UTF-8"));
                outputStream.close();
            }

            // 从输入流读取返回内容
            InputStream inputStream = conn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            String str = null;
            StringBuffer buffer = new StringBuffer();
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }
            // 释放资源
            bufferedReader.close();
            inputStreamReader.close();
            inputStream.close();
            inputStream = null;
            conn.disconnect();
            jsonObject = JSONObject.parseObject(buffer.toString());
        } catch (ConnectException ce) {
            logger.error("链接超时", ce);
        } catch (Exception e) {
            logger.error("https请求异常", e);
        }
        return jsonObject;
    }
}
