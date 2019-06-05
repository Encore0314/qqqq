<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>
<%@ page import="sun.jdbc.rowset.*"%>
<%!public String getnode(String supid,String pid,String rid) throws Exception{
  String result="";
	try{
		DBTransUtil dbutil = new DBTransUtil();
		String sql2="";
	

				 sql2="SELECt distinct ifnull(a.load_page,'0') load_page,a.funcid,a.funcname  FROM  functionlist a  inner join ("+
   " select getsupfuncid(t.funcid,'"+supid+"') as funcid from tb_rolefuns t inner join functionlist b on t.funcid=b.funcid where t.rid in "+
    " (select rid from tb_emprole where pid='"+pid+"' )) b on a.funcid=b.funcid "+
 			" ORDER BY a.funcid";				
			
		CachedRowSet crs2= dbutil.getResultBySelect(sql2);
		crs2.first(); 
		  
		  for(int n=0;n<crs2.size();n++){
			   if(crs2.getString("load_page").equals("0")){
				 result+="<li><a href=\"#\" ref=\"kcgl\">"+crs2.getString("funcname")+"</a></li>";
			   }else{
				   
				   result+="<li ><a onclick=\"createNewTab('dhtmlgoodies_tabView1','"+crs2.getString("funcname")+"','','/mainservlet?handle="+Azdg.encrypt("fid="+crs2.getString("load_page"),SysConst.FORMACTION)+"',true);return false\" href=\"javascript:;\" ref=\"kcgl\">"+crs2.getString("funcname")+"</a></li>";
			   }
			   result+= getnode(crs2.getString("funcid"),pid,rid);
			  crs2.next();
		  }
       
} catch (Exception e) {
e.printStackTrace();
} finally{

}
 if(result.length()>1){
	 result="<ul >"+result+"</ul>";
 }

return result;
}
%>




<div id="accordion">
	<div class="left-top"><h3 class="font_white"><img src="img/logo-mini.png" width="100%"  alt="logo" /></h3>
	</div>
  <!--侧边栏菜单（可收缩）-->
		 <div class="left_nav">

<div class="st_tree">


<%=getnode("200000",pid,rid)%>

</div>

</div>

      	</div>
