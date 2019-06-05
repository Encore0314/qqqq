package com.arch.basebean;

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
public class ExceptionMessage {
    public ExceptionMessage() {
    }

    public static String getExceptionMsg(int code, String msg1) {
        String resultMsg = "";
        switch (code) {
        case 1:
            break;
        default:
            resultMsg = "操作失败！";
            break;
        }
        return resultMsg;
    }

    public String getFaultMsg() {
        return faultMsg;
    }

    public String getFaultPage() {
        return faultPage;
    }

    public String getFaultTarget() {
        return faultTarget;
    }

    public String getSql() {
        return sql;
    }

    public String getSuccessMsg() {
        return successMsg;
    }

    public String getSuccessPage() {
        return successPage;
    }

    public String getSuccessTarget() {
        return successTarget;
    }

    public String getErrorPlace() {
        return errorPlace;
    }

    public void setSuccessTarget(String successTarget) {
        this.successTarget = successTarget;
    }

    public void setSuccessPage(String successPage) {
        this.successPage = successPage;
    }

    public void setSuccessMsg(String successMsg) {
        this.successMsg = successMsg;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public void setFaultTarget(String faultTarget) {
        this.faultTarget = faultTarget;
    }

    public void setFaultPage(String faultPage) {
        this.faultPage = faultPage;
    }

    public void setFaultMsg(String faultMsg) {
        this.faultMsg = faultMsg;
    }

    public void setErrorPlace(String errorPlace) {
        this.errorPlace = errorPlace;
    }

    private String sql = "";
    private String successPage = "";
    private String successTarget = "";
    private String faultPage = "";
    private String faultTarget = "";
    private String faultMsg = "";
    private String successMsg = "";
    private String errorPlace = "";
}
