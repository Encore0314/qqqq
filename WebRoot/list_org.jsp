<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
FormUtil form = new FormUtil();
OracleRowSet[] ors=new OracleRowSet[1];
ors[0]=new OracleRowSet(50);
OracleRowSet[] ors1=new OracleRowSet[1];
ors1[0]=new OracleRowSet(50);
HashMap data=null,olddata=null;
if(eventResponse!=null){
     data=(HashMap)eventResponse.getBody();
     ors=(OracleRowSet[])data.get("operation1");
     ors1=(OracleRowSet[])data.get("operation2");
     olddata=(HashMap)((HashMap)eventResponse.getOriginBody()).get("operation1");
}


int up=0,down=0;
String suporgid="";
if(olddata!=null)
    if(!Tools.nvl(((String[])olddata.get("suporgid"))[0],"").equals("")){
    	suporgid=Tools.nvl(((String[])olddata.get("suporgid"))[0],"");
    }



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>腾达事故车处理系统-机构管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="title" content=""/>
<meta name="description" content=""/>
<link href="/css/mycss.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="/js/mootools-1.2.4-core-nc-vsdoc.js"></script>
<script type="text/javascript" src="/js/mootools-1.2.4.4-more-vsdoc.js"></script>
</head>
<body>
<div class="page2">

	 <div  class=" basic-grey">

    <div class="btntabr_div" style="margin-right: 5px;">
           
 <p><span class="butt_span" >上级机构:<%=ors1[0].getValue("orgname") %> 序号：<%=ors1[0].getValue("dept_sort") %>  </span>
    <p align="right">
      <span ><a class="button3"  href="/mainservlet?handle=<%=Azdg.encrypt("fid=org.xml@orglist&suporgid="+ors1[0].getValue("suporgid"),SysConst.FORMACTION) %>">向上</a></span>
          <span  margin-right: 5px;><a class="button3"  href="/mainservlet?handle=<%=Azdg.encrypt("fid=org.xml@gotoinsorg&suporgid="+suporgid,SysConst.FORMACTION) %>">增加同级机构</a> </span>
  
       
  </p>
</div>
             <div class="div-table">
             	
   <table width="100%" class="tab_nor" border="0" cellspacing="0" cellpadding="0">
 	
        <tr>
        <th align="center"   >序号</th>
 		<th width="20%" align="center"   >代码</th>
		<th width="25%" align="center"   >名称</th>
		
		<th align="center"   >备注</th>
		<th width="25%" align="center"   >操作</th>
		
	   </tr>
           <% for(int i=0;i<ors.length;i++){
        	if(!ors[i].getValue("orgid").equals("")){
        	%>
        <tr>
        <td align="center" ><%=ors[i].getValue("dept_sort") %></td>
            <td align="center" ><%=ors[i].getValue("orgid") %></td>
            <td  ><%=ors[i].getValue("orgname") %></td>
            <td  ><%=ors[i].getValue("remark") %></td>
            <td align="center"  >
            <a class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=org.xml@orglist&suporgid="+ors[i].getValue("orgid"),SysConst.FORMACTION) %>">查看下级代码</a>&nbsp;|&nbsp;
            <a class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=org.xml@gotomodorg&orgid="+ors[i].getValue("orgid"),SysConst.FORMACTION) %>">修改</a>&nbsp;|&nbsp;
            <a  class="lin_cz" href="/mainservlet?handle=<%=Azdg.encrypt("fid=org.xml@delorg&orgid="+ors[i].getValue("orgid")+"&suporgid="+suporgid,SysConst.FORMACTION) %>">删除</a></td>
            </tr>
             <% } } %>
           </table>

             </div>
            </div>
</div>


</body>
</html>


