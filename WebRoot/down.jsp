
<%@ page import="java.io.OutputStream" %>

<%@ page import="java.io.FileInputStream" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.basebean.OracleRowSet"%>


<%
EventResponse eventResponse = (EventResponse) request
.getAttribute("result");
    //response.reset();
OracleRowSet[] ors = new OracleRowSet[1];
	ors[0] = new OracleRowSet(50);
	HashMap data = null, olddata = null;
	if (eventResponse != null) {
		data = (HashMap) eventResponse.getBody();
		ors = (OracleRowSet[]) data.get("operation1");
		olddata = (HashMap) ((HashMap) eventResponse.getOriginBody())
		.get("operation1");
} FormUtil futil=new FormUtil();
    //filePath为全路径：D:/upload/a.doc
String path=futil.getFilePath(ors[0].getValue("imgpath"))==""?"":futil.getFilePath(ors[0].getValue("imgpath"));
   // String path = request.getParameter("filePath");
	String name =
		"baojia.jpg";

    int k = path.lastIndexOf("/");

    name = path.substring(k + 1 , path.length());

    
    response.setContentType("application/x-download");  

    response.addHeader("Content-Disposition","filename=\"" + name + "\"");
    try{  
        out.clear();  
        out=pageContext.pushBody();  

    }catch(Throwable e){ 

         e.printStackTrace();  
  }  

    try {

        OutputStream os = response.getOutputStream();

        FileInputStream fis = new FileInputStream(path);

        byte[] b = new byte[1024];

        int i = 0;

        while((i = fis.read(b)) > 0) {

            os.write(b, 0 ,i);

        }

        fis.close();

        os.flush();

        os.close();

    } catch(Exception e) {

        e.printStackTrace();

    }

%>
