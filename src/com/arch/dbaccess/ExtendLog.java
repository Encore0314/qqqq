package com.arch.dbaccess;

import com.arch.basebean.*;

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
public class ExtendLog {
    public ExtendLog() {

    }

//这个对象主要是用来存储操作数据库后返回的结果和sql语句,封装起来,sql语句用来实例话log,记录系统日志

    public OracleRowSet[] getOrs() {
        return ors;
    }

    public String getSql() {
        return sql;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public void setOrs(OracleRowSet[] ors) {
        this.ors = ors;
    }
    public void setSql(String sql) {
        this.sql = sql;
    }
    OracleRowSet[] ors = null;
    private String sql = "";
    private int rows = -1;

}
