<%@ page contentType="text/html; charset=utf-8" language="java"	errorPage=""%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%@page import="sun.jdbc.rowset.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
HashMap data=null,olddata=null;
OracleRowSet[] ors= null;
OracleRowSet[] ors1= null;
OracleRowSet[] ors2= null;

String outstr="";
if(eventResponse!=null){
	data=(HashMap)eventResponse.getBody();
	ors=(OracleRowSet[])data.get("operation1");
}

for(int i=0;ors!=null&&i<ors.length;i++){
	if(ors[i].getValue("dwmc").length()>0){
	outstr=outstr+"{text:'"+ors[i].getValue("dwmc")+"', value:'"+ors[i].getValue("dwmc")+"'}\n";
	}
	
}
 

out.print(outstr);
%>

