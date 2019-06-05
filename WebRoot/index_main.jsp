<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%@ page import="sun.jdbc.rowset.*"%>
<%
HashMap user1 = (HashMap) session.getAttribute(SysConst.LOGIN_USER);
String pid="",urltt="",username="",deptname="",position="";
FormUtil futil=new FormUtil();
if(user1!=null){
	 pid=(String)user1.get("pid");
	 username=(String)user1.get("username");
	 deptname=(String)user1.get("deptname");
	 position=(String)user1.get("position");
	 urltt=Azdg.encrypt("fid=login.xml@gotomain",SysConst.FORMACTION);
}else{
	 response.sendRedirect("/globe/struct/struct_fault.jsp?flag=1");
}
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
     olddata=(HashMap)((HashMap)eventResponse.getOriginBody()).get("operation1");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="img/td_title.ico" rel="shortcut icon" />
<link href="css/mycss.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="css/layout.css" />
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/tab-view.js"></script>
	<script type="text/javascript" src="js/mootools-core-1.5.0-full-compat.js"></script>
<script type="text/javascript" src="js/mootools-more-1.5.0.js"></script>
<script type="text/javascript">
  function closediv2(){
    //alert('1');
   $('btbz').setStyle('display','none');
  // btbz();
 }
 function popup2(){
   //alert('1');
   $('btbz').setStyle('display','block');
 }
</script>
<title>青浦区促进就业管理系统</title>
</head>

<body>
<!--修改密码弹出层-->
<div id="btbz" style="display:none;">
  <div class="zz"></div>
  <div class="inp_pass" style="width:50%; left:25%">
   
         <div class=" basic-grey">
    <div class="tit">
        <p align="center"><strong>修改密码</strong></p>
</div>
<div class="div-table" style="width: 520px; margin:0 auto">
        <form name="uppwdform" action="/mainservlet" id="form1" method="post" onSubmit="return updatapwd();">
  <input id="fid" type="hidden" name="fid" value="login.xml@upadminpwd1" />
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <th align="right"  nowrap>旧密码：</th>
        <td align="left" colspan="2"><input type="password" id="oldpwd" name="oldpwd" class="form-inp" /></td>
      </tr>
      <tr>
        <th align="right" nowrap>新密码：</th>
        <td align="left" colspan="2"><input type="password" id="newpwd1" class="form-inp" name="newpwd1" /></td>
      </tr>
      <tr>
        <th align="right" nowrap>确认新密码：</th>
        <td align="left" colspan="2"><input type="password" id="newpwd2" name="newpwd2" class="form-inp"/></td>
      </tr>
      <tr>
        <th align="right" nowrap>验证码：</th>
        <td align="left" width="130">
        <input type="text" id="rand" name="rand" class="form-inp" style="width: 130px" /></td>
        <td><img border="0" src="image.jsp" width="70" /></td>
      </tr>
      <tr>
        
        <td  align="center" colspan="3">
        <input type="submit" value="确认修改" class="button"  />
          &nbsp;  &nbsp;
        <input class="button2" type="button" value="关闭" onclick="closediv2()"></td>        
      </tr>
    </table>
    </form>
</div>
  </div>
         
        </div>
  </div>

<!--修改密码弹出层_end-->
<div class="header">
	<div class="main-top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>          	<h1 class="font_white">青浦区促进就业管理系统</h1></td>
    <td width="5%" align="right" nowrap="nowrap"><span class="font_white">您好！&nbsp;<%=username %>&nbsp;&nbsp;|&nbsp;&nbsp;</span></td>
    <td width="5%" align="right" nowrap="nowrap">    <a class="font_white"  href="#" onclick="popup2();">修改密码</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
    <span><a class="font_white" href="/logout.jsp" >安全退出</a></span></td>
  </tr>
</table>
</div>
</div>
<div class="page">
  <div class=" main-div">
   <%for(int i=0;i<ors.length;i++){
	   if(ors[i].getValue("funcname")!=""){
	   %>
       <div class="main-con">
   <a href="/mainservlet?handle=<%=Azdg.encrypt("fid=login.xml@gotoindex&funcid="+ors[i].getValue("funcid"),SysConst.FORMACTION) %>">
   		<p align="center"><img src="images/<%=ors[i].getValue("img_url") %>" alt="创业补贴子系统" /></p>
   		<p align="center"><%=ors[i].getValue("funcname") %></p>
   </a>
   </div>
   <%}} %>
   </div>
   </div>
</body>
</html>
