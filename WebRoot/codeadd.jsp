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
    if(olddata.get("sup_code_id")!=null&&!Tools.nvl(((String[])olddata.get("sup_code_id"))[0],"").equals("")){
    	sup_code_id=Tools.nvl(((String[])olddata.get("sup_code_id"))[0],"");
    }

if(olddata.get("codetype")!=null&&!Tools.nvl(((String[])olddata.get("codetype"))[0],"").equals("")){
	codetype=Tools.nvl(((String[])olddata.get("codetype"))[0],"");
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新增代码</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="title" content=""/>
<meta name="description" content=""/>
<link href="/css/mycss.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript"
			src="/js/mootools-1.2.4-core-nc-vsdoc.js"></script>
		<script type="text/javascript"
			src="/js/mootools-1.2.4.4-more-vsdoc.js"></script>
     <script type="text/javascript" src="/js/myjslib-vsdoc.js"></script>
      <script type="text/javascript">
         window.addEvent('domready', function() {
             var mytools = new FORM($("postForm"));
         });

</script>
</head>
<body>
<div class="page2">

	 <div  class=" basic-grey">
             <div class="tit">
                    <p ><strong>代码管理———新增代码</strong></p>
            </div>
             <div class="div-table">
             	  <form id="postForm" name="postForm" method="post" action="/mainservlet">
  <input type="hidden" name="handle" value="<%=Azdg.encrypt("fid=code.xml@inscode",SysConst.FORMACTION)%>"/>
  <input type="hidden" name="sup_code_id" value="<%=ors[0].getValue("code_id")%>"/>
  <input type="hidden" name="codetype" id="codetype"  value="<%=ors1[0].getValue("typeid")%>" />
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
           <tr>
            <td  >代码类别：</td>
            <td>
              <%=ors1[0].getValue("typename")%>
            </td>
           
          </tr>      
         <tr>
            <td  >上级代码：</td>
            <td>
              <%=ors[0].getValue("code_id")%><%=ors[0].getValue("code_name")%>
            </td>
           
          </tr>
  <tr>
            <td >序号：</td>
            <td>
              <input class="form-inp" type="text" name="ordernumber" id="ordernumber" title="序号"　datetype="{'type':'number','maxlength':'5',isnotnull:false}" />
            </td>
            
        </tr> 
         <tr>
           <td >新增代码：</td>
            <td>
              <input class="form-inp" type="text" id="code_id" name="code_id"  title="新增代码"  datetype="{'type':'char','maxlength':'100',isnotnull:true}" />
            </td>
            
            </tr>           
        <tr>
           <td >新增代码名称：</td>
            <td>
              <input class="form-inp" type="text" id="code_name" name="code_name"  title="新增代码名称"  datetype="{'type':'char','maxlength':'100',isnotnull:true}" />
            </td>
            
            </tr>
            
            
        <tr>
            <td >备注：</td>
            <td>
              <input class="form-inp" type="text" name="prop_a" id="prop_a" title="备注"　datetype="{'type':'char','maxlength':'50',isnotnull:false}" />
            </td>
            
        </tr>  
                  
      
        <tr>
          <td colspan="2" align="center" class="font3"><input type="submit" name="button" id="button" value="提交" /></td>
        
        </tr>
           </table>
           </form>

             </div>
             </div>
             </div>



<div class="body_bac">

  <!--nav-->  
  <div class="content2">
<div class="con3"> 
  <h2>新增代码</h2>
  <div class="con4">
  <div class="con5">
  <div class="table_box2">
  </div> <!--table_box2-->
    
  </div> <!--con5-->
  </div> <!--con4-->
  </div> <!--con3-->

</body>
</html>


