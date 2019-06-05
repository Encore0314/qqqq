package com.arch.webcontroller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.arch.event.*;
import com.arch.util.*;
import com.arch.initfunmapping.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class ViewDispatchServlet extends HttpServlet {
    private static final String CONTENT_TYPE = "text/html; charset=utf-8";
    private ServletContext servletcontext;

    public void init() throws ServletException {
    }

    //Process the HTTP Get request
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        doPost(request, response);
    }

    //Process the HTTP Post request
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        String key = null;
        EventResponse result = (EventResponse) request.getAttribute("result");
        SysConst.trace("------------- Response result information: ");
        SysConst.trace("Result flag=" + result.isSuccessFlag());
        if (result.isSuccessFlag()) {
            SysConst.trace("Message=" + result.getSuccessMsg());
        } else {
            SysConst.trace("Message=" + result.getFaultMsg());
        }
        if (result.getFunctionID().indexOf(".xml")==-1) {
            //老架构的跳转方式
            key = this.processRequest(request);
            this.dispatch(request, response, key);
        } else { //新架构的跳转方式
            this.dispatch(request, response);
        }

    }

    /**
     *
     * @param request 传入HttpServletRequest请求
     * @return 返回String
     * @throws ServletException
     */

    private String processRequest(HttpServletRequest request) throws
            ServletException {

        RequestHead head =
                (RequestHead) request.getAttribute(SysConst.REQ_HEAD);
        String functionid = head.getFunctionID();
        EventResponse result = (EventResponse) request.getAttribute("result");
        if (result.isSuccessFlag()) {
            return functionid + ".Success";
        } else {
            return functionid + ".Fault";
        }
    }

    /**
     *
     * @param request 传入HttpServletRequest请求
     * @param response 传入HttpServletResponse请求
     * @param key 根据此key从viewmap缓存中获取对应视图URL
     * @throws ServletException
     * @throws IOException
     */
    private void dispatch(HttpServletRequest request,
                          HttpServletResponse response,
                          String key) throws ServletException, IOException {
        //老架构的跳转方式
        //ViewMapping在MainServlet初始化是进行init
        ViewMapping viewMappings = (ViewMapping) getServletContext().
                                   getAttribute(SysConst.VIEW_MAPPINGS);
        String urlpattern = (String) viewMappings.getView(key);
        if (urlpattern == null) {
            urlpattern = "/globe/struct/struct_fault.jsp";
            EventResponse eventResponse = new EventResponse();
            eventResponse.setFaultMsg("未找到和" + key +
                                      "相对应的页面，默认是用架构的struct_fault.jsp文件！");
            eventResponse.setSuccessFlag(false);
            request.setAttribute("result", eventResponse);
        }
        SysConst.trace("UrlPattern=" + urlpattern);
        this.getServletContext()
                .getRequestDispatcher(urlpattern).forward(request, response);
    }

    /**
     *
     成功时走STRUCT_SUCCESS.jsp，失败时STRUCT_FAULT.jsp
         新架构的跳转方式
     统一的成功和失败处理
     */
    private void dispatch(HttpServletRequest request,
                          HttpServletResponse response
            ) throws ServletException, IOException {
        EventResponse result = (EventResponse) request.getAttribute("result");
        String urlpattern = "";
        if (result.isSuccessFlag()) {
            urlpattern = result.getSuccessPage();
            //如果要提示成功信息或是要返回或是设定了target，则要到success页面里提示跳转
            if (!result.getSuccessMsg().equals("") ||
                    result.getSuccessPage().equals("") ||
                    urlpattern.indexOf("?") != -1) {
                    urlpattern = "/globe/struct/struct_success.jsp";
                } 
        } else {
        	if(result.getFaultPage()==null||result.getFaultPage().equals("")){
            urlpattern = SysConst.BASE_DIRECTORY+"globe/struct/struct_fault.jsp";
        	}else{
        		urlpattern=result.getFaultPage();
        	}
        }
         
        SysConst.trace("UrlPattern=" + urlpattern);

        this.getServletContext()
                .getRequestDispatcher(urlpattern).forward(request, response);
        
    }


    public void destroy() {
        super.destroy();
    }

}
