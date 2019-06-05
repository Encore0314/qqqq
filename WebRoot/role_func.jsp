<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
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

	EventResponse eventResponse = (EventResponse) request
			.getAttribute("result");
	HashMap data = null;

	OracleRowSet[] ors = new OracleRowSet[1];
	ors[0] = new OracleRowSet(50);


	if (eventResponse != null) {
		data = (HashMap) eventResponse.getBody();
		ors = (OracleRowSet[]) data.get("operation1");
	
	}
	String fid="";
if (ors[0].getValue("rid").equals("")){
	fid = Azdg.encryptsubmit("fid=role.xml@savepriv",
			SysConst.FORMACTION);
}
else
	{
	fid = Azdg.encryptsubmit("fid=role.xml@updatepriv",
			SysConst.FORMACTION);
	}
%>
<%!public String getnode(String supid,String pid,String rid) throws Exception{
  String result="";
	try{
		DBTransUtil dbutil = new DBTransUtil();
		String sql2="SELECt ifnull(a.load_page,'0') load_page,a.funcid,a.funcname,  CASE WHEN LENGTH(c.funcid)>0 THEN   'checked'   ELSE   'unchecked'  END ischeck "+ 
			" FROM  functionlist a  LEFT JOIN tb_rolefuns c ON a.funcid = c.funcid AND c.rid  = '"+rid+"' "+
			"			  WHERE a.sup_func = '"+supid+"'			ORDER BY a.funcid ";
		CachedRowSet crs2= dbutil.getResultBySelect(sql2);
		crs2.first(); 
		  
		  for(int n=0;n<crs2.size();n++){
			   if(crs2.getString("load_page").equals("0")){
				 result+="<li><a href=\"#\" ref=\"kcgl\">"+crs2.getString("funcname")+"</a></li>";
			   }else{
				   
			   result+="<li><input name='funcsubid' type='checkbox' value=\""+crs2.getString("funcid")+"\""+crs2.getString("ischeck")+" /><a href=\"#\" ref=\"kcgl\">"+crs2.getString("funcname")+"</a></li>";
			   }
			   result+= getnode(crs2.getString("funcid"),pid,rid);
			  crs2.next();
		  }
       
} catch (Exception e) {
e.printStackTrace();
} finally{

}
 if(result.length()>1){
	 result="<ul show=\"true\">"+result+"</ul>";
 }

return result;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>添加角色</title>
<link rel="stylesheet" type="text/css" href="js/tree_themes/SimpleTree.css"/>
<link rel="stylesheet" type="text/css" href="css/mycss.css">
<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
<script type="text/javascript" src="js/SimpleTree.js"></script>
<script type="text/javascript">
$(function(){
	$(".st_tree").SimpleTree({
		click:function(a){
			if(!$(a).attr("hasChild"));
				//alert($(a).attr("ref"));
		}
	});
});
</script>
	</head>
	<body>
     <div class="page">
    	<div class=" basic-grey">
        	<div class="div-table">
        	
                                         <p><strong>角色管理</strong></p>

            	<form id="func_form" name="func_form" action="/mainservlet"
								method="post">
							<input id="handle" type="hidden" name="handle" value="<%=fid%>" />
							<input type="hidden" id="rid" name="rid" value="<%=ors[0].getValue("rid")%>" />
							    <table width="100%">
<tr>
<td nowrap="nowrap">角色名称：<input class="form-inp" type="text" name="rname" id="rname" title="角色名称"  datetype="{'type':'char','maxlength':'200',isnotnull:true}" value="<%=ors[0].getValue("rname") %>"/></td>
</tr>
	<tr>
	<td>				
	
<div class="st_tree">


<%=getnode("200000",pid,ors[0].getValue("rid"))%>

</div>	
								</td>
								</tr>
								<tr>
					  			<td  align="center" >
										<input class="button" type="submit" value="提交" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								  <input class="button3" type="button" value="返回" onclick="window.history.go(-1);" />
								  </td>
								</tr>

							
	  						</table>
			  </form>
			  
            </div>
         </div>
     </div>
    
    
</body>
</html>

