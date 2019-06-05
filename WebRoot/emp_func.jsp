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

	OracleRowSet[] ors3 = new OracleRowSet[1];
	ors3[0] = new OracleRowSet(50);

	OracleRowSet[] ors4 = new OracleRowSet[1];
	ors4[0] = new OracleRowSet(50);

	if (eventResponse != null) {
		data = (HashMap) eventResponse.getBody();
		ors = (OracleRowSet[]) data.get("operation1");
		ors2 = (OracleRowSet[]) data.get("operation2");
		ors3 = (OracleRowSet[]) data.get("operation3");
		ors4 = (OracleRowSet[]) data.get("operation4");
	}
	String fid="";
if (ors4[0].getValue("rid").equals("")){
	fid = Azdg.encryptsubmit("fid=role.xml@saveemprole",
			SysConst.FORMACTION);
}
else
	{
	fid = Azdg.encryptsubmit("fid=role.xml@updateemprole",
			SysConst.FORMACTION);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>腾达事故车处理系统</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="title" content="" />
		<meta name="description" content="" />
		<link rel="stylesheet" type="text/css" href="css/base.css">
        <link rel="stylesheet" type="text/css" href="css/ht_css.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
	</head>
	<body>
    <div class=" contet_form">
    <!--位置&状态说明-->
    <div class="cot_top">
                            <p class="status">
                                <span class="cot_t"><img src="img/home_con.png" width="29" height="26" alt="所在位置" /></span>
                                <span class="cot_t font_black">&nbsp;当前位置:&nbsp;</span>
                                <span class="cot_t"><img src="img/arrow_con.png" width="29" height="26" alt="&gt;&gt;" /></span>
                                <span class="cot_t font_black">&nbsp;系统管理管理&nbsp; </span>
                                <span class="cot_t"><img src="img/arrow_con.png" width="29" height="26" alt="&gt;&gt;" /></span>
                                <span class="cot_t font_blue">用户权限修改</span>
                               	<span class="cot_t" style="float:right; line-height:35px; margin-right:20px; ">
                                	<a class="link_return" href="#">返回列表页>></a>
                                </span>
                    </p>
              </div>
             <!--end-->
   </br>
   </br>

							<form id="func_form" name="func_form" action="/mainservlet"
								method="post">
							<input id="handle" type="hidden" name="handle" value="<%=fid%>" />
							<input type="hidden" id="rid" name="rid" value='<%=ors4[0].getValue("rid")%>' />
							    <table class="admin_tab2">
							    <tr >
							    	<th  class="orange font_white">
							        	<span class="f_left"><img src="img/dot.png" width="30" height="30" alt="&gt;&gt;" />&nbsp;&nbsp;</span>
							             <span style="line-height:30px;" class="f_left"> 您修改的是&nbsp;【<%=ors4[0].getValue("rname") %>】&nbsp;的角色组成员！</span>
							            
							        </th>
							    </tr>
									<ul class="ul_qux">
									<%
										int count = 0;
										String checked = "";
										for (int i = 0; i < ors2.length; i++) {
									%>
									<tr class="tr_title">
										<td>
											<li style="float:none">
													<%=ors2[i].getValue("orgname")%>
											</li>
										</td>
                                        </tr>
                                        <tr>
                                        
										<td bgcolor="#FFFFFF">
									  <%
												for (int j = count; j < ors3.length; j++) {
														if (ors2[i].getValue("orgid").equals(
																ors3[j].getValue("dept"))) {
															//out.println(ors2[i].getValue("funcid"));
															//out.println(ors3[j].getValue("sup_func"));
															for (int x = 0; x < ors.length; x++) {
																//out.print("员工权限func_id");
																//out.println(ors[x].getValue("func_id"));
																//out.print("所有权限funcid");
																//out.println(ors3[j].getValue("funcid"));
																if (ors3[j].getValue("pid").equals(
																		ors[x].getValue("pid"))) {
																	checked = "checked";
																	break;
																} else {
																	checked = "";
																}
															}
											%>
											<ul class="ul_qux2">
												<li style="margin:8px;">
													<input id="funcsubid<%=i + j%>" name="funcsubid"
														type="checkbox" value="<%=ors3[j].getValue("pid")%>"
														<%out.print(checked);%> />
													<label for="funcsubid"><%=ors3[j].getValue("username")%></label>
												</li>
											</ul>
											<%
												count++;
														}//else{
											%>


											<%
												//}

													}
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
										<input class="button" type="button" value="返回" onclick="window.history.go(-1);" />
									</td>
								</tr>

							
	  						</table>
	  					</form>
    </div>
	
</body>
</html>
