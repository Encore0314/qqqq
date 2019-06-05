package com.wx.util;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.SortedMap;
import java.util.TreeMap;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import com.wx.conf.*;


public class WeixinCommon {
	private Logger logger = Logger.getLogger(WeixinCommon.class);
	private String code;
	private String prepay_id;
	public static void main(String args[]){
		WeixinCommon common = new WeixinCommon();
		String url = common.createOauthUrlForCode(WeixinConfig.JS_API_CALL_URL);
		System.out.println(url);
		//common.httpRequest(url);
		//System.out.println(common.createOauthUrlForCode("http://local/indx.html"));
		
	}
	/**
	 * 写日志
	 */
	public void logger(String msg){
		logger.info(msg);
	}
	/**
	 * 	作用：通过http向微信提交code，以获取openid
	 *   1、发送http请求
	 *   2、格式化json数据
	 *   3、获取openid
	 */
	public String getOpenid(){
		String url = createOauthUrlForOpenid();
		String open_id = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			String response_msg = httpGetRequest(url);
			logger("getOpenid method is response_msg: "+response_msg);
			if(!"".equals(response_msg)){
				JsonNode node = mapper.readTree(response_msg);
				JsonNode child_node = node.get("openid");
				open_id = child_node.getTextValue();
			}
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return open_id;
	}
	
	public String httpGetRequest(String url) {
		HttpClient client = new HttpClient();
		String response_msg = "";
		GetMethod get = new GetMethod(url);
		client.getHttpConnectionManager().getParams().setConnectionTimeout(WeixinConfig.POST_TIMEOUT);
		//get.setRequestHeader("Content-Type", "text/html; charset=utf-8");
		try {
			int success = client.executeMethod(get);
			if(success > 0){
				response_msg = get.getResponseBodyAsString();
				logger("httpGetRequest method response_msg:"+response_msg);
			}
			
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(get != null){
				get.releaseConnection();
			}
		}
		
		
		return response_msg;
	}
	
	public String httpPostRequest(String content,String url) {
		HttpClient client = new HttpClient();
		String response_msg = "";
		PostMethod post = new PostMethod(url);
		//post.setQueryString(content);
		//post.setRequestBody(content);
		RequestEntity requestEntity = new StringRequestEntity(content);
		post.setRequestEntity(requestEntity);
		post.setRequestHeader("Content-type", "text/xml; charset=utf-8");
		client.getHttpConnectionManager().getParams().setConnectionTimeout(WeixinConfig.POST_TIMEOUT);  
		try {
			int success = client.executeMethod(post);
			if(success > 0){
				response_msg = post.getResponseBodyAsString();
				logger("httpPostRequest method response_msg:"+response_msg);
				System.out.print(">>>>>>>>111"+response_msg);
			}
			
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		}finally {
			if(post != null){
				post.releaseConnection();
			}
		}
		
		return response_msg;
	}
	/**
	 * 	作用：生成可以获得openid的url
	 */
	public String createOauthUrlForOpenid()
	{
		SortedMap<String,Object> url_map = new TreeMap<String,Object>();
		url_map.put("appid", WeixinConfig.APPID);
		url_map.put("secret", WeixinConfig.APPSECRET);
		url_map.put("code", this.code);
		url_map.put("grant_type", "authorization_code");
		String bizString = formatBizQueryParaMap(url_map);
		return "https://api.weixin.qq.com/sns/oauth2/access_token?"+bizString;
	}
	/**
	 * 	作用：生成可以获得code的url
	 */
	public String createOauthUrlForCode(String redirectUrl){
		SortedMap<String,Object> url_map = new TreeMap<String,Object>();
		url_map.put("redirect_uri", redirectUrl);
		url_map.put("appid", WeixinConfig.APPID);
		url_map.put("scope", "snsapi_base");
		url_map.put("response_type", "code");
		
		//url_map.put("scope", "snsapi_userinfo");
		url_map.put("state", "STATE"+"#wechat_redirect");
		String biz_string = formatBizQueryParaMap(url_map);
		String code = "https://open.weixin.qq.com/connect/oauth2/authorize?"+biz_string;
		logger("request code is :"+code);
		return code;
	}
	
	/**
	 * 	作用：格式化参数，签名过程需要使用
	 *  将参数按照ASCII字母顺序升序排序
	 */
	private String formatBizQueryParaMap(SortedMap<String,Object> url_map){
		StringBuilder builder = new StringBuilder();
		String str = "";
		for(Map.Entry<String, Object> entry : url_map.entrySet()){
			builder.append("&"+entry.getKey()+"="+entry.getValue());
		}
		if(builder.length() > 0){
			str = builder.toString().substring(1);
		}
		return str;
	}
	
