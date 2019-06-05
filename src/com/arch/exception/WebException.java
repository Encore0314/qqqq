package com.arch.exception;

import com.arch.basebean.*;
import com.arch.util.SysConst;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class WebException extends Exception {

    Throwable myException;
    private int errorCode;
    private String sql = "";
    private String faultmsg = "";
    private String errorPlace = "";
    private ExceptionMessage em = null;

    public WebException() {
    }

    public WebException(String s) {
        super(s);
    }

    public WebException(Exception ex) {
        super(ex.toString());
    }

    public WebException(String ex, String method) {
        super(ex);
        this.errorPlace = method;
    }

    public WebException(String ex, ExceptionMessage em) {
        super(ex);
        this.em = em;
    }

    public WebException(String s, Throwable ex) {
        super(s);
        this.myException = ex;
    }

    public void printStackTrace() {
        SysConst.trace("WebException:" + this.toString());
        if (myException != null) {
            myException.printStackTrace();
        }
    }

    public WebException(int errorCode, String msg) {
        super(msg);
        this.errorCode = errorCode;
    }

    public WebException(int errorCode, String msg, Throwable e) {
        super(msg);
        this.errorCode = errorCode;
        this.myException = e;
    }

    public int getErrorCode() {
        return this.errorCode;
    }

    public String getSql() {
        return sql;
    }

    public String getFaultmsg() {
        return faultmsg;
    }

    public String getErrorPlace() {
        return errorPlace;
    }

    public ExceptionMessage getEm() {
        return em;
    }

}
