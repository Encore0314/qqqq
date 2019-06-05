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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>会员管理</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="title" content="" />
		<meta name="description" content="" />
        <link type="text/css" rel="stylesheet" href="/avalon/style/avalon.doc.css"/>
        <link rel="stylesheet" type="text/css" href="css/mycss.css">
	</head>
	<body>
        	
        
			<!--nav-->
		
			<table width="100%" class="tab_nor" border="0" cellspacing="0" cellpadding="0">
            	

            					<%if(ors[0].getValue("userid").equals("")){ %>
                                
                                 无员工信息
                          <%}else{ %>
           	  		
                      
                                	<tr align="center" >
									<th   nowrap="nowrap"  >
										工号
									</th>
									<th  nowrap="nowrap"  >
										姓名
									</th>
									<th   nowrap="nowrap"  >
										性别
									</th>
									<th  nowrap="nowrap"  >
										年龄
									</th>
									<th  nowrap="nowrap"  >
										邮箱
									</th>
									<th   nowrap="nowrap"  >
										电话</th>

									<th  nowrap="nowrap"  >
										所在机构
									</th>
									<th  nowrap="nowrap"  >
										角色
									</th>
									<th  nowrap="nowrap"  >
										状态
									</th>
								</tr>
								<%
								   String userID=null;
									for (int i = 0; i < ors.length; i++) {
										userID =ors[i].getValue("userid");
								%>
                               
								
				  <tr align="center" class="bg_white">
									<td nowrap="nowrap"  ><%=userID%></td>
					<td nowrap="nowrap"  ><%=ors[i].getValue("username")%></td>
					<td nowrap="nowrap" ><%=ors[i].getValue("sex")%></td>
					<td nowrap="nowrap"  ><%=ors[i].getValue("age")%></td>
					<td align="left" nowrap="nowrap" ><%=ors[i].getValue("email")%></td>
					<td nowrap="nowrap" ><%=ors[i].getValue("telephone")%></td>
									<td nowrap="nowrap" ><%=ors[i].getValue("orgname")%></td>
									<td nowrap="nowrap" ><%=ors[i].getValue("rname")%></td>
									<td nowrap="nowrap" >
										<a class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=user.xml@gotoupuser&pid=" + ors[i].getValue("pid"),SysConst.FORMACTION) %>">修改信息
                                        </a>&nbsp;|&nbsp;
                                        <a class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=employee.xml@init_employee&pid="+ors[i].getValue("pid"),SysConst.FORMACTION)%>" 
                                        onclick="return confirm('您是否确认初始化密码？');">初始化密码</a>
                                        &nbsp;|&nbsp;
										<a class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=user.xml@deluser&userid="
							+ userID + "&cardid=" + cardid,
							SysConst.FORMACTION)%>" onclick="return confirm('您是否确认删除？');">删除
                            			</a>&nbsp;|&nbsp;
							
										<a class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=user.xml@privmanage&pid=" + ors[i].getValue("pid"),SysConst.FORMACTION) %>">角色
                                        </a>
									</td>


								</tr>
								<%
									
									}
								%>
							</table>
          
         
 <!--页数-->
<div class="page_box">
<table class="page_table">
<tr>
    <td align="center" valign="middle" nowrap="nowrap" class="td_page">
    	<span><font><a href="###" onClick="Show(1)">首页</a></font></span>
    </td>
    <td>&nbsp;&nbsp;</td>
    <td nowrap="nowrap" class="td_page">
    	<span><font><a href="###"  onclick="Show(<%=up%>)">上一页</a></font></span>
    </td> 
    <td>&nbsp;&nbsp;</td>
    <td nowrap="nowrap" class="td_page">
    	<span><font><a href="###" onClick="Show(<%=down%>)"> 下一页</a></font></span> 
    </td>
    <td>&nbsp;&nbsp;</td>
    <td nowrap="nowrap" class="td_page">
    	<span><font><a href="###"  onclick="Show(<%=ors1[0].getValue("ys").equals("0")?"1":ors1[0].getValue("ys")%>)">尾页</a></font></span>
    </td>
    <td>&nbsp;&nbsp;</td>
    <td nowrap="nowrap" class="td_page">
    	<span><font>第<%=ors1[0].getValue("beg") %>页</font></span>
    </td>
    <td>&nbsp;&nbsp;</td>
    <td nowrap="nowrap" class="td_page">
        <span><font><%if(ors1[0].getValue("ys").equals("0")){%>共1页
        <%}else{ %>    
        共<%=ors1[0].getValue("ys") %>页
        <%}%>
        </font>
        </span>
    </td>
    <td nowrap="nowrap">&nbsp;&nbsp;</td>
    <td nowrap="nowrap" class="td_page">
    	<span><font>共<%=ors1[0].getValue("allrs") %>条记录</font></span>
    </td>
        


</tr>
</table>
</div> 
<!--页数-->
<%} %>
</body>
</html>


