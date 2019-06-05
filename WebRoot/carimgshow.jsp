<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%
	String imgpath = request.getParameter("imgpath");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    

	<img alt="" style="width:1000px; margin:0 auto; height:800px;text-align:center;" src="/imageshow.jsp?path=<%=imgpath %>" />


  </body>
</html>
