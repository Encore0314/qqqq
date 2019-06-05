<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="sun.jdbc.rowset.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.basebean.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="sun.jdbc.rowset.*"%>
<%@ page import="java.net.*" %>
<%
HttpServletRequest hreq = (HttpServletRequest) request;
HashMap user = (HashMap) hreq.getSession(false).getAttribute(SysConst.LOGIN_USER);

EventResponse eventResponse = (EventResponse) request.getAttribute("result");
OracleRowSet[] ors=new OracleRowSet[1];
ors[0]=new OracleRowSet(50);
OracleRowSet[] ors1= new OracleRowSet[1];
ors1[0]=new OracleRowSet(50); 
HashMap data=null,olddata=null;
String auctionnum="",condition="";
int up=1,down=1;
int length= 0;
if(eventResponse!=null){
  data=(HashMap)eventResponse.getBody();
  ors=(OracleRowSet[])data.get("operation1");
  ors1=(OracleRowSet[])data.get("operation2");
  length= ors.length;
  olddata=(HashMap)((HashMap)eventResponse.getOriginBody()).get("operation1");
}
	FormUtil futil = new FormUtil();

	DBTransUtil dbutil = new DBTransUtil();
	String currentDate = dbutil.getColumnValue("select sys_p.date_to_char(sysdate,5) from dual");
	//CachedRowSet menu = dbutil.getResultBySelect("select code_id, code_name from code_info where code_type=24");
	String jspcode = FormBean.getRandom(8);
session.setAttribute("jspcode",jspcode);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<TITLE>新增</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"/>
<link href="css/csslh.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/mootools-1.2.4-core-nc-vsdoc.js"></script>
<script type="text/javascript" src="/js/mootools-1.2.4.4-more-vsdoc.js"></script>
<script type="text/javascript" src="js/myjslib-vsdoc.js"></script>
<script type="text/javascript" src="/js/newcalendar.js"></script>
  

</head>
<body>
<body>
<style>
.admin_con{ font-family:"微软雅黑"; font-size:14px; width:50%; margin:35px auto; border-radius:5px; border:1px solid #eeeeee; box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2); padding:15px;}
.Record{}
	.Record th{ border-bottom:2px solid #3e86af; color:#3e86af; padding:8px 6px; font-size:16px; font-weight:bold;}
	.Record td{ padding:8px 6px;}
	.admin_button{ padding:5px 15px; border-radius:3px; border:none; background-color:#3e86af; color:#FFF; font-weight:800; outline:none; }
	.red{ color:#F00; font-size:12px;}
</style>
<div class="admin_con">
<form id="postForm" action="/do_upload.jsp?jspcode=<%=Azdg.encrypt(jspcode,SysConst.FORMACTION) %>" method="post" >
<input type="hidden" name="jspcode" value="<%=Azdg.encrypt(jspcode,SysConst.FORMACTION) %>"/>
<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" class="Record">
                <tr class="Controls">
                    <th colspan="4">
                   excel表上传
</tr>
            
                <tr class="Controls">
                  <td align="right" class="tdLeft">excel文件：</td>
                  <td colspan="3"><label>
       <input class="upfile" type="button" id="reportfile_bt" style="width: 70px"
			datetype="{'type':'file','maxsize':'100000',isnotnull:true,
			'fext':'xls,XLS,xlsx,XLSX','showtype':'document','showcontainer':'reportfile_s','savepath':'d:\\\\carimage','shownum':1}"
			value="选择文件" title="数据库文件" />
                  <span class="red">（限.xls）</span></label></td>
      </tr>
                    <tr class="Controls">
                    <td colspan="4" align="center"><input id="btpub" type="button"  value="上传" class="admin_button" style="margin-right:24px;">
                    <input name="btn" type="button" value="取消" onClick="refreshPage();" class="admin_button"></td>
      </tr>
                    </table>
  </form>                  
                    </div>
</body>
</body>

  
</html>
<script type="text/javascript">
var mytools;

function refreshPage(){
  window.close();
  
  window.opener.location.reload();
}

  </script>
    <script type="text/javascript">
      var mytools;
     window.addEvent('domready', function() {

             //var mytools = new FORM($("postForm"));

  mytools=   new FORM($("postForm"));
  $('btpub').addEvent('click',dopub);
});
     function dopub(){
      if (mytools.submit()) {
     $('waiting').setStyle('display','block');
			var offset = {};
            var evt=window.event;
			offset.top = evt.y-15;
			offset.left = evt.x-25;
                $('waiting').set( {
					'styles' : {
						'position' : 'absolute',
						'top' : offset.top,
						'left' : offset.left
					
					}
				});
		(function(){new Request(
				{
					'url' : '/do_upload.jsp?jspcode=<%=Azdg.encrypt(jspcode,SysConst.FORMACTION) %>&'+$('postForm').toQueryString(),
					'async' : true,
					'onSuccess' : function(js, txt) {
						//alert(js);
						$('waiting').setStyle('display','none');
						if (js.indexOf('成功') > 0) {
							alert('操作成功！');
							 window.close();
  
  window.opener.location.reload();
						} else {
							alert('操作失败！');
							 window.close();
  
  window.opener.location.reload();
						}
						},
                    'onException':function(){
						$('waiting').setStyle('display','none');	
                    },
                    'onFailure':function(){
						$('waiting').setStyle('display','none');	
                    }
					
				}).send();
	})();
}
      }
</script> 
