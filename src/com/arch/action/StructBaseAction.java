package com.arch.action;

import com.arch.event.*;
import com.arch.basebean.*;
import java.util.HashMap;
import com.arch.dbaccess.*;
import com.arch.exception.WebException;
import com.arch.util.*;

import java.sql.*;
/**
 * <p>Title: </p>
 *
 * <p>Description: 架构的action类</p>
 *
 * <p>Copyright: Copyright (c) 2006</p>
 * 
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class StructBaseAction extends BaseActionSupport {
    public StructBaseAction() {
    }

    public EventResponse perform(Event event) throws WebException, Exception {
        EventResponse result = new EventResponse();
        HashMap hashBody = new HashMap();
        HashMap hashOrigin = new HashMap();
        //sb用来存储操作的sql语句，用于后面记录系统日志
        StringBuffer sb = new StringBuffer();
        ProcessXml xml = new ProcessXml();
        xml.setUID(event.getUID());
        xml.setEvent(event);
        xml.setXmlPath(event.getXmlPath());
        //存储xml中设置的页面跳转信息
        Other other = null;
        OracleRowSet[] ors = null;
        Connection con = null;
        DBTransUtil dbUtil = new DBTransUtil();
        String rand = event.getRand();
        Savepoint sp=null;
        try {
            //处理xml文件，将所有信息都读到operation对象里
           // System.out.print("begin---readXml");
        	
        	Operation[] operation = xml.readXml();
            SysConst.trace("end--- readXml()");
        	other = new Other(xml.getOther(), xml.getUID());
            if (other == null) {
                throw new WebException("Other对象为null，无法继续!");
            }            
            
            con = dbUtil.getConnection();
            con.setAutoCommit(false);
            sp=con.setSavepoint();
             //BaseDBImpl bdb=null;/
            StructDAOImpl sdao=null;
            ExtendLog el=null;
            String expectFaultMsg=null;
            String tempMsg=null;
            //bdb = new BaseDBImpl();
            sdao = new StructDAOImpl();
            for (int i = 0; i < operation.length; i++) {
                 

                //开始操作数据库
                SysConst.trace("begin execute processDB...");
                el = sdao.processDB(con,operation, i);
                SysConst.trace("execute database operation success!");
                //操作数据库后返回的结果，只有查询时有数据，其他操作ors=null
                ors = el.getOrs();
                sb.append(el.getSql());
                //检查预期的影响行数是否正确
                if (!checkExpectRows(el.getRows(), operation[i].getExpectRows())) {
                     expectFaultMsg = "";
                      tempMsg= "";
                    
                    other.setFaultMsg(operation[i].getExpectFaultMsg());
                    throw new WebException("");
                }
                hashBody.put("operation" + (i + 1), ors);
                //保留原来所有字段的值，以备后面使用
                hashOrigin.put("operation" + (i + 1), operation[i].getField());

                el=null;
            }
            con.commit();
            result.setOperationlength(operation.length);
            operation=null;
            // bdb=null;
             sdao=null;

             el=null;
             expectFaultMsg=null;
             tempMsg=null;
        } catch (WebException e) {
        	if(con!=null){
        	con.rollback(sp);
        	con.close();
        }
            result.setSuccessFlag(false);
            ExceptionMessage em = new ExceptionMessage();
            em.setSql(sb.toString());
            em.setFaultMsg(other == null ? e.getMessage() : other.getFaultMsg()+"--"+e.getMessage());
            em.setFaultPage(other == null ? SysConst.BASE_DIRECTORY+"globe/struct/struct_fault.jsp" :
                other.getFaultPage());
            em.setFaultTarget(other == null ? "location" : other.getFaultTarget());
            em.setSuccessPage(other == null ? "" :
                other.getSuccessPage());
            em.setSuccessTarget(other == null ? "location" : other.getSuccessTarget());

            em.setSuccessMsg(other == null ? "" : other.getSuccessMsg());
            em.setErrorPlace("StructBaseAction.perform()" + e.getErrorPlace());
            throw new WebException(e.getMessage(), em);
        } catch (Exception e) {
            result.setSuccessFlag(false);
            ExceptionMessage em = new ExceptionMessage();
            em.setSql(sb.toString());
            em.setFaultMsg(other == null ? e.getMessage() : other.getFaultMsg()+"--"+e.getMessage());
            em.setFaultPage(other == null ? SysConst.BASE_DIRECTORY+"globe/struct/struct_fault.jsp" :
                other.getFaultPage());            
            em.setFaultTarget(other == null ? "location" : other.getFaultTarget());
            em.setSuccessPage(other == null ? "" : other.getSuccessPage());
            em.setSuccessTarget(other == null ? "location" : other.getSuccessTarget());

            em.setSuccessMsg(other == null ? "" : other.getSuccessMsg());
            em.setErrorPlace("StructBaseAction.perform()");
            throw new WebException(e.getMessage(), em);
        }

        finally {
            result.setSql(sb.toString());
            result.setFunctionID(event.getFunctionID());
            result.setSuccessMsg(other == null ? "" : other.getSuccessMsg());
            result.setBody(hashBody);
            result.setOriginBody(hashOrigin);
            if(con!=null)
              con.close();
        }
        result.setSuccessPage(other.getSuccessPage(hashOrigin));
        result.setSuccessTarget(other.getSuccessTarget());
        result.setFaultPage(other.getFaultPage(hashOrigin));
        result.setFaultTarget(other.getFaultTarget());
        result.setErrorCode("");
        hashBody = null;
       hashOrigin = null;
       sb = null;
       xml = null;
       other = null;
       ors = null;

       dbUtil = null;

        return result;
    }

    //检查预期的影响行数是否正确
    private boolean checkExpectRows(int rows, String expectRows) {
        if (expectRows == "") {
            return true;
        }
        if (expectRows.trim().equals(">0")) {
            if (rows > 0) {
                return true;
            } else {
                return false;
            }
        } else if (Integer.parseInt(expectRows) == rows) {
            return true;
        } else {
            return false;
        }
    }
}
