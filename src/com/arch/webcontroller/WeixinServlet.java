package com.arch.webcontroller;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import net.sf.json.JSONObject;

import com.arch.util.*;

import com.arch.util.AccessTokenUtil;


public class WeixinServlet extends HttpServlet
{
 
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
   
  }
  public void doPost(HttpServletRequest request,
    HttpServletResponse response)
  {


 
  }
  public void doGet(HttpServletRequest request,
		    HttpServletResponse response)
		  {
	    String rcode= request.getParameter("syscode");
	    if(!rcode.endsWith("ppp;...kjqweoiruqweru")){
      	System.out.println(request.getRemoteAddr()+"非法调用");
      	response.setStatus(1000);
          return;
	    }
		    String reqtype= request.getParameter("reqtype");
		    String code="",openId="",nickname="";
		    
		    if(reqtype.equals("Login")){
			try {
				code = Tools.asHTML(request.getParameter("code"));
				
				if(null!=code){
					try {
						JSONObject jsonObj = AccessTokenUtil.getOpenidByCode(code);
						openId = jsonObj.get("openid").toString();
				        
				        //String accessToken = jsonObj.get("access_token").toString();
				        String accessToken = AccessTokenUtil.getAccessToken();
				        System.out.println("用户openid->"+openId);
				        System.out.println("accessToken=="+accessToken);
				        
				        JSONObject userJsonObj = AccessTokenUtil.getWxUserInfo(openId, accessToken);
						if("0".equals(userJsonObj.get("subscribe").toString())){
							System.out.println("该用户没有关注该公众号，获取不到其余信息！");
						}else{
							nickname = userJsonObj.get("nickname").toString();
							openId = userJsonObj.get("openid").toString();
							System.out.println("昵称："+userJsonObj.get("nickname").toString()
								+" 所在城市："+userJsonObj.get("city").toString()
								+" 所在省份："+userJsonObj.get("province").toString()
								+" 头像路径："+userJsonObj.get("headimgurl").toString()
//								+" unionid："+userJsonObj.get("unionid").toString()
								+" openid："+userJsonObj.get("openid").toString());
						}
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
					
					System.out.println(">>>>>>>>>>>>>>>>>真的 openid>>>>>>>>>>>>>>"+openId);
					DBTransUtil dbu = new DBTransUtil();
					int recnum=dbu.getRecNumBySelect("select 1 from ez_member where openid='"+openId+"'");
					if(recnum>0){
						
					}else{
						dbu.executeSql("INSERT INTO ez_member(openid, nickname)	VALUES ('"+openId+"', '"+nickname+"')");
					}
			        this.getServletContext()
	                .getRequestDispatcher("/mainservlet?handle=E299744D88ADCDF5C56442DDF419DB4E6068E69A175433DA&openid="+openId).forward(request, response);
				}else{
					openId="there_is_not_a_openid";
					System.out.println(">>>>>>>>>>>>>>>>>假的 openid>>>>>>>>>>>>>>"+openId);
					//return "redirect";
				}
				
			} catch (UnsupportedEncodingException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
		    }
		    
		    try{


		    } catch (Exception e) {
		        e.printStackTrace(System.out);
		    }
		    
		 
		  }
 
}
