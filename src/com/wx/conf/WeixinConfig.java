package com.wx.conf;

public class WeixinConfig {
	//=======【基本信息设置】=====================================
		//APPID
		public static final String APPID = "wxc5014a2fe2b77fde";
		//MCHID
		public static final String MCHID = "1445817202";
		//支付密钥
		public static final String KEY = "78839F907A951FEC8B8D03BC1A9A2634";
		//APPSECRET
		public static final String APPSECRET = "64a3f9e910a03a78c1e6505d7a54f11b";

		//跳转uri
		public static final String JS_API_CALL_URL = "www.wutaitang.com/BaseShop/pages/wxpay.jsp";		
		 
		//异步通知url
		//public static final String NOTIFY_URL = "http://bcgf.wutaitang.com/BaseShop/pages/wxsuccess.jsp";
		public static final String NOTIFY_URL = "http://www.wutaitang.com/BaseShop/OrderHandle/paidMoney.do";

		//超时时间
		public static final int POST_TIMEOUT = 30000;
		//下单接口
		public static final String UNIFIED_ORDER = "https://api.mch.weixin.qq.com/pay/unifiedorder";
}
