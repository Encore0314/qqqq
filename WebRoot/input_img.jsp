<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
HashMap data = null;

OracleRowSet[] ors = new OracleRowSet[1];
ors[0] = new OracleRowSet(50);

OracleRowSet[] ors1 = new OracleRowSet[1];
ors1[0] = new OracleRowSet(50);
if (eventResponse != null) {
	data = (HashMap) eventResponse.getBody();
	ors = (OracleRowSet[]) data.get("operation1");
	ors1 = (OracleRowSet[]) data.get("operation2");
}

String fualtmsg="";
if(eventResponse!=null){ 
fualtmsg = eventResponse.getFaultMsg();}
String rurl=request.getHeader("referer");
String fid=Azdg.encryptsubmit("fid=images.xml@doadd",SysConst.FORMACTION);
String url=Azdg.encrypt("fid=code.xml@getcode",SysConst.FORMACTION);
String url2=Azdg.encrypt("fid=code.xml@getcode2",SysConst.FORMACTION);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>公告管理</title>
<meta http-equiv="title" content=""/>
<meta name="description" content=""/>
<link rel="stylesheet" type="text/css" href="css/base.css">
<link rel="stylesheet" type="text/css" href="css/ht_css.css">
<link rel="stylesheet" type="text/css" href="css/layout.css">
<script type="text/javascript" src="/js/jquery-1.8.2.min.js"></script>
<script src="/js/uploadjq.js" type="text/javascript"></script>
<script type="text/javascript">

$(function () {
            
           setupload($('#upfile'));
            
        });
function dosubmit()
{
        var flag=true;
         var inputs=$("[reod]");
         for (var i = 0 ; i <inputs.length; i++) {
           if($(inputs[i]).val()=='')
           {
		    
			Showbo.Msg.alert($(inputs[i]).attr('reod')+'不能为空!');
			$(inputs[i]).focus();
             flag=false;  
             
			break;
			
           }
		   
         };
		 if(flag)
		 {
		  
		  $('form').submit();
		 }

   
  
}
          
         
</script>
</head>
<body>
<!--header-->
<!--head_nav-->
<div class="contet_form">
	<!--位置&状态说明-->
    <div class="cot_top">
                            <p class="status">
                                <span class="cot_t"><img src="img/home_con.png" width="29" height="26" alt="所在位置" /></span>
                                <span class="cot_t font_black">&nbsp;当前位置:&nbsp;</span>
                                <span class="cot_t"><img src="img/arrow_con.png" width="29" height="26" alt="&gt;&gt;" /></span>
                                <span class="cot_t font_black">&nbsp;系统管理管理&nbsp; </span>
                                <span class="cot_t"><img src="img/arrow_con.png" width="29" height="26" alt="&gt;&gt;" /></span>
                                <span class="cot_t font_blue">发布公告信息</span>
                               	<span class="cot_t" style="float:right; line-height:35px; margin-right:20px; ">
                                	<a class="link_return" href="/mainservlet?handle=<%=Azdg.encrypt("fid=images.xml@gotoupdate",SysConst.FORMACTION)%>">返回列表页>></a>
                                </span>
                    </p>
              </div>
             <!--end-->
   
  <!--nav-->  
  
<div> 
 
  <div class="table_box2">
  <form name="postform" action="/mainservlet" id="postform" method="post" >
       <input id="handle" type="hidden" name="handle" value="<%=fid%>" />
       <input id="imgpath" type="hidden" name="imgpath1" value="" />

    <table class="admin_tab2">
      <tr class="tr_title">
        <td colspan="3" align="center" class="td_title"><strong>添加轮播图片</strong></td>
      </tr>
      <tr>
        
        <td width="105" class="his_title td_right"><span class="red"><img src="img/star.png" width="9" height="9" alt="*" /></span><strong>链接：</strong></td>
        <td class="td_con" colspan="2">
        	<span style="background:url(img/light.png) no-repeat right center; display:block;"><input style="width:400px;" type="text" title="链接" id="title"  name="title" datetype="{'type':'char','maxlength':'500',isnotnull:true}" value="" /></span></td>
        
      </tr>
         <tr>
         <td class="his_title td_right"><strong>轮播图片上传：</strong></td>
     
   
							<td width="610" align="left"  bgcolor="#FFFFFF">

									<div class="upimg_div">
              <div class="imgup">
          
          <img id="upfileshow" style="width:100px"  />
          
        </div>
        </div>
								
						  </td>
                           <td width="172" align="center" valign="middle">
								<input id="upfile"  type="button" class="btn-green" id="image3_bt" style="width: 70px"
			datetype="{'type':'file','maxsize':'2000',isnotnull:false,'fext':'jpg,gif,bmp,JPG,GIF,BMP','showtype':'picture','showcontainer':'simage3','savepath':'d:\\\\carimage','shownum':'1'}"
			value="上传" title="图片3" />
							</td>
	  </tr>
	  <tr>
        <td width="105" class="his_title td_right"><span class="red"><img src="img/star.png" width="9" height="9" alt="*" /></span><strong>主标题：</strong></td>
        <td class="td_con" colspan="2">
        	<span style="display:block;"><input style="width:96%;" type="text" title="主标题" id="content"  name="content" datetype="{'type':'char','maxlength':'500',isnotnull:true}" value="" /></span></td>
      </tr>
      <tr>
        <td width="105" class="his_title td_right"><span class="red"><img src="img/star.png" width="9" height="9" alt="*" /></span><strong>副标题：</strong></td>
        <td class="td_con" colspan="2">
        	<span style="display:block;"><input style="width:96%;" type="text" title="副标题" id="content2"  name="content2" datetype="{'type':'char','maxlength':'500',isnotnull:true}" value="" /></span></td>
      </tr>
      <tr>
        <td colspan="3" align="center"><input type="button" class="button" onClick="dosubmit()"  value="提&nbsp;交"/></td>
      </tr>
     	
        
        
    
    </table>
  </form>
</div>
<!--footer-->
<!--body_bac-->
</body>
</html>
