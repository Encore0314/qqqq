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
String sup_code_id="",codetype="";
if(olddata!=null)
    if(!Tools.nvl(((String[])olddata.get("sup_code_id"))[0],"").equals("")){
    	sup_code_id=Tools.nvl(((String[])olddata.get("sup_code_id"))[0],"");
    }

if(!Tools.nvl(((String[])olddata.get("codetype"))[0],"").equals("")){
	codetype=Tools.nvl(((String[])olddata.get("codetype"))[0],"");
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>代码管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="title" content=""/>
<meta name="description" content=""/>
    <link href="/css/mycss.css" rel="stylesheet"/>
<script type="text/javascript" src="/js/mootools-1.2.4-core-nc-vsdoc.js"></script>
<script type="text/javascript" src="/js/mootools-1.2.4.4-more-vsdoc.js"></script>
</head>
<body>
<div class="page2">

  <!--nav-->  
  <div  class=" basic-grey">

 <div class="btntabr_div" style="padding-right: 5px;">
<p> 代码类型：<select class="" name="codetype" id="codetype" onchange="location='/mainservlet?handle=<%=Azdg.encrypt("fid=code.xml@codelist&sup_code_id="+sup_code_id,SysConst.FORMACTION) %>&codetype='+$('codetype').value;">增加同级代码</a> &nbsp;|&nbsp; <a href="/mainservlet?handle=<%=Azdg.encrypt("fid=code.xml@codelist&sup_code_id="+ors1[0].getValue("sup_code_id"),SysConst.FORMACTION) %>&codetype=$('codetype').value;">
  <option>-=请选择=-</option>
  <%=form.popListWithSelect("select a.typeid,a.typename from tb_codetype a",codetype)  %>
  </select>&nbsp;&nbsp;
  上级代码：<%=ors1[0].getValue("code_id") %><%=ors1[0].getValue("code_name") %> </p>
  <p align="right" >
  <a class="button3" href="javascript;" onclick="location='/mainservlet?handle=<%=Azdg.encrypt("fid=code.xml@gotoinscode&sup_code_id="+sup_code_id,SysConst.FORMACTION) %>&codetype='+$('codetype').value;">增加同级代码</a>
 <a class="button3" href="javascript;" onclick="location='/mainservlet?handle=<%=Azdg.encrypt("fid=code.xml@codelist&sup_code_id="+ors1[0].getValue("sup_code_id"),SysConst.FORMACTION) %>&codetype='+$('codetype').value;">向上</a></p>
</a>
</div>
 <div class="div-table">
 	
   
       <table width="100%" class="tab_nor" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <th width="10%" align="center" nowrap="nowrap" >序号</th>
 		<th align="center" nowrap="nowrap">代码</th>
		<th width="25%" align="center" nowrap="nowrap"  >名称</th>
		<th width="20%" align="center" nowrap="nowrap"  >备注</th>
		<th width="20%" align="center" nowrap="nowrap"  >操作</th>
		
	   </tr>
           <% for(int i=0;i<ors.length;i++){
        	if(!ors[i].getValue("code_id").equals("")){
        	%>
           <tr>
            <td align="center"><%=ors[i].getValue("ordernumber") %></td>
            <td align="center" ><%=ors[i].getValue("code_id") %></td>
            <td><%=ors[i].getValue("code_name") %></td>
            <td><%=ors[i].getValue("prop_a") %></td>
           
            <td align="center"><a class="lin-normal" href="#" onclick="location='/mainservlet?handle=<%=Azdg.encrypt("fid=code.xml@codelist&sup_code_id="+ors[i].getValue("code_id"),SysConst.FORMACTION) %>&codetype='+$('codetype').value;">查看下级代码</a>&nbsp;|&nbsp;<a class="lin-normal" href="/mainservlet?handle=<%=Azdg.encrypt("fid=code.xml@gotomodcode&code_id="+ors[i].getValue("code_id")+"&codetype="+codetype,SysConst.FORMACTION) %>">修改</a>&nbsp;|&nbsp;<a class="lin-normal" href="/mainservlet?handle=<%=Azdg.encrypt("fid=code.xml@delcode&code_id="+ors[i].getValue("code_id")+"&sup_code_id="+sup_code_id+"&codetype="+codetype,SysConst.FORMACTION) %>">删除</a></td>
         </tr>
             <% } } %>
    </table>

 </div>

</div>
</div>
</body>
</html>


