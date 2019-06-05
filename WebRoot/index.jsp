<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%@ page import="sun.jdbc.rowset.*"%>
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
FormUtil form = new FormUtil();
OracleRowSet[] ors=new OracleRowSet[1];
ors[0]=new OracleRowSet(50);

HashMap data=null,olddata=null;
if(eventResponse!=null){
     data=(HashMap)eventResponse.getBody();
     ors=(OracleRowSet[])data.get("operation1");
     olddata=(HashMap)((HashMap)eventResponse.getOriginBody()).get("operation1");
}
HashMap user1 = (HashMap) session.getAttribute(SysConst.LOGIN_USER);
String pid="",urltt="",username="",deptname="",position="",rid="";
FormUtil futil=new FormUtil();
if(user1!=null){
	 pid=(String)user1.get("pid");
	 rid=(String)user1.get("rid");
	 username=(String)user1.get("username");
	 deptname=(String)user1.get("deptname");
	 position=(String)user1.get("position");
	 urltt=Azdg.encrypt("fid=login.xml@gotomain",SysConst.FORMACTION);
}else{
	 response.sendRedirect("/globe/struct/struct_fault.jsp?flag=1");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="img/td_title.ico" rel="shortcut icon" />
<link rel="stylesheet" type="text/css" href="css/base.css" />
<link rel="stylesheet" type="text/css" href="css/layout.css" />
<link rel="stylesheet" type="text/css" href="css/ht_css.css" />
	<link rel="stylesheet" href="css/tab-view.css" type="text/css" media="screen">
<link rel="stylesheet" type="text/css" href="js/tree_themes/SimpleTree2.css"/>
<link rel="stylesheet" type="text/css" href="css/mycss.css">
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/tab-view.js"></script>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/SimpleTree.js"></script>
<script type="text/javascript">
$(function(){
	$(".st_tree").SimpleTree({
		click:function(a){
			if(!$(a).attr("hasChild"));
				
		}
	});
});
</script>

	</head>
<title></title>
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
    <div id="page_body">
        			<!--左侧边栏--><%@include file="left_nav.jsp"%><!--左侧边栏-->

    <!--头部-->
<div class="header">
      
 
          <!--logo-->
          <div class="kj_b">
           	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="10%" nowrap="nowrap"><h3 class="font_white"><%=ors[0].getValue("funcname") %></h3></td>
    <td width="5%" align="right" nowrap="nowrap"><p class="font_white">
    <span class="font_white"><a class="font_white" href="/mainservlet?handle=<%=Azdg.encrypt("fid=login.xml@adminlist",SysConst.FORMACTION) %>">其他子系统</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
    <span class="font_white">您好！&nbsp;<%=username %>&nbsp;(<%=deptname %>)&nbsp;&nbsp;|&nbsp;&nbsp;
    <a class="font_white"  href="#" onclick="popup2();">修改密码</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
    <span><a class="font_white" href="/logout.jsp" >安全退出</a></span>
    </p>
    </td>
  </tr>
</table>

          </div>
          <!--end-->
      </div>
   
    
    
       
    <!--end-->
    
    <!--主体-->

       <div class="content">
       

        <!--end-->	  
          <div class="cot_com">
          <!--分页-->
          <div id="dhtmlgoodies_tabView1" >
                <div class="dhtmlgoodies_aTab" style="margin-left:0px;">
                    <div class="welcom">
                    </div>
                </div>
				</div>
<script type="text/javascript">

initTabs('dhtmlgoodies_tabView1',Array('欢迎您！'),0,document.body.offsetWidth-200,'',Array(false,true,true,true));
function sethei()
{
	 var tabs=$('.dhtmlgoodies_aTab');
	 for(var u=0;u<tabs.length;u++)
		 {
		   if(tabs[u].getStyle('display')=='block')
			   {
			     //alert(tabs[u].getFirst().get('height'));
			     SetWinHeight(tabs[u].getFirst()) 
			   }
		 }
	
	
}

</script>
          <!--end-->
    </div>       
    </div>
             	</div>

    <!--end-->
    
    </div>    
<div class="clear"></div>

<script type="text/javascript">
function updatapwd(){
  if( document.uppwdform.oldpwd.value==""){
    alert("请输入旧密码！");
    document.uppwdform.oldpwd.focus();
    return false;
  }
  if( document.uppwdform.newpwd1.value==""){
    alert("请输入新密码！");
    document.uppwdform.newpwd1.focus();
    return false;
  }
  if( document.uppwdform.newpwd2.value!=document.uppwdform.newpwd1.value){
    alert("两次输入不一致！");
    document.uppwdform.newpwd2.focus();
    return false;
  }
  if( document.uppwdform.rand.value==""){
    alert("请输入验证码！");
    document.uppwdform.rand.focus();
    return false;
  }
  return true ;
}
</script>
</body>
</html>
