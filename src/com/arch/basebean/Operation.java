package com.arch.basebean;


/**
 * <p>Title: 用来存储一个操作相关的所有信息</p>
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
public class Operation {
    public Operation() {
    }

    public Object getField() {
        return field;
    }


    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public void setField(Object field) {
        this.field = field;
    }
    public void setRow(int row) {
        this.row = row;
    }
    public void setExpectFaultMsg(String expectFaultMsg) {
        this.expectFaultMsg = expectFaultMsg;
    }

    public void setExpectRows(String expectRows) {
        this.expectRows = expectRows;
    }

    public String getExpectRows() {
        return expectRows;
    }

    public String getExpectFaultMsg() {
        return expectFaultMsg;
    }

    public int getRow() {
        return row;
    }
    //存储该操作的sql语句
    private String sql = "";
    //这个操作所需的全部字段有关的信息,可以是数组
    private Object field = null;
    //operation预期影响的行数，它的值只能取整数或者">0"
    private String expectRows = "";
//没有达到预期影响行数提示的错误信息
    private String expectFaultMsg = "";

    private int row=0;
}
