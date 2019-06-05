<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%@page import="sun.jdbc.rowset.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%@page import="net.sf.json.*"%>

<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
HashMap data=null,olddata=null;
OracleRowSet[] ors= null;
OracleRowSet[] ors1= null;
OracleRowSet[] ors2= null;
JSONObject jsonObject = new JSONObject();
JSONArray jsonArray = new JSONArray();
if(eventResponse!=null){
	data=(HashMap)eventResponse.getBody();
	ors=(OracleRowSet[])data.get("operation3");
}

for(int i=0;i<ors.length;i++){
	JSONObject jsonObject1 = new JSONObject();
	for(int j=0;j<ors[0].getCols().length;j++){
		jsonObject1.put(ors[0].getCols()[j],ors[i].getValue(ors[0].getCols()[j]));
	}
	jsonArray.add(jsonObject1);
}


out.print(jsonArray.toString());
%>

