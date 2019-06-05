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
		<title>角色管理</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="title" content="" />
		<meta name="description" content="" />
<link type="text/css" rel="stylesheet" href="/avalon/style/avalon.doc.css"/>
<link rel="stylesheet" type="text/css" href="css/mycss.css">
	<script type="text/javascript" src="/js/mootools-1.2.4-core-nc-vsdoc.js"></script>
<script type="text/javascript" src="/js/mootools-1.2.4.4-more-vsdoc.js"></script>
<script type="text/javascript" src="js/myjslib-vsdoc.js"></script>
<script type="text/javascript">
function checkDel(carid){
     if(confirm("确定要删除吗？")){
           //执行删除操作
          location.href="/mainservlet?handle=<%=Azdg.encrypt("fid=role.xml@dodelete" ,SysConst.FORMACTION) %>"
                                     +"&rid="+carid;
     }
}
</script>
	</head>
	<body>
        <div class="page">
    	<div class=" basic-grey">
    		 <div class="btntabr_div" style="margin-right: 5px;">
	    		<p align="right"><a class="button3" href="/mainservlet?handle=<%=Azdg.encrypt("fid=role.xml@privmanage&rid=",SysConst.FORMACTION) %>"> 
	                        	添加新角色
                 		</a></p>
             </div>
        	<div class="div-table">
            	
                        <%if(ors[0].getValue("rid").equals("")){ %>
                                
                                 无角色信息
                          <%}else{ %>
                			<table width="100%" class="tab_nor">
                      <tr align="center">
									<th width="60"   nowrap="nowrap"  >
										序号
									</th>
									<th width="20%"  nowrap="nowrap"  >
										名字
									</th>
									<th width="20%" nowrap="nowrap"  >
										权限数
									</th>
									<td wiwidth="20%" nowrap="nowrap"  >
										员工数
									</th>
                                    <th  nowrap="nowrap"  >
										操作
									</th>
								
								</tr>
								<%
								   String userID=null;
									for (int i = 0; i < ors.length; i++) {
										userID =ors[i].getValue("rid");
								%>
                               	  <tr align="center" >
									<td  ><%=i+1%></td>
									<td  ><%=ors[i].getValue("rname")%></td>
									<td ><%=ors[i].getValue("countf")%></td>
									<td  ><%=ors[i].getValue("countp")%></td>
									
			
                  <td >
				 
                  <a class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=role.xml@privmanage&rid=" + ors[i].getValue("rid"),SysConst.FORMACTION) %>">权限修改
                  </a>&nbsp;|&nbsp;
                  <a class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=role.xml@emprole&rid=" + ors[i].getValue("rid"),SysConst.FORMACTION) %>">成员
                  </a>&nbsp;|&nbsp;
                   <a class="lin_cz" Onclick="checkDel('<%=ors[i].getValue("rid") %>');"  >删除</a>

									</td>


								</tr>
								<%
									
									}
								%>
							</table>

            </div>
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

        </div>
</div>
    
    
    
</body>
</html>


