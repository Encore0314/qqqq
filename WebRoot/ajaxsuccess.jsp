<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%
  EventResponse eventResponse = (EventResponse) request.getAttribute("result");
  FormUtil form = new FormUtil();  
  String urlpattern=  eventResponse.getSuccessPage();
  
  String target=eventResponse.getSuccessTarget();
  HashMap data=null,olddata=null;
  String msg="";
  if(eventResponse!=null){
     // olddata=(HashMap)((HashMap)eventResponse.getOriginBody()).get("operation1");
      msg=eventResponse.getSuccessMsg();
   if(msg==null||msg.equals("")){
	   msg="操作成功";
   }
   if (!eventResponse.isSuccessFlag()) {
	   
	   msg="可用金额不足!";
   }
 }
  String rurl="";
  out.print(msg);
 %>

