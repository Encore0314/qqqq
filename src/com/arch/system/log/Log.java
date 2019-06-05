package com.arch.system.log;

public class Log {
    private String userid = "";
    private String ip = "";
    private String fid = "";
    private String sql = "";
    private String flag = "";
    private String message = "";
    public String getUserid() {
        return userid;
    }

    public String getSql() {
        return sql;
    }

    public String getMessage() {
        return message;
    }

    public String getIp() {
        return ip;
    }

    public String getFlag() {
        return flag;
    }

    public String getFid() {
        return fid;
    }

    public void setFid(String fid) {
        this.fid = fid;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

}
