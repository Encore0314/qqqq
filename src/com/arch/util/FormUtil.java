/*
 * 版权所有
 * 项目名称 管网资产管理
 * 包名称   com.water.util
 *
 * 文件名称 FormBean.java
 *
 */
package com.arch.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.arch.util.*;
import sun.jdbc.rowset.CachedRowSet;


/**
 * 功能描述  <br><br>
 * 创建日期 2004-2-25 21:49:43
 *
 * @author
 * @version
 *
 * 修改人:<br>
 * 日期:<br>
 * 修改功能:<br>
 */
public class FormUtil {
    public String showSuccessMsg() {
        return "<script>alert('操作成功！');</script>";
    }

    public String showSuccessMsg(String msg) {
        return "<script>alert('" + processStr(msg) + "');</script>";
    }

    public String showErrorMsg() {
        return "<script>alert('操作失败！');</script>";
    }

    public String showErrorMsg(String cause) {
        return "<script>alert('操作失败！" + processStr(cause) + "');</script>";
    }

    public String processStr(String str) {
        str = str.replaceAll("\n", "");
        str = str.replaceAll("\r", "");
        str = str.replaceAll("\t", "");
        str = str.replaceAll("\f", "");
        str = str.replaceAll("\b", "");
       str = str.replaceAll("\\\\", "/");
        return str;
    }

    /**
     * 通过SQL语句取得LIST项,
     * SQL语句查询的前两个字段为代码和代码名，
     * @param strSql SQL语句,例如：select 代码，显示项 from tablename
     * @param defaultval 默认值
     * @return String HTML代码
     */
    public String popListWithSelect(String strSql, String defaultval) {
        String value = "";
        String name = "";
        StringBuffer resultstr = new StringBuffer("");
        DBTransUtil transUtil = new DBTransUtil();
        CachedRowSet crs = null;
        try {
            crs = transUtil.getResultBySelect(strSql);
            while (crs.next()) {
                value = (String) crs.getString(1);
                name = (String) crs.getString(2);
                if (value.equals(defaultval)) {
                    resultstr.append("<option value='");
                    resultstr.append(value);
                    resultstr.append("' selected>");
                    resultstr.append(name);
                    resultstr.append("</option>");
                } else {
                    resultstr.append("<option value='");
                    resultstr.append(value);
                    resultstr.append("'>");
                    resultstr.append(name);
                    resultstr.append("</option>");
                }
            }
        } catch (Exception ex) {
            SysConst.trace("popListWithSelect执行SQL语句时出错：" + ex.getMessage());
        } finally {
            try{
                if (crs != null)
                    crs.close();
            }catch(Exception e){}
            return resultstr.toString();
        }
    }


    
    
    public String trimDate(String date, int len) {
        String result="";
        if(date!=null){
            if(date.length()>11)
            result=date.substring(0,len);
            else
                result=date;
        }

         return result;
    }

