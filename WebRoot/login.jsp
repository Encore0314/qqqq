<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%@ page import="sun.jdbc.rowset.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="img/td_title.ico" rel="shortcut icon" />
<link rel="stylesheet" type="text/css" href="css/layout.css" />
<link rel="stylesheet" type="text/css" href="css/ht_css.css">

<script type="text/javascript">
function checkLogin(){
	if( document.formLogin.id.value==""||document.formLogin.id.value=='用户名'){
		alert("请输入账号！");
		document.formLogin.id.focus();
		return false;
	}
	if( document.formLogin.passwords.value==""){
		alert("请输入密码！");
		document.formLogin.passwords.focus();
		return false;
	}

	return true ;
}

</script>
<title>青浦区促进就业管理平台</title>
</head>

<body>
<div class="lo_body">
	<div class="lo_center">
	<div class="lo_cont">
    	<div class="lo_form_bg">
        	<div class="lo_form">
        	<form name="formLogin" action="/mainservlet" id="form1" method="post" onsubmit="return checkLogin();">
<input id="handle" type="hidden" name="handle" value="E299744D88ADCDF56D9CE870B80C795E33B34DAB6D91425D">
<input id="rurl" type="hidden" name="handle" value="null">
  	<table class="login_tb" width="100%" cellpadding="0" vspace="0">
    <tbody>
    <tr>
    	<td width="50%"   ><img  src="img/login_img.png" width="380"  alt="欢迎您！！！" /></td>
    
    	
    	<td >
        	<div class="lo_td">
        <table width="100%" cellpadding="0" vspace="0">
        	<tbody>
        	<tr>
      <th colspan="2" align="left">请输入账号：</th>
	</tr>
    
    <tr>
      <td colspan="2"><input class="lo-inpt" style=" background:url(img/login_con.png) no-repeat right;" type="text" name="id" placeholder="请输入用户名"></td>
    </tr>
    
    <tr>
      <th colspan="2" align="left" >请输入密码：</th>
	</tr>
    
    <tr>
      <td colspan="2"><input class="lo-inpt" style=" background:url(img/login_con_pass.png) no-repeat right" placeholder="请输入密码" type="password" name="passwords"></td>
    </tr>
    

    <tr>
      <td align="left" colspan="2"><input class="lo-btn" type="button" value="登陆" onclick="if(checkLogin())formLogin.submit();"></td>
      </tr>
      <tr>
      <td align="right" colspan="2"><input class="lo-btn2" style="background:#999; border:#838383 1px solid" type="button" value="取消"></td>
    </tr>
    	</tbody>
        </table>
        </div>
        </td>
    </tr>
    
     </tbody>
     </table>
     </form>
        </div>
    
    </div>

</div>
</div>
</div>
</body>
</html>
