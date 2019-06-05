<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%@page import="sun.jdbc.rowset.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%@page import="org.json.JSONObject"%>

<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
HashMap data=null,olddata=null;

JSONObject jsonObject = new JSONObject();
String sflag="";
String msg="";
if(eventResponse.isSuccessFlag()){
  sflag="success";
  msg=eventResponse.getSuccessMsg();
}else{
  sflag="flaut";
   msg=eventResponse.getFaultMsg();
}
	data=(HashMap)eventResponse.getBody();

jsonObject.put("token",eventResponse.getToken()==null?"":eventResponse.getToken());
jsonObject.put("sflag",sflag);
jsonObject.put("msg",msg);
jsonObject.put("data",new JSONObject(data));
jsonObject.put("oplength",eventResponse.getOperationlength());

out.print(jsonObject.toString());
%>

