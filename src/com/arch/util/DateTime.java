/*
 * 版权所有
 * 项目名称 budget
 * 包名称
 *
 * 文件名称 DateTime.java
 *
 */
package com.arch.util;

import java.util.*;
import java.util.Date;
import java.text.SimpleDateFormat;

/**
 * 功能描述  日期相关操作<br><br>
 * 创建日期 2004-2-11 21:03:45
 *
 * @author  kingfish
 * @version 1.0
 */
public class DateTime {
	Calendar calendar;

	public DateTime() {
		calendar = null;
		calendar = Calendar.getInstance();
		calendar.setTime(new Date());
	}

	public int getYear() {
		return calendar.get(1);
	}

	public int getMonth() {
		return 1 + calendar.get(2);
	}

	public int getDay() {
		return calendar.get(5);
	}

	public int getHour() {
		return calendar.get(11);
	}

	public int getMinute() {
		return calendar.get(12);
	}

	public int getSecond() {
		return calendar.get(13);
	}

	public int getMSecond(){
		return calendar.get(14);
	}

	public String getStringMonth(){
		String s = "00";
		s = s + getMonth();
		s = s.substring(s.length() - 2);
		return s;
	}

	public String getStringMonth(int a){
		String s = "00";
		s = s + a;
		s = s.substring(s.length() - 2);
		return s;
	}

	public  String getYearAndOther() {
		String s = "0000";
		String s1 = "00";
		String s2 = "00";
		String s3 = "00";
		String s4 = "00";
		String s5 = "00";
		String s6 = "00";
		s = s + getYear();
		s1 = s1 + getMonth();
		s2 = s2 + getDay();
		s3 = s3 + getHour();
		s4 = s4 + getMinute();
		s5 = s5 + getSecond();
		s = s.substring(s.length() - 4);
		s1 = s1.substring(s1.length() - 2);
		s2 = s2.substring(s2.length() - 2);
		s3 = s3.substring(s3.length() - 2);
		s4 = s4.substring(s4.length() - 2);
		s5 = s5.substring(s5.length() - 2);
		return s + "-" + s1 + "-" + s2 + " " + s3 + ":" + s4 + ":" + s5;
	}

        public  String getYMDhh24mi() {
                String s = "0000";
                String s1 = "00";
                String s2 = "00";
                String s3 = "00";
                String s4 = "00";
                s = s + getYear();
                s1 = s1 + getMonth();
                s2 = s2 + getDay();
                s3 = s3 + getHour();
                s4 = s4 + getMinute();

                s = s.substring(s.length() - 4);
                s1 = s1.substring(s1.length() - 2);
                s2 = s2.substring(s2.length() - 2);
                s3 = s3.substring(s3.length() - 2);
                s4 = s4.substring(s4.length() - 2);
                return s + "-" + s1 + "-" + s2 + " " + s3 + ":" + s4 ;
	}

	public  String getYearMonthDay() {
		String s = "0000";
		String s1 = "00";
		String s2 = "00";
		s = s + getYear();
		s1 = s1 + getMonth();
		s2 = s2 + getDay();
		s = s.substring(s.length() - 4);
		s1 = s1.substring(s1.length() - 2);
		s2 = s2.substring(s2.length() - 2);
		return s + "/" + s1 + "/" + s2;
	}

        public  String getYearMonthDayYMD() {
                String s = "0000";
                String s1 = "00";
                String s2 = "00";
                s = s + getYear();
                s1 = s1 + getMonth();
                s2 = s2 + getDay();
                s = s.substring(s.length() - 4);
                s1 = s1.substring(s1.length() - 2);
                s2 = s2.substring(s2.length() - 2);
                return s + "-" + s1 + "-" + s2;
	}

	public  String getHourMinuteSecond() {
		String s = "00";
		String s1 = "00";
		String s2 = "00";
		s = s + getHour();
		s1 = s1 + getMinute();
		s2 = s2 + getSecond();
		s = s.substring(s.length() - 2, s.length());
		s1 = s1.substring(s1.length() - 2, s1.length());
		s2 = s2.substring(s2.length() - 2, s2.length());
		return s + ":" + s1 + ":" + s2;
	}

	public  String getLongId(){
		String s = "0000";
		String s1 = "00";
		String s2 = "00";
		String s3 = "00";
		String s4 = "00";
		String s5 = "00";
		String s6 = "00";
		String s7 = "000";
		s = s + getYear();
		s1 = s1 + getMonth();
		s2 = s2 + getDay();
		s3 = s3 + getHour();
		s4 = s4 + getMinute();
		s5 = s5 + getSecond();
		s7 = s7 + getMSecond();
		s = s.substring(s.length() - 4);
		s1 = s1.substring(s1.length() - 2);
		s2 = s2.substring(s2.length() - 2);
		s3 = s3.substring(s3.length() - 2);
		s4 = s4.substring(s4.length() - 2);
		s5 = s5.substring(s5.length() - 2);
		s7 = s7.substring(s7.length() - 3);
		s6 = String.valueOf(Math.random()).substring(2, 4);
		return s + s1 + s2 + s3 + s4 + s5 + s7 + s6;
	}

        /**
         * 以指定的格式来格式化日期
         * @param date Date型日期
         * @param format 指定的格式
         * @return String型日期
         */
            public static String parseDate( Date date , String format)
            {
            String   result   =   "";
            if( date !=  null)
            {
                    try
                 {
                        SimpleDateFormat   sdf   =   new   SimpleDateFormat(format);
                        result   =   sdf.format(date);
                 }
                    catch(Exception   ex)
                {
                }
            }
            return   result;
	}

}
