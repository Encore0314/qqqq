package com.arch.event;


import java.util.*;
import com.arch.util.SysConst;
import com.arch.util.Tools;

import org.jdom.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class Event implements java.io.Serializable {

    private java.util.HashMap body;
    private String functionID;
    private HashMap user = new HashMap();
    private String xmlPath = "";
    private Element handlexml = null;
    private String UID = "";
    private String ip = "";
    private String userId = "";
    private String token = "";
    private String struct = "";
    private String rand = ""; //随即验证
    public Event() {
    }







    public java.util.HashMap getBody() {
        return body;
    }

    public void setBody(java.util.HashMap body) {
        this.body = body;
    }

    public String getFunctionID() {
        return functionID;
    }

    public String getStruct() {
        return struct;
    }

    public void setStruct(String struct) {
        this.struct=struct;
    }

    public void setXmlPath(String xmlPath) {
        this.xmlPath = xmlPath;
    }
    public void setFunctionID(String functionID) {
        this.functionID = functionID;
    }
    public String getXmlPath() {
        return xmlPath;
    }

    public HashMap getUser() {
        return user;
    }

    public Element getHandleXml() {
        return handlexml;
    }

    public String getUserId() {
        return userId;
    }

    public String getIp() {
        return ip;
    }

    public String getUID() {
        return UID;
    }

    public String getRand() {
        return rand;
    }
   public void setUser(HashMap user) {
        this.user = user;
        this.setUserId(Tools.nvl((String) user.get(SysConst.PAR_USERID),
                                  ""));
    }

    public void setHandleXml(Element handlexml) {
        this.handlexml = handlexml;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public void setUID(String UID) {
        this.UID = UID;
    }
    public void setRand(String rand) {
        this.rand = rand;
    }
    
    public void setToken(String token) {
        this.token = token;
    }

    public String getToken() {
        return token;
    }
}
