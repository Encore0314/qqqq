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
<%


String errmsg="";
String msg="";
String fname="";
String fpath="";
String iname="";
String maxsize="";
String fext="";
String dbname="";
String showtype="";
String showcontainer="";
String savepath="";  
String shownum="";
String btnid="";
String eid="tdcar";
String t_name="";
ArrayList files=new ArrayList();
try{
   final long M_s= 5;
   final long MAX_SIZE = M_s * 1024 * 1024;// 设置上传文件最大为 3M
   // 允许上传的文件格式的列表
   final String  allowedExt = "jpg,jpeg,gif,PNG,png,bmp,BMP,txt,doc,docx,mp3,wma,m4a,pdf,wmv,JPG,JPEG,GIF,TXT,DOC,DOCX,MP3,WMA,M4A,PDF,WMV,xls,xlsx,XLSX";
   
  // response.setContentType("text/html");
   // 设置字符编码为UTF-8, 这样支持汉字显示
  // response.setCharacterEncoding("UTF-8");

   // 实例化一个硬盘文件工厂,用来配置上传组件ServletFileUpload
   DiskFileItemFactory dfif = new DiskFileItemFactory();
   
   dfif.setSizeThreshold(4096);// 设置上传文件时用于临时存放文件的内存大小,这里是4K.多于的部分将临时存在硬盘
   //dfif.setRepository(new File(request.getRealPath("/")
   //  + "ImagesUploadTemp"));// 设置存放临时文件的目录,web根目录下的ImagesUploadTemp目录
   dfif.setRepository(new File(SysConst.UPLOAD_PATH_TEMP));
   // 用以上工厂实例化上传组件
   ServletFileUpload sfu = new ServletFileUpload(dfif);
   sfu.setHeaderEncoding(SysConst.CHARSET);
   // 设置最大上传尺寸
   sfu.setSizeMax(MAX_SIZE);
   // 从request得到 所有 上传域的列表
   List fileList = null;
   try {
    fileList = sfu.parseRequest(request);
   } catch (FileUploadException e) {// 处理文件尺寸过大异常
    if (e instanceof SizeLimitExceededException) {
      throw new Exception("文件尺寸过大!限"+M_s+"M");
    }
    e.printStackTrace();
   }
   // 没有文件上传
   if (fileList == null || fileList.size() == 0) {
		throw new Exception("请选择文件！");

   }
   Iterator fileItr = fileList.iterator();
   FileItem fileItem = null;
   String path = null;

   HashMap formItem = new HashMap();
   // 得到所有上传的文件
      while (fileItr.hasNext()) {
    // 得到当前文件
    fileItem = (FileItem) fileItr.next();
    // 忽略简单form字段而不是上传域的文件域(<input type="text" />等)
    if ( fileItem.isFormField()) {
    	formItem.put(fileItem.getFieldName(),fileItem.getString());
        continue;
    }
      }
   
      showcontainer="";
      showtype=""; 
      dbname="";
      savepath="";
      shownum="";
      btnid="";
    fileItr = fileList.iterator();
   // 循环处理所有文件
   while (fileItr.hasNext()) {
    long size = 0;
    // 得到当前文件
    fileItem = (FileItem) fileItr.next();
    // 忽略简单form字段而不是上传域的文件域(<input type="text" />等)
    if ( fileItem.isFormField()) {
        continue;
    }
    // 得到文件的完整路径
    path = fileItem.getName();   
    // 得到文件的大小
    size = fileItem.getSize();
    if ("".equals(path) || size == 0) {
     throw new Exception("请选择文件！");
    }
    // 得到去除路径的文件名
    t_name = path.substring(path.lastIndexOf("\\") + 1);
   // 得到文件的扩展名(无扩展名时将得到全名)
   String t_ext = t_name.substring(t_name.lastIndexOf(".") + 1);
   
    if (allowedExt.indexOf(t_ext)<0) {
     throw new Exception("请上传指定类型的文件");
    }    


    // 拒绝接受规定文件格式之外的文件类型

                 // fpath=formItem.get("savepath").toString();
              // fpath=request.getSession().getServletContext().getRealPath("/img");
                iname=FormBean.getRandom(18)+"."+t_ext;
                
   // String rpath=fpath+"\\"+eid+iname;  
    try {
     // 保存文件
     
      java.util.Date date = new java.util.Date(); 


      java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyyMM"); 

      File dd=new File(SysConst.UPLOAD_PATH+"\\"+df2.format(date));
      if(dd.exists()){

     File tt =new File(SysConst.UPLOAD_PATH+"\\"+df2.format(date)+"\\"+iname); 
      
     fileItem.write(tt);
      }else{
    	  dd.mkdir();
    	  File tt =new File(SysConst.UPLOAD_PATH+"\\"+df2.format(date)+"\\"+iname); 
          
    	     fileItem.write(tt);  
      }
      iname=df2.format(date)+"//"+iname;
    // FormBean.CopyFile(tt,new File(rpath));
    } catch (Exception e) {
       throw new Exception(e.getMessage());
    }
   files.add(iname);
   }


}catch(Exception e){
  errmsg=e.getMessage();
}
if(!errmsg.equals("")){
   out.print(errmsg);
}else{
	String outStr="";
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	   for(int i=0;i<files.size();i++){
		   JSONObject jsonObject1 = new JSONObject();
		   		   
		   jsonObject1.put("fname",files.get(i));
		   
		   jsonArray.add(jsonObject1);
		   }
	
	jsonObject.put("fileinfo",jsonArray);
	outStr=jsonObject.toString();
out.print(outStr);
 
}
%>