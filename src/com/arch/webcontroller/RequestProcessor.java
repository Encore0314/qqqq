package com.arch.webcontroller;

import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.arch.action.*;
import com.arch.event.*;
import com.arch.initfunmapping.*;
import com.arch.util.*;


import com.arch.exception.*;
import com.arch.basebean.*;

import redis.clients.jedis.Jedis;
import sun.jdbc.rowset.CachedRowSet;
import org.json.JSONObject;


public class RequestProcessor implements java.io.Serializable {

    private ServletContext context;
    private ServletConfig config;
    private Jedis jedis;



    public void init(ServletContext context,ServletConfig config) {
        this.context = context;
        this.config = config;

        
        
    }

    public RequestProcessor() {
    }


    public EventResponse processRequest(HttpServletRequest request,HttpServletResponse response) throws
            ServletException, java.io.UnsupportedEncodingException {
        RequestHead head =
                (RequestHead) request.getAttribute(SysConst.REQ_HEAD);


        Event event = null;
        EventResponse eventResponse = null;

        event = doRequest(request,response);
        event.setIp(head.getCurIP());
        event.setRand((String)request.getSession().getAttribute("rand"));
        event.setToken(head.getToken());
        String actionName = null;
        BaseAction action = null;
        try {
        	  String functionId = event.getFunctionID();
              event.setUser(head.getUser());
              ActionMapping actionMappings =
                      (ActionMapping) context.getAttribute(SysConst.
                      ACTION_MAPPINGS);
            
              if (functionId.indexOf(".xml")==-1) {
                 
                  actionName = actionMappings.getAction(functionId);
              }
              
              else {
                  actionName = "com.arch.action.StructBaseAction";
                  if (functionId.indexOf("@") == -1) {
                      throw new Exception("操作失败，错误代码：s000001");
                  }
                  SysConst.trace("Fid= = " + functionId);
                  functionId = request.getSession().getServletContext().getRealPath("/").replace("\\","/") +"xml/"+ functionId;
                  event.setXmlPath(functionId.substring(0, functionId.indexOf("@")));
                  event.setUID(functionId.substring(functionId.indexOf("@") + 1));
              }
              if (actionName == null) {
                 
                  actionName = ControllerExtendClass.extendReadFunctionFile(
                          SysConst.
                          FUNCTION_FILE_NAME);
                  if (actionName.equals("")) {
                      throw new Exception("操作失败，错误代码：s000002");
                  }
              }
              SysConst.trace("ActionName = " + actionName);
              SysConst.trace("Request xml file path = " + event.getXmlPath());
              SysConst.trace("Request UID = " + event.getUID());
            HttpSession httpSession = request.getSession(false);
           
            action = (BaseAction) Class.forName(actionName).newInstance();
            action.init(context, httpSession);
         
             
            eventResponse = action.perform(event);
            eventResponse.setRurl(head.getRurl());
            eventResponse.setFunctionID(event.getFunctionID());
            if (SysConst.LOGIN_FID.indexOf(event.getFunctionID())>=0) { 
                HashMap user = ((OracleRowSet[])((HashMap)eventResponse.getBody()).get("operation3"))[0].getHash();
                SysConst.trace("User login action");
                
                JSONObject jsonObject = new JSONObject(user);
                
                String token=FormBean.getRandom(40);

                RedisUtil.setString(token,30000,jsonObject.toString());

                head.setToken(token);
                String[] tt= SysConst.FSQL.split("#"); 
                String functionlist="#";
                if(tt.length>0){

            	String	sqlstr=tt[0]+"'"+user.get(tt[1])+"'"+tt[2];
            	
            	DBTransUtil dbUtil = new DBTransUtil();
            	try{
            		CachedRowSet crs=dbUtil.getResultBySelect(sqlstr);
            		crs.first();
            		for(int i=0;i<crs.size();i++){
            			functionlist=functionlist+crs.getString("loadpage")+"#";
            			crs.next();
            		}
            	}catch(Exception e){
            	}
                }
                RedisUtil.setString(token+"flist",3000, functionlist);

                eventResponse.setToken(token);
                request.getSession().setAttribute(SysConst.LOGIN_USER, user);
                request.getSession().setAttribute(SysConst.FUNCTION_LIST,functionlist);
                request.getSession().setAttribute("Token",token);
                user=null;
          }
          functionId=null;
          httpSession=null;
          actionMappings=null;
        } catch (ClassNotFoundException en) {
        	eventResponse=new EventResponse();
        	eventResponse.setRurl(head.getRurl());
            eventResponse.setSuccessFlag(false);
            eventResponse.setFaultMsg("操作失败，错误代码：s0000031");
            eventResponse.setFunctionID(event.getFunctionID());
            return eventResponse;
        } catch (WebException en) {
        	eventResponse=new EventResponse();
            eventResponse.setSuccessFlag(false);
            eventResponse.setRurl(head.getRurl());
            ExceptionMessage em = en.getEm();
          
            if (em != null && !em.getFaultMsg().trim().equals("")) {
                eventResponse.setFaultMsg(em.getFaultMsg());
                SysConst.trace("错误提示：" + en.getMessage());
            } else {
                eventResponse.setFaultMsg("错误提示：" +
                                          en.getMessage());
            }
            eventResponse.setSql(em.getSql());
            eventResponse.setFaultTarget(em.getFaultTarget());
            eventResponse.setFaultPage(em.getFaultPage());
            eventResponse.setSuccessTarget(em.getSuccessTarget());
            eventResponse.setSuccessPage(em.getSuccessPage());
            eventResponse.setSuccessMsg(em.getSuccessMsg());
            eventResponse.setFunctionID(event.getFunctionID());
            return eventResponse;
        } catch (Exception e) {
        	eventResponse=new EventResponse();
        	eventResponse.setRurl(head.getRurl());
            eventResponse.setSuccessFlag(false);
            eventResponse.setFaultMsg(e.getMessage());
            SysConst.trace("Error message=" + e.getMessage());
            eventResponse.setFunctionID(event.getFunctionID());
            
            return eventResponse;
        }

        finally {
         
        	if(SysConst.LOGWRITE){
            action.doEnd(eventResponse, event.getIp(), event.getUserId());
        	}

        }
        eventResponse.setToken(head.getToken());
        event.getBody().clear();
        event=null;
        actionName = null;
            action = null;
        return eventResponse;

    }

