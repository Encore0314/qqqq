package com.arch.webcontroller;

import javax.servlet.http.*;
import com.arch.util.*;

import java.util.List;
import java.util.Iterator;
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class HeadParser {
    public HeadParser() {
    }

    public RequestHead parserHead(HttpServletRequest request) {
        RequestHead reqHead = new RequestHead();
        String checkValue = "";
        String functionId = "";
        String contentType = request.getContentType();
        if ((contentType != null) &&
            contentType.startsWith("multipart/form-data")) {

//Create a new file upload handler
 /*ServletFileUpload upload = new ServletFileUpload();

 try {
     List items = upload.parseRequest(request);
     Iterator iterator = items.iterator();
     while(iterator.hasNext()){
         FileItem item = (FileItem)iterator.next();
         if(item.isFormField()){
             String fieldName = item.getFieldName();
             String value = item.getString();
             if(fieldName.equals(SysConst.PAR_FUNCTIONID)){
                 functionId = value;
             }
             if(fieldName.equals("checkvalue")){
                 checkValue = value;
             }
         }
     }
 } catch (Exception e){
     e.printStackTrace();
 }
*/
        }
        else{
            if (request.getParameter(SysConst.PAR_FUNCTIONID) != null) {
                functionId = request.getParameter(SysConst.PAR_FUNCTIONID);
            }
            if (request.getParameter("checkvalue") != null) {
                checkValue = request.getParameter("checkvalue");
            }
        }
        reqHead.setSessionID(checkValue);
        reqHead.setFunctionID(functionId);
        reqHead.setCurIP(request.getRemoteAddr());
        return reqHead;
    }

}
