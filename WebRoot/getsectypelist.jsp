<%@ page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%
	EventResponse eventResponse = (EventResponse) request
			.getAttribute("result");
	FormUtil form = new FormUtil();
	OracleRowSet[] ors = new OracleRowSet[1];
	ors[0] = new OracleRowSet(50);
	OracleRowSet[] ors1 = new OracleRowSet[1];
	ors1[0] = new OracleRowSet(50);
	HashMap data = null, olddata = null;
	
	if (eventResponse != null) {
		data = (HashMap) eventResponse.getBody();
		ors = (OracleRowSet[]) data.get("operation1");
		olddata = (HashMap) ((HashMap) eventResponse.getOriginBody())
				.get("operation1");
	}
	String cardid = "";
	int up=0,down=0;
  String condition="";
 
%>


 <option value="">全部</option>
   <%
                      for (int i = 0; i < ors.length; i++) {
                 %>
                <option value="<%=ors[i].getValue("code_id")%>"><%=ors[i].getValue("code_name")%></option>
                  <%
                     }
                 %>