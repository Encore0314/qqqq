package com.arch.event;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class EventResponse {
    private Object body = null;
    private Object originBody = null;
    private Object paramBody = null;
    private Object conditionBody = null;
    private String functionID = "";
    private String errorCode = "";
    private String faultMsg = "";
    private String successMsg = "";
    private boolean successFlag = true;
    private String successPage = "";
    private String faultPage = "";
    private String sql = "";
    //设置跳转的目标target
    private String successTarget = "";
    private String faultTarget = "";
    private int operationlength=0;
    private String rurl="";
    private String token="";
    
    public EventResponse() {
    }
   
    public void setRurl(String rurl) {
        this.rurl = rurl;
    }   
    public String getRurl() {
        return rurl;
    }    
    public void setBody(Object body) {
        this.body = body;
    }

    public Object getBody() {
        return body;
    }

    public void setSuccessFlag(boolean successFlag) {
        this.successFlag = successFlag;
    }

    public boolean isSuccessFlag() {
        return successFlag;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }


    public String getFunctionID() {
        return functionID;
    }

    public void setFunctionID(String functionID) {
        this.functionID = functionID;
    }

    public Object getParamBody() {
        return paramBody;
    }


    public Object getConditionBody() {
        return conditionBody;
    }

    public Object getOriginBody() {
        return originBody;
    }

    public String getSuccessPage() {
        return successPage;
    }

    public String getSuccessMsg() {
        return successMsg;
    }

    public String getFaultPage() {
        return faultPage;
    }

    public String getFaultMsg() {
        return faultMsg;
    }

    public String getFaultTarget() {
        return faultTarget;
    }

    public String getSuccessTarget() {
        return successTarget;
    }

    public String getSql() {
        return sql;
    }

    public void setParamBody(Object paramBody) {
        this.paramBody = paramBody;
    }


    public void setConditionBody(Object conditionBody) {
        this.conditionBody = conditionBody;
    }

    public void setOriginBody(Object originBody) {
        this.originBody = originBody;
    }

    public void setSuccessPage(String successPage) {
        this.successPage = successPage;
    }

    public void setSuccessMsg(String successMsg) {
        this.successMsg = successMsg;
    }

    public void setFaultPage(String faultPage) {
        this.faultPage = faultPage;
    }

    public void setFaultMsg(String faultMsg) {
        this.faultMsg = faultMsg;
    }

    public void setFaultTarget(String faultTarget) {
        this.faultTarget = faultTarget;
    }

    public void setSuccessTarget(String successTarget) {
        this.successTarget = successTarget;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }
    public void setOperationlength(int operationlength) {
        this.operationlength = operationlength;
    }
    public int getOperationlength() {
        return operationlength;
    }
    public void setToken(String token) {
        this.token = token;
    }
    public String getToken() {
        return token;
    }    
}
