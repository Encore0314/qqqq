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
<title>业务管理</title>
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
                    <p ><strong>机构管理———新增机构</strong></p>
            </div>
             <div class="div-table">
             	  <form id="postForm" name="postForm" method="post" action="/mainservlet">
  <input type="hidden" name="handle" value="<%=Azdg.encrypt("fid=org.xml@insorg",SysConst.FORMACTION)%>"/>
  <input type="hidden" name="suporgid" value="<%=ors[0].getValue("orgid")%>"/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
       
         <tr>
            <td align="right"  >上级机构：</td>
            <td bgcolor="#FFFFFF">
              <input  class="form-inp"  type="text" name="username" id="username"  title="上级机构" value="<%=ors[0].getValue("orgname")%>"　datetype="{'type':'char','maxlength':'50',isnotnull:true}" />
            </td>
           
          </tr>
          
            
            <td align="right"  >新增机构名称：</td>
            <td bgcolor="#FFFFFF">
              <input  class="form-inp"  type="text" id="orgname" name="orgname"  title="新增机构名称"  datetype="{'type':'char','maxlength':'100',isnotnull:true}" />
            </td>
            
           </tr>
         <tr>
            
            <td align="right"  >序号：</td>
            <td bgcolor="#FFFFFF">
              <input  class="form-inp"  type="text" name="dept_sort" id="dept_sort" title="序号"　datetype="{'type':'char','maxlength':'50',isnotnull:true}" />
            </td>
            
        </tr>             
        <tr>
            
            <td align="right"  >备注：</td>
            <td bgcolor="#FFFFFF">
              <input  class="form-inp"  type="text" name="remark" id="remark" title="备注"　datetype="{'type':'char','maxlength':'50',isnotnull:false}" />
            </td>
            
        </tr>            
        <tr>
          <td colspan="2" align="center" class="font3"><input class="button" type="submit" name="button" id="button" value="提交" /></td>
        </tr>
           </table>
           </form>

             </div>
             
             
             
             </div>
             </div>



	<div class=" contet_form">
    	
              <div class="table_box2">
  </div> <!--table_box2-->
    </div>
</body>
</html>


