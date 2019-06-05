package com.arch.util;

import java.io.*;
import java.util.*;
import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.*;
import java.math.*;

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
public class FormBean {

    public static final int SECONDS_PER_DAY = 0x15180;
    public static final int SECONDS_PER_YEAR = 0x1e13380;

    /**
     * 描述
     * @param 变量名称 功能
     * @return 返回变量名称 功能
     */
    public FormBean() {
        super();
        //  自动生成构造函数存根
    }

    public static String EncodeIso2GB(String s) {
        String temp = "";
        if (s != null) {
            try {
                temp = new String(s.getBytes("ISO8859_1"), "GB18030");
                //temp.trim();
                temp = s.trim();

            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return temp;
    }

    public static boolean disposeEmail(String s) {
        StringTokenizer stringtokenizer = new StringTokenizer(s, "@");
        return stringtokenizer.hasMoreTokens();
    }

    public static String getCookie(Cookie acookie[], String s, String s1) {
        if (acookie != null) {
            for (int i = 0; i < acookie.length; i++) {
                Cookie cookie = acookie[i];
                if (s.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }

        }
        return s1;
    }

    public static String getRequestFileName(HttpServletRequest
                                            httpservletrequest) {
        String filename = httpservletrequest.getServletPath();
        int mQ = 0;
        int nQ = 0;
        mQ = filename.lastIndexOf("/");
        nQ = filename.lastIndexOf(".");
        filename = filename.substring(mQ + 1, nQ);
        return filename;
    }

    public static String getUnicodeString(String s) throws
            UnsupportedEncodingException {
        if (s == null) {
            return "";
        } else {
            return new String(s.getBytes("ISO8859_1"), "GBK");
        }
    }

    public static String get(Object ob, String sDefault) {
        String sTemp = "";
        if (ob == null) {
            if (sDefault == null) {
                sTemp = "";
            } else {
                sTemp = sDefault;
            }
        } else {
            sTemp = ob.toString();
        }
        return sTemp;
    }

    public static String get(Object ob) {
        return get(ob, "");
    }

    public static double round(double v, int scale) {

        if (scale < 0) {

            throw new IllegalArgumentException(
                    "The scale must be a positive integer or zero");

        }

        BigDecimal b = new BigDecimal(Double.toString(v));

        BigDecimal one = new BigDecimal("1");

        return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();

    }

    //转换表单里textarea输入的回车
    //去掉奇怪的：
    public static String RemoveComment(String Content) {
        String makeContent = new String();
        StringTokenizer strToken = new StringTokenizer(Content, "\n");
        String tempToken = null;

        while (strToken.hasMoreTokens()) {
            tempToken = strToken.nextToken();
            if (tempToken.indexOf(":") != 0) {
                makeContent = makeContent + tempToken + "\n";
            }
        }

        return makeContent;
    }

    //将/n转换成为回车<br>
    public static String addBr(String Content) {
        String makeContent = new String();
        StringTokenizer strToken = new StringTokenizer(Content, "\n");
        while (strToken.hasMoreTokens()) {
            makeContent = makeContent + "<br>" + strToken.nextToken();
        }
        return makeContent;
    }

    //返回当天日期格式
    public static String getToday() {

        Date d = new Date();
        String str_date = d.toLocaleString();
        int months = 0, days = 0;
        String years = "", monthstr = "", daystr = "";
        years = d.getYear() + 1900 + "";
        months = d.getMonth() + 1;
        days = d.getDate();

        if (months < 10) {
            monthstr = "0" + months;
        } else {
            monthstr = "" + months;
        }

        if (days < 10) {
            daystr = "0" + days;
        } else {
            daystr = "" + days;
        }

        str_date = "" + years + "-" + monthstr + "-" + daystr;

        return str_date;
    }


    //getdaybyformat
    public static String getDateFormat(String str) {
        String year = "", month = "", day = "";
        if (str != null && !str.equals("")) {
            int start = str.indexOf('-');
            year = str.substring(0, start);
            start++;
            int start1 = str.indexOf('-', start);
            month = str.substring(start, start1);
            day = str.substring(start1 + 1);
        }
        return year + "/" + month + "/" + day;
    }

    //getdaybyformat(dd/mm/yyyy to yyyy-mm-dd)
    public static String getDateStr(String str) {
        String year = "", month = "", day = "";
        if (str != null && !str.equals("")) {
            int start = str.indexOf('/');
            day = str.substring(0, start);
            start++;
            int start1 = str.indexOf('/', start);
            month = str.substring(start, start1);
            year = str.substring(start1 + 1);
        }
        return year + "-" + month + "-" + day;
    }
    
    public static String getRandom(int len){
      java.util.Random r = new java.util.Random();
      String st = "";
      for (int tt=0;tt<len;tt++){
         st += Integer.toString(r.nextInt(36) ,36);
      }
      return st;                 
   }                        
    public static String ashtml(String str) {
    	str = str.replaceAll("\r\n", "<br/>");
        str = str.replaceAll("\n", "<br/>");
        str = str.replaceAll("\r", "<br/>");
        str = str.replaceAll(" ", "&nbsp;");
        return str;
    }
    public static void CopyFile(File in, File out) throws Exception {
        FileInputStream fis  = new FileInputStream(in);
        FileOutputStream fos = new FileOutputStream(out);
        byte[] buf = new byte[1024];
        int i = 0;
        while((i=fis.read(buf))!=-1) {
          fos.write(buf, 0, i);
          }
        fis.close();
        fos.close();
        }
}
