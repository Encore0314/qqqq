package com.arch.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Properties;

import javax.net.ssl.HttpsURLConnection;

import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class AccessTokenUtil {
	
	//实用<span style="font-family:Consolas;">synchronized static可以防止同时被多实例化</span>  
    public synchronized static String getAccessToken() {  
        //保存access_token文件名字  
        String FileName = "WxTokenUtil.properties";  
        try {  
            // 从文件中获取token值及时间  
            Properties prop = new Properties();// 属性集合对象  

             //获取文件流  
            InputStream fis = AccessTokenUtil.class.getClassLoader().getResourceAsStream(FileName);  
            prop.load(fis);// 将属性文件流装载到Properties对象中  
            fis.close();// 关闭流  
            //获取Appid，APPsecret  
            String APPID = prop.getProperty("APPID");  
            String APPSECRET = prop.getProperty("APPSECRET");  
            System.out.println("-----APPID="+APPID+" APPSECRET="+APPSECRET);
            // 获取accesstoken，初始值为空，第一次调用之后会把值写入文件  
            String access_token = prop.getProperty("access_token");  
            String expires_in = prop.getProperty("expires_in");  
            String last_time = prop.getProperty("last_time");  
  
            int int_expires_in = 0;  
            long long_last_time = 0;  
  
            try {  
                int_expires_in = Integer.parseInt(expires_in);  
                long_last_time = Long.parseLong(last_time);  
  
            } catch (Exception e) {  
  
            }  
            //得到当前时间  
            long current_time = System.currentTimeMillis();  
  
            // 每次调用，判断expires_in是否过期，如果token时间超时，重新获取，expires_in有效期为7200  
            if ((current_time - long_last_time) / 1000 >= int_expires_in) {  
            	System.out.println("【1-1】");
                //获取token url  
                String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="  
                        + APPID + "&secret=" + APPSECRET;  
                //发送http请求得到json流  
                JSONObject jobject = httpRequest(url);  
                //从json流中获取access_token  
                String  j_access_token = jobject.get("access_token").toString();  
                String  j_expires_in = jobject.get("expires_in").toString();  
  
                //保存access_token  
                if (j_access_token != null && j_expires_in != null) {  
                	System.out.println("【1-2】");
                    prop.setProperty("access_token", j_access_token);  
                    prop.setProperty("expires_in", j_expires_in);  
                    prop.setProperty("last_time", System.currentTimeMillis() + "");  
  
                    URL url_ = AccessTokenUtil.class.getClassLoader().getResource(FileName);  
                    FileOutputStream fos = new FileOutputStream(new File(url_.toURI()));  
                    prop.store(fos, null);  
                    fos.close();// 关闭流  
                }  
                //如果已经过期返回获取到的access_token  
                return j_access_token;  
            } else { 
            	System.out.println("【1-3】");
                //如果没有过期，返回从文件中读取的access_token  
                return access_token;  
            }  
        } catch (Exception e) {  
        	e.printStackTrace();
            return null;  
        }  
  
  
    }  
  
    // 获取accesstoken  
    public synchronized static JSONObject httpRequest(String requestUrl) {  
        JSONObject jsonObject = null;  
        StringBuffer buffer = new StringBuffer();  
        try {  
  
            URL url = new URL(requestUrl);  
            HttpsURLConnection httpUrlConn = (HttpsURLConnection) url  
                    .openConnection();  
  
            httpUrlConn.setDoOutput(true);  
            httpUrlConn.setDoInput(true);  
            httpUrlConn.setUseCaches(false);  
            // 设置请求方式（GET/POST）  
            httpUrlConn.setRequestMethod("GET");  
  
            httpUrlConn.connect();  
  
            // 将返回的输入流转换成字符串  
            InputStream inputStream = httpUrlConn.getInputStream();  
            InputStreamReader inputStreamReader = new InputStreamReader(  
                    inputStream, "utf-8");  
            BufferedReader bufferedReader = new BufferedReader(  
                    inputStreamReader);  
  
            String str = null;  
            while ((str = bufferedReader.readLine()) != null) {  
                buffer.append(str);  
            }  
            bufferedReader.close();  
            inputStreamReader.close();  
            // 释放资源  
            inputStream.close();  
            inputStream = null;  
            httpUrlConn.disconnect();  
            //jsonObject = JSONObject.parseObject(buffer.toString()); 
            jsonObject = JSONObject.fromObject(buffer.toString());
  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
  
        return jsonObject;  
    }  
    
    public static JSONObject getOpenidByCode(String code){
        String FileName = "WxTokenUtil.properties";
        String jsonStr = "";
		try {
			Properties prop = new Properties();// 属性集合对象  

             //获取文件流  
            InputStream fis = AccessTokenUtil.class.getClassLoader().getResourceAsStream(FileName);  
            prop.load(fis);// 将属性文件流装载到Properties对象中  
            fis.close();// 关闭流  
            //获取Appid，APPsecret  
            String APPID = prop.getProperty("APPID");  
            String APPSECRET = prop.getProperty("APPSECRET");  
	        //换取access_token 其中包含了openid
	        String URL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code".replace("APPID", APPID).replace("SECRET", APPSECRET).replace("CODE", code);
	        //URLConnectionHelper是一个模拟发送http请求的类
	        //String jsonStr = URLConnectionHelper.sendGet(URL);
	        CloseableHttpClient client  = HttpClients.createDefault();
			HttpGet get = new HttpGet(URL);
			CloseableHttpResponse httpResponse;
			httpResponse = client.execute(get);
			HttpEntity entity = httpResponse.getEntity();
			if (null != entity) {
				jsonStr = EntityUtils.toString(entity, "utf-8");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}	
        JSONObject jsonObj = JSONObject.fromObject(jsonStr);
        //String openid = jsonObj.get("openid").toString();
        return jsonObj;
    } 
    
    public static JSONObject getWxUserInfo(String openid, String accessToken){
        String jsonStr = "";
		try {
	        //换取access_token 其中包含了openid
            String URL = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN".replace("OPENID", openid).replace("ACCESS_TOKEN", accessToken);
            System.out.println("accessTokenURL=="+URL);
	        CloseableHttpClient client  = HttpClients.createDefault();
			HttpGet get = new HttpGet(URL);
			CloseableHttpResponse httpResponse;
			httpResponse = client.execute(get);
			HttpEntity entity = httpResponse.getEntity();
			if (null != entity) {
				jsonStr = EntityUtils.toString(entity, "utf-8");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}	
        JSONObject jsonObj = JSONObject.fromObject(jsonStr);
        return jsonObj;
    }
    
}