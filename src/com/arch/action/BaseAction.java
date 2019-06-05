package com.arch.action;

import javax.servlet.*;
import javax.servlet.http.*;
import com.arch.event.*;
import com.arch.webcontroller.RequestHead;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public interface BaseAction {

    public void init(ServletContext context, HttpSession session);

    public void doStart() throws Exception;

    public void doStart(Event ev) throws Exception;

    public EventResponse perform(Event ev) throws Exception;

    public Object processEvent(Event evt) throws Exception;

    public void doEnd(EventResponse eventResponse) throws Exception;

    public void doEnd(EventResponse eventResponse, String ip, String userid);

    public void doEnd(EventResponse eventResponse, RequestHead head) throws
            Exception;

    public void doLastEnd(EventResponse eventResponse) throws Exception;

}
