package com.arch.util;

import javax.servlet.http.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class GlobalServlet extends HttpServlet {

  /**
   * Initializes the servlet.
  **/
  public void init(javax.servlet.ServletConfig conf)
    throws javax.servlet.ServletException
  {
    super.init(conf);

    //可以增加全局参数在此处
    SysConst.JNDI = getInitParameter("JNDI");
    SysConst.BASE_DIRECTORY = getInitParameter("BASE_DIRECTORY");
    SysConst.VERSION = getInitParameter("VERSION");
    SysConst.EMAILQUEUE    = getInitParameter("EMAILQUEUE");
    SysConst.EQCONNFACTORY = getInitParameter("EQCONNFACTORY");
    SysConst.FORMACTION = SysConst.encrypt(getInitParameter("FORMACTION"),"asdfsdfa");
    SysConst.CHARSET = getInitParameter("CHARSET");
    SysConst.DBTYPE = getInitParameter("DBTYPE");
    SysConst.UPLOAD_PATH_TEMP = getInitParameter("UPLOAD_PATH_TEMP");
    SysConst.UPLOAD_PATH = getInitParameter("UPLOAD_PATH");
    String logWrite = getInitParameter("LOGWRITE");
    String canWrite = getInitParameter("CANWRITE");

    SysConst.FSQL = getInitParameter("Fsql");
    if(canWrite==null||canWrite.equals("")){
      canWrite = "false";
    }
    if(canWrite.equals("true")){
      SysConst.CANWRITE = true;
    }
    else{
      SysConst.CANWRITE = false;
    }
    if(logWrite!=null&&logWrite.equals("true")){
        SysConst.LOGWRITE = true;
      }
      else{
        SysConst.LOGWRITE = false;
      }    
  }

}
