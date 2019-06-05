package com.arch.webcontroller;


import java.util.*;



public class RequestHead implements java.io.Serializable {
    private String rurl;
    private String functionID;
    private String curIP;
    private String sessionID;
    private String token;
    private HashMap user = new HashMap();

    public RequestHead() {
    }

    public String getRurl() {
        return rurl;
    }

    public HashMap getUser() {
        return user;
    }

    public String getSessionID() {
        return sessionID;
    }

    public String getFunctionID() {
        return functionID;
    }

    public String getCurIP() {
        return curIP;
    }
    public String getToken() {
        return token;
    }
    public void setCurIP(String curIP) {
        this.curIP = curIP;
    }

    public void setFunctionID(String functionID) {
        this.functionID = functionID;
    }

    public void setSessionID(String sessionID) {
        this.sessionID = sessionID;
    }

    public void setUser(HashMap user) {
        this.user = user;
    }

    public void setRurl(String rurl) {
        this.rurl = rurl;
    }
    public void setToken(String token) {
        this.token = token;
    }

}
