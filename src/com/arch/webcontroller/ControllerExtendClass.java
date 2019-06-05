package com.arch.webcontroller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.*;
import javax.servlet.http.*;
import com.arch.util.*;
import java.sql.*;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2006</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class ControllerExtendClass {
    public ControllerExtendClass() {
    }

    //处理fid的类型，如果是形如Fxx.xx.xx.xx的则给赋old标记，否则赋new标记
    public static void divisionFid(HttpServletRequest request) {
        String fid = Tools.nvl(request.getParameter(SysConst.PAR_FUNCTIONID));
        if (fid.indexOf(".xml") != -1) {
            request.setAttribute(SysConst.GLOBE_FLAG, "new");
        } else {
            request.setAttribute(SysConst.GLOBE_FLAG, "old");
        }
    }

    //在init actionmapping前，对全局存放function的文件function.xml进行内容验证
    public static boolean checkFunctionXmlFile(String path) {
        return true;
    }

    //如果在actionMapping里找不到这个actionName，则在function.xml找，如果找到将它append到actionMapping里
    public static String extendReadFunctionFile(String path) {
        return "";
    }

    //在系统启动时，检查数据库联接是否正确。
    public static boolean initDataBaseConnection() {
        DBTransUtil db = new DBTransUtil();
        SysConst.trace("2:System begin check the database connection……");
        SysConst.trace("JNDI=" + SysConst.JNDI);
        Connection con = null;
        try {
            con = db.getConnection();
            if (con != null) {
                SysConst.trace("Complete check the connection successful.");
                con.close();
                return true;
            } else {
                SysConst.trace(
                        "Errors occur in  checking the database connection.");
                return false;
            }
        } catch (Exception e) {
            SysConst.trace(
                    "Can not open or close the database connection,cause:"
                    );
            SysConst.trace(e.getMessage());
            return false;
        }
    }
}