    private Event doRequest(HttpServletRequest request, HttpServletResponse response) throws java.io.
            UnsupportedEncodingException {
        Event event = new Event();
        HashMap<String, Object> body = new HashMap<String, Object>();
         Enumeration<?> enum1=null;

         String parName = null;
         String parValue[] = null;
        String handle=null;
        String h[]=null;
    	
        try{
            String contentType = request.getContentType();
            if ((contentType != null) &&
                contentType.startsWith("multipart/form-data")) {
              

            } else {
            	
                event.setFunctionID(request.getParameter("fid"));
                enum1 = request.getParameterNames();
                while (enum1.hasMoreElements()) {
                    parName = (String) enum1.nextElement();
                    parValue = request.getParameterValues(parName);

                    if(parName.equals("handle")){
 
                    	 handle = Azdg.decrypt(parValue[0], SysConst.FORMACTION);
                    	 h=handle.split("&");
                    	event.setFunctionID(h[0].split("=")[1]);
                    	for(int i=0;i<h.length;i++){
                    		if(h[i].split("=").length>1){
                    			String[] t=new String[1];
                    			t[0]=h[i].split("=")[1];
                    		body.put(h[i].split("=")[0],t);
                    		}else{
                    			String[] t=new String[1];
                    			t[0]="";
                    			body.put(h[i].split("=")[0],t);
                    		}
                    	}
                    }else{
                    if (parValue == null || parValue.length == 0) {
                        body.put(parName, "");
                    } else {

                            body.put(parName, parValue);
                        
                    } 

                   }
                }
            }
            
        }catch(Exception e){
        	 e.getMessage();
            }

        
        event.setBody(body);
         body = null;
         enum1=null;

        return event;
    }


    public static String asHTML(String text)  throws Exception    
    {    
        if (text == null) return "";    
        StringBuffer results = null;    
        char[] orig = null;    
        int beg = 0, len = text.length();
        //if (len> 3999) {
          //  throw new Exception("�����ı���");
       // }
        for (int i = 0; i < len; ++i)    
        {    
            char c = text.charAt(i);    
            switch (c) {    
            case 0:    
            case '&':    
            case '<':    
            case '>':    
            case '"':   
                if (results == null)   
                {   
                    orig = text.toCharArray();   
                    results = new StringBuffer(len + 10);   
                }   
                if (i > beg) results.append(orig, beg, i - beg);   
                beg = i + 1;               
                switch (c) {   
                default: // case 0:   
                    continue;   
                case '&':   
                    results.append("&amp;");   
                    break;   
                case '>':   
                    results.append("&gt;");   
                    break;   
                case '<':   
                    results.append("&lt;");   
                    break;   
                case '"':    
                    results.append("\"");    
                    break;    
                }    
                break;    
            }    
        }           
        if (results == null) return text;    
        results.append(orig, beg, len - beg);    
        return results.toString();    
    }       
}
