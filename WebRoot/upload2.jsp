<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %> 
<%@ page import="java.util.regex.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="com.arch.util.FormBean" %>
<%@ page import="org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException"%>
<%@ page import="com.arch.exception.*" %>
<%@page import="net.sf.json.*"%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="sun.misc.BASE64Decoder"%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>


<%


	String res="error";
	String oriFileName=request.getParameter("oriFileName");
	String imgDataStr=request.getParameter("value");
	JSONObject jsonObject = new JSONObject();
	
	if (imgDataStr == null){ //图像数据为空  
		jsonObject.put("sflag","error");
		jsonObject.put("msg","未找到文件数据!");
		out.print(jsonObject.toString());
	}else{
		BASE64Decoder decoder = new BASE64Decoder();
	    try   
	    {
	        //Base64解码  
	        byte[] b = decoder.decodeBuffer(imgDataStr);  
	        for(int i=0;i<b.length;++i)
	        {
	            if(b[i]<0)  
	            {//调整异常数据  
	                b[i]+=256;
	            }  
	        }  
	        //生成jpeg图片  
	        Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String time=sdf.format(date);
			Long nanoTime = System.nanoTime(); // 纳秒
			            
	        String newFileName = time + nanoTime.toString().substring(10)+oriFileName.substring(oriFileName.lastIndexOf("."));
	        String imgFilePath = SysConst.UPLOAD_PATH+"\\"+newFileName;//新生成的图片  
	        
	        OutputStream out1 = new FileOutputStream(imgFilePath);
	        out1.write(b);
	        out1.flush();
	        out1.close();
	        res = newFileName;
			
			String backFilePath = "/uploads/"+newFileName;

	        jsonObject.put("sflag","success");
			jsonObject.put("msg","成功!");
			jsonObject.put("oldFileName",oriFileName);
			jsonObject.put("newFileUrl",backFilePath);
			out.print(jsonObject.toString());
	    }   
	    catch (Exception e)   
	    {
	    	jsonObject.put("sflag","error");
			jsonObject.put("msg","发生异常!");
			e.printStackTrace();
			out.print(jsonObject.toString());
	    }
	}
    
	

%>