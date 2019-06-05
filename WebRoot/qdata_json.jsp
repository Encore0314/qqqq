<%@page language="java" contentType="text/html; charset=GBK" pageEncoding="GB18030"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%@page import="sun.jdbc.rowset.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%@ page session="false" %>
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
HashMap data=null,olddata=null;
OracleRowSet[] ors= null;
OracleRowSet[] ors1= null;
OracleRowSet[] ors2= null;
String xmlstr = "{\"row\":[";

if(eventResponse!=null){
	data=(HashMap)eventResponse.getBody();
	ors=(OracleRowSet[])data.get("operation1");
}
for(int i=0;i<ors.length;i++){
   xmlstr+="{\"col\":[";
	for(int j=0;j<ors[0].getCols().length;j++){
		xmlstr+="{";
	    xmlstr+="\"name\":\""+ors[0].getCols()[j]+"\",";
	    xmlstr+="\"value\":\""+ors[i].getValue(ors[0].getCols()[j])+"\"";
		xmlstr+="},";
	}
	if(xmlstr.endsWith(",")){
	 xmlstr=xmlstr.substring(0,xmlstr.length()-1);
	}
	xmlstr+="]},";
}
xmlstr=xmlstr.substring(0,xmlstr.length()-1);
xmlstr+="]}";

out.print(xmlstr);
%>

