package com.arch.util;

import javax.naming.*;
import javax.sql.*;
import sun.jdbc.rowset.*;
import java.sql.*;
import java.util.*;

import com.arch.util.*;
import com.arch.exception.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class DBTransUtil {

    private String JNDI = SysConst.JNDI;
    private DataSource ds = null;
    private Context ctx = null;
    private Connection con = null;
    private Statement stmt = null; //公用Statement
    private String errorMessage = "";
    private Vector sqlVector = new Vector(5);

    public DBTransUtil() {
    }

    public DBTransUtil(String jndi) {
        this.JNDI = jndi;
    }

    /**
     * 增加一个Sql语句至Batch
     * @param strSql
     * @throws Exception
     */
    public void addSql(String strSql) throws DBException {
        sqlVector.add(strSql);
    }

    /**
     *  执行一批Sql语句，使用addSql加入Sql
     * @param instring
     * @return
     */
    public  boolean executeSql() throws DBException {
        int[] res = {0};
        try {

            ctx = new InitialContext();
            ds = (DataSource) ctx.lookup(JNDI);
            con = ds.getConnection();
            con.setAutoCommit(false);
            stmt = con.createStatement();
            for (int i = 0; i < sqlVector.size(); i++) {
                stmt.addBatch(sqlVector.get(i).toString());
            }
            res = stmt.executeBatch();
            con.commit();
        } catch (SQLException fe) {
            try {
                con.rollback();
            } catch (SQLException e) {}
            SysConst.trace("executeSql出现错误：" + fe.getMessage());
            throw new DBException(fe.getMessage());
            //return false;
        } catch (NamingException fe) {
            throw new DBException(fe.getMessage());
        } finally {
            try {
                con.setAutoCommit(true);
                stmt.close();
                con.close();
            } catch (Exception e) {}
        }
        return true;
    }
    public  boolean executeSql(String sql) throws DBException {
        int[] res = {0};
        try {

            ctx = new InitialContext();
            ds = (DataSource) ctx.lookup(JNDI);
            con = ds.getConnection();
            con.setAutoCommit(false);
            stmt = con.createStatement();
             stmt.execute(sql);
            con.commit();
        } catch (SQLException fe) {
            try {
                con.rollback();
            } catch (SQLException e) {}
            SysConst.trace("executeSql出现错误：" + fe.getMessage());
            throw new DBException(fe.getMessage());
            //return false;
        } catch (NamingException fe) {
            throw new DBException(fe.getMessage());
        } finally {
            try {
                con.setAutoCommit(true);
                stmt.close();
                con.close();
            } catch (Exception e) {}
        }
        return true;
    }
    /**
     *  得到CachedRowSet，使用时需注意
     * @param strSql  查询用sql语句
     * @return  返回一个结果集，类型为sun.jdbc.rowset.CachedRowSet
     * @throws SQLException
     */
    public CachedRowSet getResultBySelect(String strSql) throws DBException {
        CachedRowSet crs = null;
        ResultSet rs = null;
        try {
            ctx = new InitialContext();
            ds = (DataSource) ctx.lookup(JNDI);
            crs = new CachedRowSet();
            con = ds.getConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery(strSql);
            crs.populate(rs);
        } catch (SQLException e) {
            throw new DBException(e.getMessage());
        } catch (NamingException fe) {
            throw new DBException(fe.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
            }
            return crs;
        }
    }

    public ResultSet getResultSetBySelect(String strSql) throws DBException {
            ResultSet rs = null;
            try {
                ctx = new InitialContext();
                ds = (DataSource) ctx.lookup(JNDI);
                con = ds.getConnection();
                stmt = con.createStatement();
                rs = stmt.executeQuery(strSql);
            } catch (SQLException e) {
                throw new DBException(e.getMessage());
            } catch (NamingException fe) {
                throw new DBException(fe.getMessage());
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (Exception e) {
                }
                return rs;
            }
        }


    public String getSequence(String sequenceName) throws DBException {
        StringBuffer buffer = new StringBuffer();
        buffer.append("Select " + sequenceName + ".nextval from dual");

        String seqId = getColumnValue(buffer.toString());
        return seqId;

    }

    public String getColumnValue(String strSql) throws DBException {

        String tempStr = "";

        CachedRowSet crs = getResultBySelect(strSql);
        try {
            if (crs.next()) {
                tempStr = crs.getString(1) == null ? "" : crs.getString(1);
            }
        } catch (SQLException fe) {
            throw new DBException(fe.getMessage());
        }
        return tempStr;
    }


    public int getRecNumBySelect(String strSql) throws DBException {
        int recnum = 0;
        CachedRowSet crs = null;
        StringBuffer tempSql = new StringBuffer("");
        try {
            tempSql.append("select count(1) from ");
            tempSql.append(strSql.substring(strSql.indexOf("from") + 4));
            crs = this.getResultBySelect(tempSql.toString());
            if (crs.next()) {
                recnum = crs.getInt(1);
            } else {
                recnum = 0;
            }
        } catch (Exception e) {
            SysConst.trace(e.getMessage());
            throw new DBException(e.getMessage());
        } finally {
            try {
                crs.close();
            } catch (SQLException ex) {}
        }
        return recnum;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public Connection getConnection() throws Exception {
        try {
            ctx = new InitialContext();
            ds = (DataSource) ctx.lookup(JNDI);
        } catch (NamingException e) {
            throw new Exception(e.getMessage());
        }

        try {
            con = ds.getConnection();
        } catch (SQLException e) {
            throw new Exception(e.getMessage());

        }

        return con;
    }

    public String getSeqID( String seqName ) throws DBException {
        String seqID = "" ;
        String strSql = " SELECT " + seqName + ".nextval FROM dual " ;

        CachedRowSet crs = null;
               StringBuffer tempSql = new StringBuffer("");
               try {

                   crs = getResultBySelect(strSql);
                   if (crs.next()) {
                       seqID = crs.getString(1);
                   }
               } catch (Exception e) {
                   SysConst.trace(e.getMessage());
                   throw new DBException(e.getMessage());
               } finally {
                   try {
                       crs.close();
                   } catch (SQLException ex) {}
               }
               return seqID;
    }
}
