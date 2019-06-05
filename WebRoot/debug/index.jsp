<%@ page contentType="text/html; charset=utf-8"  buffer="none" %>
<%@page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%@ page import="sun.jdbc.rowset.*"%>
<%@page import="java.sql.*" %>
<%
  String projectpath = request.getContextPath();
  
  String ins = request.getParameter("ins");
  String funcid = request.getParameter("funcid");
   String disc = request.getParameter("disc");
    	DBTransUtil dbu=new DBTransUtil();
    	String sql="update functionlist set remark=?,description=? where funcid=? and 1=1";
    	if(funcid!=null){
    	Connection con=null;
CallableStatement cstmt=null; 
PreparedStatement preparedStatement = null;
ResultSet rs =null;
CachedRowSet crs =null;
        try{
 dbu= new DBTransUtil();
 con = dbu.getConnection();
  con.setAutoCommit(false);
 preparedStatement = con.prepareStatement(sql);           
 preparedStatement.setString(1,ins);    
  preparedStatement.setString(2,disc);    
    preparedStatement.setString(3,funcid);       
      preparedStatement.executeUpdate();
      con.commit();
        }catch(Exception e){
        System.out.print("getauctionstatus.jsp"+e.getMessage());           
        }
        finally{
         
         con.close();
         preparedStatement.close();
         preparedStatement=null;
         cstmt=null;
         con=null;
        }
    	}
    	
	CachedRowSet crs2= dbu.getResultBySelect("select funcid,funcname,load_page,remark,description from functionlist where ftype in ('1','2') and ismenu='0' order by funcid");
	crs2.first(); 
	
	


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="expires" content="0">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="<%=projectpath%>/css/mycss.css" type="text/css" rel="stylesheet"/>
<script src="<%=projectpath%>/js/jquery-1.8.2.min.js"></script>
<title>APP接口调试工具</title>
<style>
H2 {
	font-family: "微软雅黑", "宋体", Arial, Verdana, sans-serif;
	font-size: 24px;
	font-weight: normal;
	line-height: 30px;
}
.title {
	margin-bottom: 50px;
}
.eat_list {
}
.workarea td {
}
.op_div {
	margin-bottom: 100px;
}
.op_div_top {
	margin-bottom: 20px;
}
.op_div_top div {
	margin-bottom: 20px;
}
.input_key {
	height: 25px;
	width: 50px;
	font-size: 16px;
	line-height: 24px;
}
.highlight {
	background-color: #B0FFB0;
	border: none;
}
</style>

<body>
<div class="container"> 
  <!--内容部分-->
  <div class="index_n" style="min-height:300px">
    <div class="workarea">
      <div class="title">
        <h2>APP接口调试工具</h2>
      </div>
      <div class="op_div_top">
        
        <div>接口类型：

          &nbsp;&nbsp;<a href="adadoc.html" target="_blank">查看说明文档</a> </div>
        <div>接口列表：
         
            <%for(int i=0;i<crs2.size();i++){ %>
              <input type="radio" name="sel_tn" onclick="queryDetail(this)" value="<%=Azdg.encryptsubmit("fid="+crs2.getString("load_page"),SysConst.FORMACTION)%>#<%=crs2.getString("remark")%>#<%=crs2.getString("funcid")%>#<%=crs2.getString("description")%>" /><%=crs2.getString("funcname") %>
            <%
            crs2.next();
            } %>
 
         <!--&nbsp;&nbsp;<a href="upload_test.jsp">附件上传接口</a>--></div>
      </div>
      <div class="op_div_top">
      <input id="test"  />
        <table width="100%">
          <tbody id="eat_body">
            <tr>
              <td align="center"><textarea id="injson" name="injson" style="width:400px; height:300px"></textarea></td>
              <td align="center"><a class="zbt bt-green" id="save_btn" name="save_btn"  href="javascript:void(0)" onclick="javascript:doSave();">保存参数</a></td>
              <td align="center"><a class="zbt bt-green" id="save_btn" name="save_btn"  href="javascript:void(0)" onclick="javascript:doProcess();">执行</a></td>
              <td align="center"><textarea id="outjson" name="outjson" style="width:400px; height:300px"></textarea></td>
            </tr>
            <tr>
            <td>说明</td><td><textarea id="disc"  style="width:400px; height:100px"></textarea></td>
            </tr>
          </tbody>
        </table>
      </div>

    </div>
  </div>
  <div class="c"></div>
</div>
</body>
</html>
<script language="javascript">
var v_data={};
var funcid="";

v_data.token=localStorage.getItem('token');
function queryDetail(obj){
	v_data={};
	
    v_data.handle=$(obj).val().split("#")[0];
    $("#test").val(v_data.handle);
    $('#injson').val($(obj).val().split("#")[1]);
    funcid=$(obj).val().split("#")[2];
    $('#disc').val($(obj).val().split("#")[3]);
}
 function doProcess(){
   var tt=$('#injson').val().replace(new RegExp("'","g"),"\"");
      // tt="{\"id\":\"admin\",\"passwords\":\"qwe123\"}";
   var aa=$.parseJSON(tt);
   v_data= $.extend(v_data, aa);
   
                     $.ajax({
		                 type: "post",
		                 url: "<%=projectpath%>/mainservlet",
		                 contentType: "application/x-www-form-urlencoded; charset=utf-8",
		                data: v_data,
		                traditional: true,
		                 //contentType: "application/json",
		                 success: function (e) {
		                   		$('#outjson').val(e);
		                   		var t_data=$.parseJSON(e);
		                   		v_data.token=	t_data.token;	
		                   		localStorage.setItem('token', t_data.token);
		                	//fanhui();
                       }
		                    
		
		                 });
 }
  function doSave(){

                     $.ajax({
		                 type: "get",
		                 url: "<%=projectpath%>/debug/index.jsp",
		                data: {'ins':$('#injson').val(),'funcid':funcid,'disc':$('#disc').val()},
		                 //contentType: "application/json",
		                 success: function (e) {
		                   		alert("操作成功");
		                   		window.location.reload();	
		                	//fanhui();
                       }
		                    
		
		                 });
 }
</script>