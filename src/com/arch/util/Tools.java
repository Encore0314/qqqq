package com.arch.util;

import sun.jdbc.rowset.*;
import java.text.*;
import java.util.*;
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class Tools {
    public Tools() {
    }

    /**
     * nvl
     * @param aString
     * @param newString
     * @return
     */
    public static String nvl(String aString, String newString) {
        return (aString == null) ? newString : aString;
    }

    /**
     * nvl
     * @param aString
     * @return
     */
    public static String nvl(String aString) {
        return nvl(aString, "");
    }

    /**
     *
     * @param string
     * @return
     */
    public static java.sql.Date stringToDate(String string) {
        return sqlDate(string);
    }

    //处理8位日期字符串，返回java.sql.Date类型
    public static java.sql.Date sqlDate(String s) {
        if (s == null) {
            return null;
        }
        if (s.length() != 8) {
            return null;
        }
        int year = Integer.parseInt(s.substring(0, 4));

        int month = Integer.parseInt(s.substring(4, 6)) - 1;

        int day = Integer.parseInt(s.substring(6, 8));
        java.util.GregorianCalendar myCalendar = new java.util.
                                                 GregorianCalendar(
                year, month, day);
        java.sql.Date myDate = new java.sql.Date(myCalendar.getTime().getTime());
        return myDate;
    }

//加密
    public static String encrypt(String s) {
        Md5 m = new Md5();
        return m.getMD5ofStr(s);
    }

//解密
    public static String decrypt(String s) {
        return "不能解密" + s + "，没有设置解密方法。请重载Tools.decrypt()";
    }

    public static boolean isDateBefore(String date2){
     try{
      Date date1 = new Date();
      DateFormat df = DateFormat.getDateTimeInstance();
      return date1.before(df.parse(date2));
     }catch(ParseException e){
      System.out.print("[SYS] " + e.getMessage());
      return false;
     }
    }
    public static String asHTML(String text)  throws Exception    
    {    
        if (text == null) return "";    
        StringBuffer results = new StringBuffer();    
          
        int beg = 0, len = text.length();
        if (len> 3999) {
            throw new Exception("输入文本过长！");
        }
        for (int i = 0; i < len; ++i)    
        {    
            char c = text.charAt(i);                  
                switch (c) {   
                default: // case 0:    
                	results.append(c);
                    continue;   
                case '&':   
                    results.append("&amp;");   
                    break;   
                case '>':   
                    results.append("&gt;");   
                    break;   
                case '<':   
                    results.append("&lt;");   
                    break;   
                case '"':    
                    results.append("\"");    
                    break;    
                }    
    
            }    
                   
            
        return results.toString().replace("and","").replace("exec","").replace("insert","").replace("delete","").replace("update","").replace("select","");    
    }  
}
