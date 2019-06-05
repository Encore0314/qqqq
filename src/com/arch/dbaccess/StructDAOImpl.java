package com.arch.dbaccess;

import com.arch.basebean.*;
import com.arch.util.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.*;

import sun.jdbc.rowset.*;
import java.util.HashMap;
import com.arch.exception.WebException;


/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2006</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class StructDAOImpl {
    public StructDAOImpl() {
    }

//去掉字符串的前导空格
    private String trimStart(String str) {
        int index = -1;
        for (int i = 0; i < str.length(); i++) {
            if (str.charAt(i) == ' ') {
                index = i;
            } else {
                break;
            }
        }
        return str.substring(index + 1);
    }

//对数据库进行操作
    public  ExtendLog processDB(Connection con,Operation[] operation, int op) throws
            WebException, Exception {
    	String sql=operation[op].getSql();
        //sql = trimStart(sql.replace(";", ""));
        PrepareSql pSql = new PrepareSql();
        pSql.setSql(sql);
        ExtendLog result = null;

        PreparedStatement preparedStatement = null;
        ResultSet rs =null;
        CachedRowSet crs =null;
        //获得所有要关联的变量
        String[] params = pSql.getParams();
        //用来接收查询结果
        OracleRowSet[] ors = null;
        String tmpSql=sql;
        HashMap fieldData=(HashMap)operation[op].getField();
        try {

            preparedStatement = con.prepareStatement(pSql.
                    getSql());
            int row = (Integer) operation[op].getRow();
            row=(row == 0 ? 1 : row);
            SysConst.trace("这个操作的操作行数为：" + (row == 0 ? 1 : row));
            //将sql和值拼起来输出，方便调试
           // if(SysConst.CANWRITE){
           // sql_log = printSql(sql, row, params, (HashMap)operation[op].getField());
           // }
            result = new ExtendLog();
            
            //对操作的行数进行循环
            String[] tempData =null;
            int cols=0;
            String[] tmpcols=null;
            for (int i = 0; i < row; i++) {
            	
                for (int p = 0; p < params.length; p++) {
                    tempData = (String[])fieldData.get(params[p]);
                    if (tempData == null) {
                        throw new WebException(
                                "错误代码：s0000017"+params[p]);
                    }
                    //如果这个是多行操作，则每一行的值可能不同，要分别读取
                    ///之所以不用preparedStatement.setString(pSql.getIndex(),""),是因为当有i两个变量名字相同时，它只能解析第一个，而不会解析后面的变量
                    if (tempData.length<row ) {
                        preparedStatement.setString(p + 1,
                                tempData[0]);
                        if(SysConst.CANWRITE){
                            if(tmpSql.indexOf(":" + params[p])+params[p].length()+1<tmpSql.length()&&PrepareSql.isEnd(tmpSql.charAt(tmpSql.indexOf(":" + params[p])+params[p].length()+1))){
                            tmpSql = tmpSql.replace(":" + params[p],
                                    "'" + tempData[0] + "'");
                            }else{
                            	tmpSql = tmpSql.replace(":" + params[p],
                                        "'" + tempData[0] + "'");
                            }
                        }
                    } else {
                        //单行操作
                        ///之所以不用preparedStatement.setString(pSql.getIndex(),""),是因为当有i两个变量名字相同时，它只能解析第一个，而不会解析后面的变量
                        preparedStatement.setString(p + 1,
                                tempData[i]);
                        if(SysConst.CANWRITE){
                        if(tmpSql.indexOf(":" + params[p])+params[p].length()+1<tmpSql.length()&&PrepareSql.isEnd(tmpSql.charAt(tmpSql.indexOf(":" + params[p])+params[p].length()+1))){
                        tmpSql = tmpSql.replace(":" + params[p],
                                "'" + tempData[i] + "'");
                        }else{
                        	tmpSql = tmpSql.replace(":" + params[p],
                                    "'" + tempData[i] + "'");
                        }
                    }}
                    
                    tempData=null;
                }
                if(SysConst.LOGWRITE){
               	 result.setSql(tmpSql);
                }
                 if(SysConst.CANWRITE){
                	 SysConst.trace("ParseSql" + (i + 1) + "=" + tmpSql);
                 }
                //如果这个操作是查询操作，则要对查询结果进行处理，存储在OracleRowSet数组里面
                if(SysConst.DBTYPE.equals("MSSQL")){
               // if (sql.startsWith("select")) {
                    preparedStatement.execute();
                    rs = preparedStatement.getResultSet();

                    if(rs!=null){
                    SysConst.trace("Database query success");
                    crs = new CachedRowSet();
                    crs.populate(rs);
                    ors = new OracleRowSet[crs.size()];
                    result.setRows(crs.size());
                    ResultSetMetaData rsm = crs.getMetaData();
 
                     cols= rsm.getColumnCount();
                    tmpcols=new String[cols];
                    for(int k=0;k<cols;k++){
                        tmpcols[k]=rsm.getColumnLabel(k+1).toLowerCase();
                    }

                    SysConst.trace("CachedRowSet.size()="+crs.size());
                    for (int j = 0; j < crs.size(); j++) {
                        ors[j] = new OracleRowSet(cols);
                        crs.next();
                        for (int c = 1; c <= cols; c++) {
                            //tmpcols[c-1]=rsm.getColumnName(c).toLowerCase();
  //                            rsm.getColumnTypeName(c).equals("DATE");
                        	/*
                        	if(rsm.getColumnType(c)!=java.sql.Types.CLOB){
                        		ors[j].setValue(rsm.getColumnName(c).toLowerCase(),
                                        crs.getString(c)==null?"":crs.getString(c));
                            }
                            else{
                                String clobString=null;
                                Clob    clob=rs.getClob(i);
                                if(clob!=null&&(int)clob.length()>0){
                                     clobString=clob.getSubString((long)1,(int)clob.length());
                                }
                                ors[j].setValue(rsm.getColumnName(c).toLowerCase(),
                                		clobString);
                            }
                            */
                            ors[j].setValue(rsm.getColumnLabel(c).toLowerCase(),
                                            crs.getString(c)==null?"":crs.getString(c));
                        }
                        if(j==0){
                            ors[0].setCols(tmpcols);
                        }

                    }
//                    if(ors.length<1){
//                        ors=new OracleRowSet[1];
//                        ors[0]=new OracleRowSet(200);
//                    }
                    result.setOrs(ors);

                    SysConst.trace("Set ResultSet to CachedRowSet success!");


            }else{
                //result.setRows(preparedStatement.executeUpdate());
                SysConst.trace("Database Access success");
            }
                }

                if(SysConst.DBTYPE.equals("ORACLE")){
                     if (sql.startsWith("select")) {
                     rs = preparedStatement.executeQuery();

                         SysConst.trace("Database query success");
                         crs = new CachedRowSet();
                         crs.populate(rs);
                         ors = new OracleRowSet[crs.size()];
                         result.setRows(crs.size());
                         ResultSetMetaData rsm = crs.getMetaData();

                          cols= rsm.getColumnCount();
                         tmpcols=new String[cols];
                         for(int k=0;k<cols;k++){
                             tmpcols[k]=rsm.getColumnName(k+1).toLowerCase();
                         }

                         SysConst.trace("CachedRowSet.size()="+crs.size());
                         for (int j = 0; j < crs.size(); j++) {
                             ors[j] = new OracleRowSet(cols);
                             crs.next();
                             for (int c = 1; c <= cols; c++) {
                                 //tmpcols[c-1]=rsm.getColumnName(c).toLowerCase();
       //                            rsm.getColumnTypeName(c).equals("DATE");
                            	 if(rsm.getColumnType(c)!=java.sql.Types.CLOB){
                              		ors[j].setValue(rsm.getColumnName(c).toLowerCase(),
                                              crs.getString(c)==null?"":crs.getString(c));
                                  }
                                  else{
                                      String clobString=null;
                                      Clob    clob=crs.getClob(c);
                                      
                                      if(clob!=null&&clob.length()>0){
                                           clobString= ClobToString(clob); 
                                      }
                                      ors[j].setValue(rsm.getColumnName(c).toLowerCase(),
                                      		clobString);
                                  }
                             }
                             if(j==0){
                                 ors[0].setCols(tmpcols);
                             }

                         }
                         if(ors.length<1){
                             ors=new OracleRowSet[1];
                             ors[0]=new OracleRowSet(200);
                         }
                         result.setOrs(ors);

                         SysConst.trace("Set ResultSet to CachedRowSet success!");


                 }else{
                     result.setRows(preparedStatement.executeUpdate());
                     SysConst.trace("Database Access success");
                 }
                }

                if(SysConst.DBTYPE.equals("MYSQL")){
                    if (sql.startsWith("select")) {
                    rs = preparedStatement.executeQuery();

                        SysConst.trace("Database query success");
                        crs = new CachedRowSet();
                        crs.populate(rs);
                        ors = new OracleRowSet[crs.size()];
                        result.setRows(crs.size());
                        ResultSetMetaData rsm = crs.getMetaData();

                         cols= rsm.getColumnCount();
                        tmpcols=new String[cols];
                        for(int k=0;k<cols;k++){
                            tmpcols[k]=rsm.getColumnLabel(k+1).toLowerCase();
                        }

                        SysConst.trace("CachedRowSet.size()="+crs.size());
                        for (int j = 0; j < crs.size(); j++) {
                            ors[j] = new OracleRowSet(cols);
                            crs.next();
                            for (int c = 1; c <= cols; c++) {
                                //tmpcols[c-1]=rsm.getColumnName(c).toLowerCase();
      //                            rsm.getColumnTypeName(c).equals("DATE");
                                ors[j].setValue(rsm.getColumnLabel(c).toLowerCase(),
                                                crs.getString(c)==null?"":crs.getString(c));
                            }
                            if(j==0){
                                ors[0].setCols(tmpcols);
                            }

                        }
                        if(ors.length<1){
                            ors=new OracleRowSet[1];
                            ors[0]=new OracleRowSet(200);
                        }
                        result.setOrs(ors);

                        SysConst.trace("Set ResultSet to CachedRowSet success!");


                }else{
                    result.setRows(preparedStatement.executeUpdate());
                    SysConst.trace("Database Access success");
                }
               }
            }

        } catch (Exception e) {
        	if(e.getMessage().startsWith("该语句没有返回结果集")){
                ors = new OracleRowSet[1];
                ors[0]=new OracleRowSet(200);
                result.setRows(0);
                result.setOrs(ors);
        	}else{
              con.rollback();
              SysConst.trace("数据库执行出错，第" + (op + 1) +
                                 "个Operation所有数据修改将被滚回，但不影响之前提交的operation。");
              throw new WebException(e.getMessage(),
                                     "==>" + "StructDAOImpl.processDB()");
        	}
          } finally {
              if(rs!=null)
              rs.close();
              if(preparedStatement!=null)
              preparedStatement.close();

          }
          sql = null;
           pSql = null;

         
           preparedStatement = null;
           rs =null;
           crs =null;
          //获得所有要关联的变量
           params = null;
          //用来接收查询结果


         ors = null;


        SysConst.trace("end execute processDB!");
        return result;
    }

    public static String ClobToString(Clob clob){
    	if(clob==null)return null;
    	String reString = "";
    	Reader is;
    	StringBuffer sb = new StringBuffer();
    	BufferedReader br = null;
    	try {
    	is = clob.getCharacterStream();
    	// 得到流
    	br = new BufferedReader(is);
    	String s = br.readLine();

    	while (s != null) {// 执行循环将字符串全部取出付值给StringBuffer由StringBuffer转成STRING
    	sb.append(s);
    	s = br.readLine();
    	}
    	} catch (Exception e) {
    	e.printStackTrace();
    	return null;
    	}finally{
    	try {
    	if (br != null){
    	br.close();
    	}
    	} catch (IOException e) {
    	e.printStackTrace();
    	}
    	}
    	reString = sb.toString();
    	return reString;
    	} 
}
