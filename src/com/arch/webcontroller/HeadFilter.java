package com.arch.webcontroller;

import java.io.*;
import java.util.Calendar;

import javax.servlet.*;
import javax.servlet.http.*;

import com.arch.util.*;



/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class HeadFilter implements Filter {

    private FilterConfig filterConfig = null;
    private String filterFile = null;
    public void init(FilterConfig parm1) throws javax.servlet.ServletException {
        this.filterConfig = parm1;
        filterFile = filterConfig.getInitParameter("FilterFile");
    }

    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain fc) throws java.io.IOException,
            javax.servlet.ServletException {
    	
        HttpServletRequest hreq = (HttpServletRequest) req;
        HttpServletResponse hres = (HttpServletResponse) res;


      
        fc.doFilter(hreq, hres);
    }

    public void destroy() {
        this.filterConfig = null;
    }

    public FilterConfig getFilterConfig() {
        return filterConfig;
    }

    public void setFilterConfig(FilterConfig cfg) {
        filterConfig = cfg;
    }

}