    public String filedown(String csfj){//文件下载

           if ( !csfj.equals("")  ){
                  String fjurl = "" ;
                  if ( csfj.indexOf("*") > 0 ){
                         String[] aryfj=new String[2];
                         aryfj=csfj.split("\\*");
                         fjurl = "<a href='"+aryfj[0]+"'>"+aryfj[1]+"</a>";

                       }else{
                            fjurl = "<a href='"+csfj+"'>下载</a>";
                          }
                              return fjurl;
                        }
        return "";
    }
    public String getFileName(String csfj){ //取得文件名

          if ( !csfj.equals("")  ){
                 String fjurl = "" ;
                 if ( csfj.indexOf("*") > 0 ){
                        String[] aryfj=new String[2];
                        aryfj=csfj.split("\\*");
                        fjurl = aryfj[1];

                      }else{
                           fjurl = csfj;
                         }
                             return fjurl;
                       }
       return "";
   }
   public String getFilePath(String csfj){ //取得文件路经

            if ( !csfj.equals("")  ){
                   String fjurl = "" ;
                   if ( csfj.indexOf("*") > 0 ){
                          String[] aryfj=new String[2];
                          aryfj=csfj.split("\\*");
                          fjurl = aryfj[0].replace("\\","\\\\");

                        }else{
                             fjurl = csfj.replace("\\","\\\\");
                           }
                               return fjurl;
                         }
         return "";
     }
     public String getUploadName(String csfj){ //取得文件路经

                if ( !csfj.equals("")  ){
                       String fjurl = "" ;
                        String fjurl1 = "" ;
                       if ( csfj.indexOf("*") > 0 ){
                              String[] aryfj=new String[2];
                              aryfj=csfj.split("\\*");
                              fjurl = aryfj[0];
                              String[] aryfj1 =new String[2];
                              aryfj1=fjurl.split("\\/upload\\/");
                              fjurl1=aryfj1[1];
                            }else{
                                 fjurl = csfj;
                               }
                                   return fjurl1;
                             }
             return "";
     }
     public String getPubTypeName(String type) { //获得pubinfo-type的中文名称
         StringBuffer strSql = new StringBuffer(
                 "select code_name from  code_info where code_type='5' and code_id='");
         strSql.append(type);
         strSql.append("'");
         String code_name = "";
         DBTransUtil transUtil = new DBTransUtil();
         try {
             code_name = transUtil.getColumnValue(strSql.toString());
         } catch (Exception fe) {
             SysConst.trace("error at getname : " + fe.getMessage());
             return null;
         }
         return code_name;

     }
     //拼复选框 author:w@L@ei
     public String checkBoxItemList(String code_type,String chkname,String defaultval, String view) {
         DBTransUtil transUtil = new DBTransUtil();
         StringBuffer strSql = new StringBuffer("select code_id,code_name from code_info t where code_type='");
         strSql.append(code_type);
         strSql.append("'");
         String resultstr = "";
         defaultval = (defaultval == null ) ? "" : defaultval;
        defaultval = (defaultval == "null" ) ? "" : defaultval;
         CachedRowSet crs = null;
         int len = 0;
         String code_id = "";
         String code_name = "";
         String temp[] =new String[1];
         if(defaultval.equals("")||defaultval==null){
             temp[0]="";
         }else{
         temp= defaultval.split(";");
         }

         try {
             crs = transUtil.getResultBySelect(strSql.toString());
             while (crs.next()) {
                 boolean flag=false;
                 code_id = FormBean.get(crs.getString("code_id"));
                 code_name = FormBean.get(crs.getString("code_name"));
                 if(view.equals("view")||view.equals("print")){
                      for (int i = 0; i < temp.length; i++) {
                          if (code_id.equals(temp[i])) {
                                  resultstr = resultstr + code_name + ",";
                          }
                      }
                          }else{
                 for (int i = 0; i < temp.length; i++) {
                         if (code_id.equals(temp[i])) {
                                resultstr = resultstr + "<li id='"+chkname+"'><input type='checkbox' name='t" +
                                 chkname + "' value='" + code_id +
                                 "' checked  onClick=\"addcheck('"+chkname+"')\">" +
                                 code_name + "</li>";
                                 flag=true;
                                 break;
                            }
                        }
                     if(!flag){
                            resultstr = resultstr + "<li id='"+chkname+"'><input type='checkbox' name='t" +
                            chkname + "' value='" + code_id +
                            "' onClick=\"addcheck('"+chkname+"')\">" +
                            code_name + "</li>";
                    }
             }
         }
          if(view.equals("view")||view.equals("print")){
              if(resultstr.lastIndexOf(",")!=-1){
                  resultstr=resultstr.substring(0,resultstr.lastIndexOf(","));
              }
          }
          if(!view.equals("print")){
              resultstr = resultstr+"<li id='"+chkname+"'><input type='hidden' name='"+chkname+"' value='"+defaultval+"'></li>";
          }
         } catch (Exception fe) {
             System.out.println("error at getcode : " + fe.getMessage());
             return null;
         } finally {
             try {
                 if(crs!=null)
                 crs.close();
             } catch (Exception fe) {}
         }
         return resultstr;
     }
        //拼radio  author:w@L@ei
    public String RadioItemList(String code_type,String rdoname,String defaultval, String view) {
       DBTransUtil transUtil = new DBTransUtil();
       StringBuffer strSql = new StringBuffer("select code_id,code_name from code_info t where code_type='");
       strSql.append(code_type);
       strSql.append("'");
       String resultstr = "";

       defaultval = (defaultval == null ) ? "" : defaultval;
       defaultval = (defaultval == "null" ) ? "" : defaultval;
       CachedRowSet crs = null;
       int len = 0;
       String code_id = "";
       String code_name = "";

       try {
           crs = transUtil.getResultBySelect(strSql.toString());
           while (crs.next()) {
               boolean flag = false;
               code_id = FormBean.get(crs.getString("code_id"));
               code_name = FormBean.get(crs.getString("code_name"));
               if (view.equals("view")) {
                   if(code_id.equals(defaultval) || defaultval.equals("")){
                       if(defaultval.equals("")){
                       resultstr="";
                       }else{
                       resultstr=code_name;
                   }
                   }
               } else {

                   if (code_id.equals(defaultval) || defaultval.equals("")) {
                     if(defaultval.equals("")&&crs.isFirst()){
                       resultstr = resultstr + "<input type='radio' name='" +
                                   rdoname + "' value='" + code_id +
                                   "' checked >" + code_name + "  &nbsp;&nbsp;";
                       flag = true;
                   }else{
                       resultstr = resultstr + "<input type='radio' name='" +
                                   rdoname + "' value='" + code_id +
                                   "' checked >" + code_name + "  &nbsp;&nbsp;";
                       flag = true;

                   }
                   }
                   if (!flag) {
                       resultstr = resultstr + "<input type='radio' name='" +
                                   rdoname + "' value='" + code_id + "'>" +
                                   code_name + "  &nbsp;&nbsp;";
                   }
               }
           }
       } catch (Exception fe) {
           System.out.println("error at getcode : " + fe.getMessage());
           return null;
       } finally {
           try {
               if(crs!=null)
               crs.close();
           } catch (Exception fe) {}
       }
       return resultstr;
   }
   //拼select author:w@L@ei
   public String SelectItemList(String code_type, String defaultval,String view) {
       DBTransUtil transUtil = new DBTransUtil();
       StringBuffer strSql = new StringBuffer("select code_id,code_name from code_info where code_type='");
       strSql.append(code_type);
       strSql.append("'");
       String resultstr = "" ;
       if(!view.equals("view")){
           resultstr = "<option value=''>-=请选择=-</option>";
       }
       defaultval = (defaultval == null ) ? "" : defaultval;
       defaultval = (defaultval == "null" ) ? "" : defaultval;
       CachedRowSet crs = null;
       String code_id = "";
    String code_name = "";
       try {
           crs = transUtil.getResultBySelect(strSql.toString());
           while (crs.next()) {
               code_id = FormBean.get(crs.getString("code_id"));
               code_name = FormBean.get(crs.getString("code_name"));
               if(!view.equals("view")){
                   if (code_id.equals(defaultval)) {
                       resultstr = resultstr + "<option value='" + code_id +
                                   "' selected>" + code_name + "</option>";
                   } else {
                       resultstr = resultstr + "<option value='" + code_id +
                                   "'>" + code_name + "</option>";
                   }
               }else{
                   if (code_id.equals(defaultval)) {
                   resultstr = code_name;
                }
               }
           }
       } catch (Exception fe) {
           System.out.println("error at getcode : " + fe.getMessage());
           return null;
       } finally {
           try {
               if(crs!=null)
               crs.close();
           } catch (Exception fe) {}
       }

       return resultstr;
   }

