<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%
  EventResponse eventResponse = (EventResponse) request.getAttribute("result");
  FormUtil form = new FormUtil();  
  String urlpattern=  eventResponse.getSuccessPage();
  String msg=eventResponse.getSuccessMsg();
  String target=eventResponse.getSuccessTarget();
    if(target.equals("")){
    target="location";
  }
  String url,urle="";
  if(!urlpattern.equals("")){
   //设置成功页面
        if(urlpattern.indexOf("mainservlet")>=0){
        	Azdg azdg = new Azdg();
        	urle=urlpattern.split("\\?")[1];
        	urle ="/mainservlet?handle="+azdg.encrypt(urle,SysConst.FORMACTION).replace("\r\n","");
        }else{
        String jspcode = FormBean.getRandom(8);
		session.setAttribute("jspcode",jspcode);
            if(urlpattern.indexOf("?")>0){
              urle=urlpattern+"&jspcode="+Azdg.encrypt(jspcode,SysConst.FORMACTION);
            }else{
             urle=urlpattern+"?jspcode="+Azdg.encrypt(jspcode,SysConst.FORMACTION);
            }
        }
  //设定了成功信息则提示信息
  if (!msg.equals("")){
    if(msg.split("$").length>1){
      url=msg.split("$")[0];
      msg=msg.split("$")[1];
      out.print("<script>window."+ target + "='"+url + "?msg="+msg+"&returnurl="+urle+"';</script>");
      //response.sendRedirect(url+"?msg="+msg+"&returnurl="+urle);
    }
   
    else{
      if(msg.equals("$")){
       out.print("<script>window."+target+ "='"+urle + "';</script>");
       // response.sendRedirect(urle);
      }else{
    out.println(form.showSuccessMsg(msg));
    out.print("<script>window."+target + "='"+urle + "';</script>");
     //response.sendRedirect(urle);
    }
    }
  }else{
         out.print("<script>window."+target + "='"+urle + "';</script>");
  }
  //有成功页面但无信息提示时通过后台调转
  }else{

  //没有设置成功页面
  //设置信息
  if (!msg.equals("")){
    if(msg.split("$").length>1){
      url=msg.split("$")[0];
      msg=msg.split("$")[1];
      out.print("<script>window."+ target + "='"+url + "?msg="+msg+"&returnurl=';</script>");
      //response.sendRedirect(url+"?msg="+msg);
    }
    else{
    out.println(form.showSuccessMsg(msg));
    out.print("<script>window.history.go(-1);</script>");
    }
  } 
  //无信息提示
  else{ 
  	out.println(form.showSuccessMsg("操作成功！"));
    out.print("<script>window.history.go(-1);</script>");
    }
   }
 %>

