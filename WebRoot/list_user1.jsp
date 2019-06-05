<%@ page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%
	EventResponse eventResponse = (EventResponse) request
			.getAttribute("result");
	FormUtil form = new FormUtil();
	OracleRowSet[] ors = new OracleRowSet[1];
	ors[0] = new OracleRowSet(50);
	OracleRowSet[] ors1 = new OracleRowSet[1];
	ors1[0] = new OracleRowSet(50);
	HashMap data = null, olddata = null;
	String fid=Azdg.encryptsubmit("fid=user.xml@userlist2",SysConst.FORMACTION);
	if (eventResponse != null) {
		data = (HashMap) eventResponse.getBody();
		ors = (OracleRowSet[]) data.get("operation1");
		ors1 = (OracleRowSet[]) data.get("operation2");
		olddata = (HashMap) ((HashMap) eventResponse.getOriginBody())
				.get("operation1");
	}

	int up=0,down=0;
  String condition="";
  if(ors1!=null){
	  if(!ors1[0].getValue("beg").equals("")&&!ors1[0].getValue("ys").equals(""))
	  {
	    if(ors1[0].getValue("ys").equals("0")){
	     down=1;
	    }else{
	    down=Integer.parseInt(ors1[0].getValue("beg"))+1;}
	    if(Integer.parseInt(ors1[0].getValue("beg"))>1){
	      up=Integer.parseInt(ors1[0].getValue("beg"))-1;
	    }
	    if(Integer.parseInt(ors1[0].getValue("beg"))==1){
		      up=1;
		    }	    
	    if(Integer.parseInt(ors1[0].getValue("beg"))==Integer.parseInt(ors1[0].getValue("ys"))){
	      down=Integer.parseInt(ors1[0].getValue("ys"));
	    }
	  }
    
     // if(!Tools.nvl(((String[])olddata.get("status"))[0],"").equals("")){
   	  // condition+="&status="+Tools.nvl(((String[])olddata.get("status"))[0],"");
      //}
	}
	
	String jspcode = FormBean.getRandom(8);
  	session.setAttribute("jspcode",jspcode);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>文化青浦云</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="title" content="" />
		<meta name="description" content="" />
        <link type="text/css" rel="stylesheet" href="/avalon/style/avalon.doc.css"/>
        <link rel="stylesheet" type="text/css" href="css/mycss.css">
<script type="text/javascript" src="/js/mootools-1.2.4-core-nc-vsdoc.js"></script>
<script type="text/javascript" src="/js/mootools-1.2.4.4-more-vsdoc.js"></script>
<script type="text/javascript" src="js/myjslib-vsdoc.js"></script>
<script type="text/javascript" src="/js/newcalendar.js"></script>
<script type="text/javascript" src="/js/dialog.js"></script>
<script type="text/javascript" src="/js/tool.js"></script>
<script type="text/javascript">
var condition='<%=condition%>';
var rurl;
function Show(page){
 
      getlist2(page);
    }
</script>
<script type="text/javascript">
var mytoolslist;
var carid = "";
var pag=1;
window.addEvent('domready',function() {
	
				       mytools  = new FORM($("postform"));
				
					
				
					     getlist();
					
					
});

function exportUser(){
				window.open('/mainservlet?fid=user.xml@exportuser','_blank','height=800, width=1100, top=100, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
			}
function Show(page){
    
  
   getlist2(page);
    }



function getlist()
{
	  if(mytools.submit()){
		
	 new Request.JSON( {'url' :  '/mainservlet?'+$('postform').toQueryString(),
						'async' : false,
						'onSuccess' : function(js, txt) {
						   $('showagent').set("html",txt);
							
						}
					}).send({});}
}
function getlist2(t)
{
	
		
	 new Request.JSON( {'url' : '/mainservlet?handle=<%=fid%>&start='+t+'&'+$('postform').toQueryString(),
						'async' : false,
						'onSuccess' : function(js, txt) {
						   $('showagent').set("html",txt);
							
						}
					}).send({});
}
</script>
	</head>
	<body>
    <div class="page">
    	<div class=" basic-grey">
        <div class="div-table2">
          <form name="postform" action="/mainservlet" id="postform" method="post">
            <input id="handle" type="hidden" name="handle" value="<%=fid%>" />
			<table width="820" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="10%" align="right">姓名：</td>
    <td width="20%"> <input class="form-inp" type="text" name="username" /></td>
    <td width="10%" align="right">机构：</td>
    <td width="20%"><select class="form-selet" id="dept" name="dept" onkeydown="if(event.keyCode==13)event.keyCode=9">
                                            <option value="">
                                                请选择
                                            </option>
                                            <%
                                                for (int i = 0; i < ors.length; i++) {
                                            %>
                                            <option value="<%=ors[i].getValue("orgid")%>"><%=ors[i].getValue("orgname")%></option>
                                            <%
                                                }
                                            %>
                                        </select>
            </td>
    <td width="10%" align="right">电话：</td>
    <td width="20%"><input class="form-inp" type="text" name="telephone" /></td>
    <td align="right" nowrap="nowrap"><input class="button" type="button" value="查询" onclick="getlist();" /></td>
  </tr>
</table>
</form>

        </div>
        	<div class="btntabr_div">
	            	<p align="right">
	                	<a class="button3" href="/mainservlet?handle=<%=Azdg.encrypt("fid=user.xml@gotoinsuser",SysConst.FORMACTION)%>">
	                            <span class="butt_mar">添加新用户</span>
	                        </a>&nbsp;&nbsp;&nbsp;
	                </p>
                </div>
        	<div class="div-table">
        	
                         <div id="showagent"></div>	
            </div>
        </div>
    </div>
		
</body>
</html>


