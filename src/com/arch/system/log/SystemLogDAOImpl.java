package com.arch.system.log;

import com.arch.util.*;
import com.arch.dbaccess.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

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
public class SystemLogDAOImpl implements SystemLogDAO {
    public SystemLogDAOImpl() {
    }

    public boolean addLog() {
        return true;
    }

    public boolean addLog(Log log) {
        DBTransUtil transUtil = new DBTransUtil();
        PrepareSql pSql = new PrepareSql();
        pSql.setSql("insert into syslog(userid, ip, fid, runsql, flag, message, intime) " +
        		"values(:userid, :ip, :fid, :sql, :flag, :message, :tt)");
        Connection con = null;
        PreparedStatement preparedStatement = null;
        try {
            con = transUtil.getConnection();
            preparedStatement = con.prepareStatement(pSql.
                    getSql());
            preparedStatement.setString(pSql.getIndex("userid"), log.getUserid());
            preparedStatement.setString(pSql.getIndex("ip"), log.getIp());
            preparedStatement.setString(pSql.getIndex("fid"), log.getFid());
            preparedStatement.setString(pSql.getIndex("sql"),log.getSql());
            preparedStatement.setString(pSql.getIndex("flag"), log.getFlag());
            preparedStatement.setString(pSql.getIndex("message"),log.getMessage());
            preparedStatement.setString(pSql.getIndex("tt"),new java.sql.Timestamp(System.currentTimeMillis()).toString());
            preparedStatement.execute();
            SysConst.trace("Add system log success");
            return true;
        } catch (Exception e) {
            SysConst.trace("!!!!Add system log fail.Cause:" + e.getMessage());
              try {
                 con.rollback();
           } catch (Exception e1) {}

            return false;
        } finally {
            try{
                if (preparedStatement != null)
                    preparedStatement.close();
                if (con != null)
                    con.close();
                pSql=null;
                transUtil=null;
            }catch(Exception e){
             }
        }

    }

    public boolean addLog(Log[] log) {
        DBTransUtil transUtil = new DBTransUtil();
        PrepareSql pSql = new PrepareSql();
        pSql.setSql("insert into syslog  (userid, ip, fid, sql, flag, message, datetime)values(:userid, :ip, :fid, :sql, :flag, :message, :datetime)");
        Connection con = null;
        PreparedStatement preparedStatement = null;
        try {
            con = transUtil.getConnection();
            preparedStatement = con.prepareStatement(pSql.
                    getSql());
            for (int i = 0; i < log.length; i++) {
                preparedStatement.setString(pSql.getIndex("userid"),
                                            log[i].getUserid());
                preparedStatement.setString(pSql.getIndex("ip"), log[i].getIp());
                preparedStatement.setString(pSql.getIndex("fid"), log[i].getFid());
                preparedStatement.setString(pSql.getIndex("sql"), log[i].getSql());
                if(log[i].getSql().length()>3999){
                    preparedStatement.setString(pSql.getIndex("sql"), log[i].getSql().substring(1,3999));
                }else
                preparedStatement.setString(pSql.getIndex("sql"),log[i].getSql());
                preparedStatement.setString(pSql.getIndex("flag"),
                                            log[i].getFlag());
                if(log[i].getMessage().length()>3999){
                     preparedStatement.setString(pSql.getIndex("message"), log[i].getMessage().substring(1,3999));
                 }else
                     preparedStatement.setString(pSql.getIndex("message"),
                                        log[i].getMessage());
                preparedStatement.execute();

            }
            SysConst.trace("Add system log success");
            return true;
        } catch (Exception e) {
            SysConst.trace("!!!!Add system log fail.Cause:" + e.getMessage());
            try {
               con.rollback();
         } catch (Exception e1) {}

            return false;

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
                if (con != null)
                    con.close();
                pSql=null;
                transUtil=null;
            } catch (Exception e) {}
        }

    }


}