 public String getYM(String name,String value,String type,String currentDate) {
	 StringBuffer ts=new StringBuffer("<select name='"+name+"y' id='"+name+"y' onChange='setdateYM(this);'>");
	ts.append("	<option value=''>请选择</option>");
		  for(int i=0;i<17;i++){
	      ts.append("<option value='"+(Integer.parseInt(currentDate.substring(0,4))-i+2)+"'");
	    		  if(!value.equals("")&&value.substring(0,4).equals((Integer.parseInt(currentDate.substring(0,4))-i+2)+"")){ 
            ts.append(" selected");
            } 
          ts.append(">"+(Integer.parseInt(currentDate.substring(0,4))-i+2)+"</option>");
		  }
		  ts.append("</select>年");
	    ts.append("<select name='"+name+"m' id='"+name+"m' onChange='setdateYM(this);'>");
	    ts.append("<option value=''>请选择</option>");
		     String tm1="";
			  for(int i=1;i<13;i++){
			      if(i<10){
			        tm1="0"+i;
			      }else{
			        tm1=i+"";
			      }
	         ts.append("<option value='"+tm1+"'");
			  if(!value.equals("")&&value.substring(5,7).equals(tm1)){ 
				  ts.append("selected");
				  } 
         ts.append(">"+tm1+"</option>");
			  }
	  ts.append("</select>月");
	  ts.append("<input name='"+name+"' type='hidden'  id='nianjian' value='"+value+"'");
	  if(type=="checknull"){
	  ts.append(" dataType='Require'  msg='请填写！'");
	  }
	  ts.append("/>");
	  return ts.toString();
   }


 public String getnode(String supid,String pid,String rid) throws Exception{
	  String result="";
		try{
			DBTransUtil dbutil = new DBTransUtil();
			String sql2="select a.*, decode(c.funcid,'','unchecked','checked') ischeck from ( select distinct b.funcname,nvl(b.load_page,'0') load_page, b.funcid, b.ismenu, b.img_url,b.sup_func "+
			"from functionlist b connect by funcid = prior sup_func  "+
			") a, tb_rolefuns c where a.funcid=c.funcid(+) "+
				"and c.rid(+)='"+rid+"' and a.sup_func='"+supid+"' order by a.funcid";
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
 public static void  downLoadFromUrl(String urlStr,String fileName,String savePath) throws IOException{
     URL url = new URL(urlStr);  
     HttpURLConnection conn = (HttpURLConnection)url.openConnection();  
             //设置超时间为3秒
     conn.setConnectTimeout(3*1000);
     //防止屏蔽程序抓取而返回403错误
     conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

     //得到输入流
     InputStream inputStream = conn.getInputStream();  
     //获取自己数组
     byte[] getData = readInputStream(inputStream);    

     //文件保存位置
     File saveDir = new File(savePath);
     if(!saveDir.exists()){
         saveDir.mkdir();
     }
     File file = new File(saveDir+File.separator+fileName);    
     FileOutputStream fos = new FileOutputStream(file);     
     fos.write(getData); 
     if(fos!=null){
         fos.close();  
     }
     if(inputStream!=null){
         inputStream.close();
     }


     System.out.println("info:"+url+" download success"); 

 }
 public static  byte[] readInputStream(InputStream inputStream) throws IOException {  
     byte[] buffer = new byte[1024];  
     int len = 0;  
     ByteArrayOutputStream bos = new ByteArrayOutputStream();  
     while((len = inputStream.read(buffer)) != -1) {  
         bos.write(buffer, 0, len);  
     }  
     bos.close();  
     return bos.toByteArray();  
 }  
}
