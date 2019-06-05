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
	String fid=Azdg.encryptsubmit("fid=common.xml@eqklist2",SysConst.FORMACTION);
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
		
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="title" content="" />
		<meta name="description" content="" />
        <link rel="stylesheet" type="text/css" href="css/mycss.css">
<script type="text/javascript" src="/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/js/dialog.js"></script>
<script type="text/javascript" src="/js/tool.js"></script>
<script type="text/javascript" src="/js/DatePicker/WdatePicker.js"></script>
<link href="/js/DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
var condition='<%=condition%>';
var rurl;
</script>
<script type="text/javascript">
var carid = "";
var pag=1;
$(function(){
	
	getlist(1);
	
})


function exportUser(){
				window.open('/mainservlet?fid=user.xml@exportuser','_blank','height=800, width=1100, top=100, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
			}
function Show(page){
    
  
   getlist(page);
    }




function getlist(t)
{
	
		$.ajax({
            url:  '/mainservlet?handle=<%=fid%>&start='+(t-1)*10+'&'+$('#postform').serialize(),
            type:'get',
            //data:$('#postform').serialize(),
            success:function(data){
               
             $('#showagent').html(data);

            }
             });
	
}
</script>
<script type="text/javascript">

            
      </script>
	</head>
	<body>
    <div class="page">
    	<div class=" basic-grey">
        <div class="div-table2">
          <form name="postform" action="/mainservlet" id="postform" method="post">
            <input id="handle" type="hidden" name="handle" value="<%=fid%>" />
			<table width="800"  border="0" cellspacing="0" cellpadding="0">
  <tr>
 
    <td width="220"> <input class="form-inp inpbacnor searchinp" 
      type="text" name="common_name" placeholder="请输入标题" /></td>
 
    
    <td width="90"><select class="form-selet"  name="common_status" onkeydown="if(event.keyCode==13)event.keyCode=9">
                                            <option value="">全部状态 </option>
                                            <option value="0">待发布 </option>
                                            <option value="1">已上架 </option>
                                            <option value="2">已下架 </option>
                                        </select>
            </td>
    <td width="190" align="right" nowrap="nowrap">
    <input class="button" type="button" value="查询" onclick="getlist(1);" />
    <a class=" button-blue" href="/mainservlet?handle=<%=Azdg.encrypt("fid=common.xml@goaddeqk",SysConst.FORMACTION) %>">添加</a>
    </td>
  </tr>
</table>
</form>

        </div>

        	<div class="div-table">
        		
                         <div id="showagent">
                          
                         
                         
                         </div>	
            </div>
        </div>
    </div>
		
</body>
</html>


