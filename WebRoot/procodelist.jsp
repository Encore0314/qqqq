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
	String fid=Azdg.encryptsubmit("fid=agent.xml@agentmanage",SysConst.FORMACTION);
	if (eventResponse != null) {
		data = (HashMap) eventResponse.getBody();
		ors = (OracleRowSet[]) data.get("operation1");
		ors1 = (OracleRowSet[]) data.get("operation2");
		olddata = (HashMap) ((HashMap) eventResponse.getOriginBody())
				.get("operation1");
	}
	String cardid = "";
	int up=0,down=0;
  String condition="";
  if(ors1!=null){
	  if(!ors1[0].getValue("beg").equals("")&&!ors1[0].getValue("ys").equals(""))
	  {
	    if(ors1[0].getValue("ys").equals("0")){
	     down=1;
	    }else{
	    down=Integer.parseInt(ors1[0].getValue("beg"))+1;}
	    if(Integer.parseInt(ors1[0].getValue("beg"))>1){
	      up=Integer.parseInt(ors1[0].getValue("beg"))-1;
	    }
	    if(Integer.parseInt(ors1[0].getValue("beg"))==1){
		      up=1;
		    }	    
	    if(Integer.parseInt(ors1[0].getValue("beg"))==Integer.parseInt(ors1[0].getValue("ys"))){
	      down=Integer.parseInt(ors1[0].getValue("ys"));
	    }
	  }
    
     // if(!Tools.nvl(((String[])olddata.get("status"))[0],"").equals("")){
   	  // condition+="&status="+Tools.nvl(((String[])olddata.get("status"))[0],"");
      //}
	}
	
	String jspcode = FormBean.getRandom(8);
  	session.setAttribute("jspcode",jspcode);
%>


 <option value="">--请选择</option>
   <%
                      for (int i = 0; i < ors.length; i++) {
                 %>
                <option value="<%=ors[i].getValue("code_id")%>"><%=ors[i].getValue("code_name")%></option>
                  <%
                     }
                 %>