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
     int up=0,down=0;

}
String fid =Azdg.encrypt("fid=user.xml@domoduser",SysConst.FORMACTION);
String fid2 =Azdg.encrypt("fid=user.xml@domoduser2",SysConst.FORMACTION);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>员工管理</title>
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
		  if(tt==false)
			  {
			    $('handle').value='<%=fid%>';
			    
			  }else  if(tt==true)
				  {
				    	$('handle').value='<%=fid2%>';
				  }
	        	//alert( $('handle').value);
					 new Request.JSON( {'url' : '/mainservlet?'+$('postForm').toQueryString(),
						'async' : false,
						'onSuccess' : function(js, txt) {
						   if(txt.indexOf('失败')>0){
							   alert('操作失败！');
						   }else{
							 alert('操作成功！');
							 }
							 window.location.reload();
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
             <p><strong>用户管理——修改员工信息</strong></p>
            	  <form id="postForm" name="postForm" method="post" action="/mainservlet">
  <input type="hidden" name="handle" id="handle"/>

  <input type="hidden" name="userid" value="<%=ors[0].getValue("userid")%>"/>
  <table>
       <tr>
           <td align="right"  >姓名：</td>
           <td >
             <input class="form-inp" type="text" name="username" id="username" title="员工姓名" value="<%=ors[0].getValue("username")%>"　datetype="{'type':'char','maxlength':'50',isnotnull:true}" />
           </td>
             
        </tr>
        
        
           <tr>
            <td align="right" >性别：</td>
            <td >
            
       
            <input type="text" name="sex" id="sex" title="性别" value="<%=ors[0].getValue("sex")%>"　datetype="{'type':'char','maxlength':'5',isnotnull:true}" />
  
            </td>
             
            </tr>     
                   <tr>
            <td align="right" >年龄：</td>
            <td >
              <input class="form-inp" type="text" name="age" id="age" title="年龄" value="<%=ors[0].getValue("age")%>"　datetype="{'type':'number','maxlength':'5',isnotnull:true}" />
            </td>
             
            </tr> 
             <tr>
            <td align="right" >邮箱：</td>
            <td >
              <input class="form-inp" type="text" name="email" id="email" title="邮箱" value="<%=ors[0].getValue("email")%>"　datetype="{'type':'number','maxlength':'5',isnotnull:true}" />
            </td>
             
            </tr> 
             <tr>
            <td align="right" >电话：</td>
            <td >
              <input class="form-inp" type="text" name="telephone" id="telephone" title="电话" value="<%=ors[0].getValue("telephone")%>"　datetype="{'type':'number','maxlength':'5',isnotnull:true}" />
            </td>
             
            </tr> 
             <tr>
               <td align="right" ><a class="lin_cz" onclick="updatepass()" >重设密码:</a></td>
               <td  id="pass"></td>
             </tr>
             <tr>
            <td colspan="2" align="center" >
              <input type="button" class="button" name="button" id="button" value="提交" onclick="dosubmit()"/>
              </td>
            </tr>    
    </table>
    </form>


            </div>
            </div>
            </div>
            
            

</body>
</html>


