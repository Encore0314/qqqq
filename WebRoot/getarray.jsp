<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	EventResponse eventResponse = (EventResponse) request
			.getAttribute("result");
	FormUtil form = new FormUtil();
	OracleRowSet[] ors = new OracleRowSet[1];
	ors[0] = new OracleRowSet(50);

	HashMap data = null, olddata = null;
	if (eventResponse != null) {
		data = (HashMap) eventResponse.getBody();
		ors = (OracleRowSet[]) data.get("operation1");
		olddata = (HashMap) ((HashMap) eventResponse.getOriginBody())
				.get("operation1");
	}
 FormUtil futil=new FormUtil();
 String xmlstr = "[";
 for(int i=0;i<ors.length;i++){
	   xmlstr+="[";
		for(int j=0;j<ors[0].getCols().length;j++){
		    xmlstr+="\""+ors[i].getValue(ors[0].getCols()[j])+"\"";
			xmlstr+=",";
		}
		if(xmlstr.endsWith(",")){
		 xmlstr=xmlstr.substring(0,xmlstr.length()-1);
		}
		xmlstr+="],";
	}
	xmlstr=xmlstr.substring(0,xmlstr.length()-1);
	xmlstr+="]";

	out.print(xmlstr);

%>