	/**
	 * 获取预支付prepayId
	 * @return
	 */
	public String getPrepayId(SortedMap<String,Object> sorted_map)
	{
		String response = postXml(sorted_map);
		Map<String,Object> result = xmlToArray(response);
		String prepay_id = String.valueOf(result.get("prepay_id"));
		return prepay_id;
	}
	/**
	 * 	作用：将xml转为array
	 */
	public Map<String,Object> xmlToArray(String xml)
	{		
		Map<String,Object> map_value = new HashMap<String,Object>();
		Document document;
		try {
			document = DocumentHelper.parseText(xml);
			Element root_element = document.getRootElement();  
			List<Element> child_element = root_element.elements();
			for(Element ele : child_element){
				map_value.put(ele.getName(), ele.getText());
			}
			
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map_value;
	}
	

	
	/**
	 * 	作用：post请求xml 调用统一下单接口
	 */
	private String postXml(SortedMap<String,Object> sorted_map)
	{
	    String xml = createXml(sorted_map);
		return httpPostRequest(xml,WeixinConfig.UNIFIED_ORDER);
	}
	
	/**
	 * 	作用：设置标配的请求参数，生成签名，生成接口参数xml
	 */
	private String createXml(SortedMap<String,Object> sorted_map)
	{
	    //$this->parameters["sign"] = $this->getSign($this->parameters);//签名
		sorted_map.put("appid", WeixinConfig.APPID);
		sorted_map.put("mch_id", WeixinConfig.MCHID);
		sorted_map.put("nonce_str", createNoncestr());
		sorted_map.put("sign", getSign(sorted_map));
		String xml = arrayToXml(sorted_map);
		logger("create prepay request parameters is :"+xml);
		System.out.println("微信支付=======5.6========prepay_id="+xml);
	    return  xml;
	}
	
	/**
	 * 	作用：产生随机字符串，不长于32位
	 */
	public String createNoncestr() 
	{
		String chars = "abcdefghijklmnopqrstuvwxyz0123456789";  
		String str ="";
		int current_str_length = 0;
		Random random = new Random();
		for ( int i = 0; i < 32; i++ )  {
			current_str_length = random.nextInt(chars.length()-1);
			str+=  chars.substring(current_str_length,current_str_length+1);
		}
		return str;
	}
	
	/**
	 * 	作用：生成签名
	 */
	public String getSign(SortedMap<String,Object> value_map)
	{
		//将值按照key=value的形式格式化为字符串
		String str= formatBizQueryParaMap(value_map);
		//签名步骤二：在string后加入KEY
		str = str+"&key="+WeixinConfig.KEY;
		//签名步骤三：MD5加密
		//str = MD5Utils.encrypt(str);
		str = MD5Util.md5(str);
		//签名步骤四：所有字符转为大写
		return str.toUpperCase();
	}
	/**
	 * 	作用：array转xml
	 */
	private String arrayToXml(SortedMap<String,Object> map_value)
    {
        String xml = "<xml>";
        
        for(Map.Entry<String, Object> entry : map_value.entrySet()){
        	if(entry.getValue() instanceof Integer){
        		xml+="<"+entry.getKey()+">"+entry.getValue()+"</"+entry.getKey()+">"; 
        	}else{
        		xml+="<"+entry.getKey()+"><![CDATA["+entry.getValue()+"]]></"+entry.getKey()+">";  
        	}
        }
        
        xml +="</xml>";
        return xml; 
    }
	
	/**
	 * 	作用：设置jsapi的参数
	 */
	public Object getParameters()
	{
		SortedMap<String,Object> order_map = new TreeMap<String,Object>();
		order_map.put("appId", WeixinConfig.APPID);
		String curTimeStamp = String.valueOf(System.currentTimeMillis()/1000);
		order_map.put("timeStamp", curTimeStamp);
		order_map.put("nonceStr", createNoncestr());
		order_map.put("package", "prepay_id="+prepay_id);
		order_map.put("signType", "MD5");
		order_map.put("paySign", getSign(order_map));
		ObjectMapper mapper = new ObjectMapper();
		String jsonObject =  "";
		try {
			jsonObject = mapper.writeValueAsString(order_map);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		logger("order pay info is : "+jsonObject);
		return jsonObject;
	}
	
	public void  setCode(String code)
	{
		this.code = code;
	}
	public void setPrepay_id(String prepay_id) {
		this.prepay_id = prepay_id;
	}
	
	
}
