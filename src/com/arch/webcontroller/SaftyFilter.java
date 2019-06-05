package com.arch.webcontroller;

import javax.servlet.*;
import javax.servlet.http.*;


import com.arch.util.*;

import java.util.*;

import redis.clients.jedis.Jedis;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class SaftyFilter implements Filter {
    private FilterConfig config;
    private String filterFile = null;//存储登陆页面中免过滤的文件名列表
    private String filterFid = null; //不验证的fid，通常是登陆，注册等。不需要登陆就可以使用的功能
    private String checkOnOff = null; //on 表示进行登录验证； off 表示不进行登录验证
    private Jedis jedis;
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain fc) throws java.io.IOException,
            javax.servlet.ServletException {
        HttpServletRequest hreq = (HttpServletRequest) request;
        HttpServletResponse hres = (HttpServletResponse) response;
        String token =  (String) hreq.getParameter("token");
        if(token==null){
        	token=(String)((HttpServletRequest)request).getSession().getAttribute("Token");
        }

        RequestHead head = new RequestHead();
        head.setToken(token);
		String header = hreq.getRequestURI();
        while (header.indexOf("/") >= 0) { //将/去掉，只剩下最后的文件名
            header = header.substring(header.indexOf("/") + 1);
        }
			
        if(header.endsWith("xml")){
            hres.sendRedirect(
                    SysConst.BASE_DIRECTORY+"globe/struct/struct_fault.jsp?flag=5");
            return;
        }

        if(header.toLowerCase().endsWith("jsp")){
        if(checkOnOff.equalsIgnoreCase("on")&&filterFile.indexOf(header) <0){
        	if(hreq.getParameter("jspcode")==null){
                hres.sendRedirect(
                        SysConst.BASE_DIRECTORY+"globe/struct/struct_fault.jsp?flag=6");
                return;
        	}

        	String jspcode = Azdg.decrypt(hreq.getParameter("jspcode"), SysConst.FORMACTION).split("&")[0];
        	String sjspcode =(String)hreq.getSession().getAttribute("jspcode");
        	if(!jspcode.equals(sjspcode)){
                hres.sendRedirect(
                        SysConst.BASE_DIRECTORY+"globe/struct/struct_fault.jsp?flag=5");
                return; 
        	}
        }}
        if(header.endsWith("mainservlet")){
        
        //String functionlist = (String) hreq.getSession().getAttribute(SysConst.FUNCTION_LIST);


       

       
        String contentType = hreq.getContentType();

        String functionId="";
        if ((contentType != null) &&
                contentType.startsWith("multipart/form-data")) {
                 
            }
            else{
            	if(hreq.getParameter("handle") != null){
                	
                	String handle = Azdg.decrypt(hreq.getParameter("handle"), SysConst.FORMACTION);
                	String h[]=handle.split("&");
                 	if(h[0].indexOf("=")>0){
                     	functionId=h[0].split("=")[1];
                     	}else{
                     		hres.setStatus(404);
                            return;                     		
                     	}
            }else{
            	functionId=hreq.getParameter(SysConst.PAR_FUNCTIONID);
                if(functionId==null){
                    hres.setStatus(404);
                    return;                	  
                }
            }
            }
        
        HashMap user = (HashMap)hreq.getSession().getAttribute(SysConst.LOGIN_USER);
        if (user != null) { 
        	head.setUser(user);
        }
 if(SysConst.LOGIN_FID.indexOf(functionId)<0){
	
                    String userinfo = RedisUtil.getString(token);
                    
            if(userinfo!=null&&userinfo.length()>0){
            	RedisUtil.setString(token, 30000, userinfo);
     
            }else{
                hres.sendRedirect(
                        SysConst.BASE_DIRECTORY+"globe/struct/struct_fault.jsp?flag=1");
                return;       	
            }	
        String functionlist = RedisUtil.getString(token+"flist");
        if(functionlist!=null&&functionlist.length()>0){
        	RedisUtil.setString(token+"flist", 300000, functionlist);
 
        }
        }
         
        
        head.setFunctionID(functionId);
        head.setCurIP(hreq.getRemoteAddr());
        head.setRurl(hreq.getHeader("referer"));
        hreq.setAttribute(SysConst.REQ_HEAD, head);
        String functionlist="";
        if(token!=null&&token.length()>0){
         functionlist = RedisUtil.getString(token+"flist");
        }
        System.out.print("----------------------------------------------->"+functionlist);
            if(checkOnOff.equalsIgnoreCase("on")){

                if(functionlist.indexOf(functionId+"#")!=-1){
                    hres.sendRedirect(
                            SysConst.BASE_DIRECTORY+"globe/struct/struct_fault.jsp?flag=7");
                    return;
                }   
                     
             }
        
            head=null;
        }
              fc.doFilter(hreq, hres);
    }


    public void init(FilterConfig filterConfig) throws javax.servlet.
            ServletException {
        this.config = filterConfig;
        filterFid = config.getInitParameter("FilterFid");
        checkOnOff = config.getInitParameter("ONOFF");
        filterFile = filterConfig.getInitParameter("FilterFile");
        filterConfig.getInitParameter("Fsql");
        SysConst.LOGIN_FID=filterFid;

    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.config = filterConfig;
    }

    public FilterConfig getFilterConfig() {
        return this.config;
    }

    public void destroy() {
        this.config = null;
    }

}
