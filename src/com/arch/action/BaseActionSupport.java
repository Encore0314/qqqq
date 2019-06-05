package com.arch.action;

import javax.servlet.*;
import javax.servlet.http.*;
import com.arch.event.*;
import com.arch.webcontroller.RequestHead;
import com.arch.system.log.*;
import com.arch.util.SysConst;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class BaseActionSupport implements BaseAction {
    protected ServletContext ctx;
    protected HttpSession session;
    protected SystemLogDAOImpl dao = null;

    public void init(ServletContext context, HttpSession session) {
        this.ctx = context;
        this.session = session;
    }

    public void doStart() throws Exception {
    }

    public void doStart(Event event) throws Exception {
    }

    public EventResponse perform(Event event) throws Exception {
        return null;
    }

    public Object processEvent(Event evt) throws Exception {
        return null;
    }

    public void doEnd(EventResponse eventResponse) throws Exception {}

    public void doEnd(EventResponse eventResponse, RequestHead head) throws
            Exception {
    }

    public void doEnd(EventResponse eventResponse, String ip, String userid) {
        Log log = new Log();
        String sqlstr="",msgS="",msgF="";
        try {
            if(eventResponse.getSuccessMsg().length()>1000) msgS=eventResponse.getSuccessMsg().substring(1,2000);
            else
                msgS=eventResponse.getSuccessMsg();
            if(eventResponse.getFaultMsg().length()>1000) msgF=eventResponse.getFaultMsg().substring(1,2000);
            else
                msgF=eventResponse.getFaultMsg();
            if(eventResponse.getSql().length()>1000) sqlstr=eventResponse.getSql().substring(1,2000);
            else
                sqlstr=eventResponse.getSql();

            log.setUserid(userid);
            log.setSql(sqlstr);
            if (eventResponse.isSuccessFlag()) {
                log.setMessage(msgS);
            } else {
                log.setMessage(msgF);
            }
            log.setIp(ip);
            log.setFlag(String.valueOf(eventResponse.isSuccessFlag()));
            log.setFid(eventResponse.getFunctionID());
            SystemLogDAOImpl sl = new SystemLogDAOImpl();
            sl.addLog(log);
            log=null;
 sqlstr=null;
 msgS=null;
 msgF=null;

        } catch (Exception e) {
            //这个异常应该是不会发生
            SysConst.trace(
                    "!!!Add system log fail,errors occur in baseActionSupport.doEnd().Cause:" +
                    e.getMessage());
        }
        finally{

        }
    }

    public void doLastEnd(EventResponse eventResponse) throws Exception {}
}
