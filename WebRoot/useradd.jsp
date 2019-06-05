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
     int up=0,down=0;

}
String fid=Azdg.encrypt("fid=user.xml@insuser",SysConst.FORMACTION);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加员工</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="title" content=""/>
<meta name="description" content=""/>
<link type="text/css" rel="stylesheet" href="/avalon/style/avalon.doc.css"/>
<link rel="stylesheet" type="text/css" href="css/mycss.css">
<script type="text/javascript"
			src="/js/mootools-1.2.4-core-nc-vsdoc.js"></script>
		<script type="text/javascript"
			src="/js/mootools-1.2.4.4-more-vsdoc.js"></script>
     <script type="text/javascript" src="/js/myjslib-vsdoc.js"></script>
      <script type="text/javascript">
      var mytools;
         window.addEvent('domready', function() {

             mytools = new FORM($("postForm"));
              
 
         });
        var t=true;var tt=false;
          function updatepass()
          {
        	    if(t==true){
        	    		t=false;
        	    		tt=true;
        	  	(new Element('input',{'id':'passwords','name':'passwords','title':'密码','datetype':'{\'type\':\'number\',\'maxlength\':\'10\',\'precious\':\'0\',isnotnull:true}'}))
		        .inject($('pass'));
        	  
        	 
        	  
        	  	} else if(t==false)
        	  		{
        	  		 t=true;
        	  		 tt=false;
        	  		  $('pass').empty();
        	  		
        	  		
        	  		  
        	  		}
        	   // alert("修改成功");
        	    //window.location.reload();
          }
function dosubmit()
{
	  // if(mytools.submit()){
		
	        	//alert( $('handle').value);
					 new Request.JSON( {'url' : '/mainservlet?'+$('postForm').toQueryString(),
						'async' : false,
						'onSuccess' : function(js, txt) {
						   if(txt.indexOf('失败')>0){
							   alert('操作失败！');
						   }else{
							 alert('操作成功！');
							 }
							var  url='/mainservlet?handle=<%= Azdg.encryptsubmit("fid=user.xml@userlist",SysConst.FORMACTION)%>';
							window.location = url;

						}
					}).send({});
				//	}
}
</script>
</head>
<body>
    <div class="page">
    	<div class=" basic-grey">
        	<div class="div-table">
            <p><strong>用户管理——添加新员工</strong></p>
            	       <form id="postForm" name="postForm" method="post" action="/mainservlet">
  <input type="hidden" name="handle" id="handle" value="<%=fid %>"/>
  
  <table width="100%">
          <tr>
            <td width="80" align="right" nowrap="nowrap"  >工号：</td>
            <td bgcolor="#FFFFFF">
              <input class="form-inp" type="text" name="userid" id="userid" title="登陆id" value=""　datetype="{'type':'char','maxlength':'50',isnotnull:true}" />
            </td>
            <td width="80" align="right" nowrap="nowrap"  >员工姓名：</td>
            <td bgcolor="#FFFFFF">
              <input class="form-inp" type="text" name="username" id="username" title="员工姓名" value=""　datetype="{'type':'char','maxlength':'50',isnotnull:true}" />
            </td>
          </tr>
         <tr>
           <td width="80" align="right" nowrap="nowrap"  >性别：</td>
            <td bgcolor="#FFFFFF">
            	<input name="sex" id="sex" type="radio" value="" checked datetype="{'type':'char','maxlength':'50',isnotnull:false}" />&nbsp;男&nbsp;&nbsp;&nbsp;
                <input name="sex" id="sex" type="radio" value="" datetype="{'type':'char','maxlength':'50',isnotnull:false}" />&nbsp;女
              <!--<input type="text" name="sex" id="sex" title="性别"　value="" datetype="{'type':'char','maxlength':'50',isnotnull:false}" />-->
            </td>
            <td width="80" align="right" nowrap="nowrap"  >年龄：</td>
            <td bgcolor="#FFFFFF">
              <input class="form-inp" type="text" name="age" id="age" title="年龄" value=""　datetype="{'type':'number','maxlength':'5',isnotnull:false}" />
            </td>
      </tr>

          <tr>         
            <td width="80" align="right" nowrap="nowrap"  >所在机构：</td>
            <td bgcolor="#FFFFFF">
              <select class="form-selet" style="width:220px" id="orgid" name="orgid"datetype="{'type':'char','maxlength':'50',isnotnull:true}"  msg="请选择所属机构！" onkeydown="if(event.keyCode==13)event.keyCode=9" >
               <option value="">请选择</option>
                    <%
			for(int i=0;i<ors1.length;i++){
		
			%>
                    <option value="<%=ors1[i].getValue("orgid") %>" ><%=ors1[i].getValue("orgname") %></option>
                    <%
			
			}
			%>
      </select>
            </td>
            <td width="80" align="right" nowrap="nowrap"  >职务：</td>
            <td bgcolor="#FFFFFF">
              <select class="form-selet" style="width:220px" id="position" name="position"datetype="{'type':'char','maxlength':'50',isnotnull:true}"  msg="请选择职务！" onkeydown="if(event.keyCode==13)event.keyCode=9" >
                    <option value="0" >普通员工</option>
                    <option value="1" >部门负责</option>
		      </select>
            </td>
          </tr>
          
          <tr >   
            <td align="right" nowrap="nowrap"  >邮箱：</td>
            <td bgcolor="#FFFFFF">
              <input class="form-inp" type="text" name="email" id="email" title="邮箱" value=""　datetype="{'type':'number','maxlength':'5',isnotnull:false}" />
            </td>
            <td align="right" nowrap="nowrap" >电话：</td>
            <td bgcolor="#FFFFFF">
              <input class="form-inp" type="text" name="telephone" id="telephone" title="电话" value=""　datetype="{'type':'number','maxlength':'5',isnotnull:false}" />
            </td>
          </tr>
          
          <tr>
            <td align="right" nowrap="nowrap"  >设置密码：</td>
            <td colspan="3" bgcolor="#FFFFFF">
              <input class="form-inp" type="text" name="passwords" id="passwords" title="密码"　value="" datetype="{'type':'char','maxlength':'50',isnotnull:true}" />
              
            </td>
          </tr>
          <tr>
          	<td style="border:none" colspan="4" align="center" class="font3"></td>
     	</tr>
          
          <tr>
          	<td  colspan="4" align="center" >
            	<a class="button" name="button" id="button" onclick="dosubmit()">提&nbsp;交</a></td>
     	</tr>
           </table>
           </form>
            </div>
        </div>
    </div>
        
        
      
</body>
</html>


