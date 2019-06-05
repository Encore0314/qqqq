<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>

<%@page import="com.arch.util.*"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="sun.misc.BASE64Decoder" %>

<%
   String name=request.getParameter("imgpath");
  //out.println(name);
  String path;
  int ind=name.lastIndexOf("\\");
  path=name.substring(ind+1);	

	String savepath="d:\\carimage";
     String lpath=savepath+"\\l_"+path;
    //String spath=savepath+"\\"+path;
    String wlpath=savepath+"\\wl_"+path;
    String wwpath=savepath+"\\w_"+path;
      File of=new File(lpath);
      if(of.exists()){
    	of.delete();
      }
      of=new File(wlpath);
      if(of.exists()){
    	  of.delete();
      }
      of=new File(wwpath);
      if(of.exists()){
    	 boolean b= of.delete();
    	System.out.print(b);
      }

		   try
		   {
		FileOutputStream fs =new FileOutputStream( new File(name));
	  //FileOutputStream fs =new FileOutputStream( new File("D://11.jpg"));
		   BASE64Decoder decoder = new BASE64Decoder();
		     String data=request.getParameter("data1");
		    byte[] bytes = decoder.decodeBuffer(data); 
		       
		    fs.write(bytes, 0, bytes.length);
		    fs.flush();
		    fs.close();
		     out.print("³É¹¦");
		   }
		   catch (Exception ex)
		   {out.println(ex.getMessage());
		   }


 %>

