<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%
	int func_level = 4;
	EventResponse eventResponse = (EventResponse) request
			.getAttribute("result");
	HashMap data = null;

	OracleRowSet[] ors = new OracleRowSet[1];
	ors[0] = new OracleRowSet(50);

	OracleRowSet[] ors2 = new OracleRowSet[1];
	ors2[0] = new OracleRowSet(50);



	if (eventResponse != null) {
		data = (HashMap) eventResponse.getBody();
		ors = (OracleRowSet[]) data.get("operation1");
		ors2 = (OracleRowSet[]) data.get("operation2");

	}

	String fid = Azdg.encryptsubmit("fid=user.xml@savepriv",
			SysConst.FORMACTION);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>用户权限设置</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="title" content="" />
		<meta name="description" content="" />
<link type="text/css" rel="stylesheet" href="/avalon/style/avalon.doc.css"/>
<link rel="stylesheet" type="text/css" href="css/mycss.css">
	</head>
	<body>
        <div class="page">
    	<div class=" basic-grey">
        	<div class="div-table">
              <p align="left">您修改的是&nbsp;【<%=ors2[0].getValue("username") %>】&nbsp;的使用权限！</p>
            	    <table width="100%">
							<form id="func_form" name="func_form" action="/mainservlet"
								method="post">

								<input id="handle" type="hidden" name="handle" value="<%=fid%>" />
								<input type="hidden" id="pid" name="pid"
									value='<%=ors2[0].getValue("pid")%>' />
  <ul class="ul_qux">
								
									  <%
									  String checked="";
												for (int j = 0; j < ors.length; j++) {
												
																if (!ors[j].getValue("pid").equals("")) {
																	checked = "checked";
																} else {
																	checked = "";
																}
														
											%>
											<ul class="ul_qux2">
												<li >
													<input  name="funcsubid"
														type="checkbox" value="<%=ors[j].getValue("rid")%>"
														<%out.print(checked);%> />
													<label for="funcsubid"><%=ors[j].getValue("rname")%></label>
												</li>
											</ul>
											


											<%
												//}

												
												}
											%>
											</li>
							</ul>
								</td>
								</tr>
								<tr>
					  <td  align="center" >
										<input class="button" type="submit" value="提交" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="button3" type="button" value="返回" onclick="window.history.go(-1);" />
									</td>
								</tr>
							</form>
							
	  </table>

            </div>
         </div>
         
        </div>

    
    
  
	
</body>
</html>
