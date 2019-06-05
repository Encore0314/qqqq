package com.arch.basebean;


import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.arch.dbaccess.PrepareSql;
import com.arch.event.*;
import org.jdom.*;

import com.arch.util.FormBean;
import com.arch.util.JedisPoolClient;
import com.arch.util.RedisUtil;
import com.arch.util.Tools;
import com.arch.exception.*;

import org.jdom.*;
import org.jdom.input.*;
import java.io.File;
import com.arch.util.SysConst;

import redis.clients.jedis.Jedis;
import sun.jdbc.rowset.CachedRowSet;
import org.json.JSONObject;

public class ProcessXml {
    public ProcessXml() {
    }

   
    private Element handleXml = null;
    private Event event = null;
    public String UID = "";
 
    Element other = null;
    private String xmlPath = "";
    public void setHandleXml(Element handleXml) {
        this.handleXml = handleXml;
    }
    public void setXmlPath(String xmlPath) {
        this.xmlPath = xmlPath;
    }

    
    public void setEvent(Event event) {
        this.event = event;
    }

    public Operation[] readXml() throws WebException {
       
        Operation[] operation = null;
        boolean existUID = false;
        Document xmlDoc = null;
        SAXBuilder builder = new SAXBuilder();
        try {
            
            System.out.print("begin--- reamXml()");
            xmlDoc = builder.build(new File(this.xmlPath));
            SysConst.trace("build xml success!");
          
            if (xmlDoc.getDocType() == null) {
                throw new WebException("错误代码：s000004");
            }
            String systemId = xmlDoc.getDocType().getSystemID();
  
            if (systemId == null) {
                throw new WebException("错误代码：s000005");
            }
      
            if (!systemId.startsWith("..\\")) {
                throw new WebException("错误代码：s000006");
            }
            Element contentXml = xmlDoc.getRootElement();
            List handleListXml = contentXml.getChildren();
            Element handleXml = null;
            
           
            for (int i = 0; i < handleListXml.size(); i++) {
                handleXml = (Element) handleListXml.get(i);
                if (handleXml.getAttributeValue("UID").equals(this.UID)) {
                    existUID = true;
                    break;
                }
            }
 
            if (!existUID) {
                throw new WebException("错误代码：s000007");
            }            
            
            Element otherXml = handleXml.getChild("Other");
            if (otherXml == null) {
                throw new WebException("错误代码：s000008");
            }
            this.setOther(otherXml);
          

            List operatonListXml = handleXml.getChildren("Operation");
            operation = new Operation[operatonListXml.size()];
            Element operationXml = null;
           
            
            HashMap fieldt=null;
            List fieldListXml=null;
            StringBuffer sql=new StringBuffer();
            StringBuffer expectRows=new StringBuffer();
            int maxrow=1,k;
            Element fieldXml;
            String[] inputvalue;
		    HashMap field;
           
            for (int i = 0; i < operatonListXml.size(); i++) {
            	maxrow=1;
                operation[i] = new Operation();
                operationXml = (Element) operatonListXml.get(i);
                 fieldListXml = operationXml.getChildren("Field");
                 field = new HashMap();
                 sql.delete(0, sql.length());
                 sql.append(operationXml.getAttributeValue("Sql"));
                if (sql == null) {
                    throw new WebException("UID=" +
                            this.UID + "的第" + (i + 1) +
                            "错误代码：s000009");
                }
                
                expectRows.delete(0, expectRows.length());
                expectRows.append(operationXml.getAttributeValue(
                        "ExpectRows"));
                try {
                   
                    if (!expectRows.toString().equals("null")) {
                        if (!expectRows.toString().trim().equals(">0")) {
                            Integer.parseInt(expectRows.toString());
                        }
                        operation[i].setExpectRows(expectRows.toString());
                    }}
                catch (Exception e) {
                    throw new WebException("UID=" +
                            this.UID + "的第" + (i + 1) +
                            "错误代码：s0000010");
                }
                
                operation[i].setExpectFaultMsg(operationXml.getAttributeValue(
                        "ExpectFaultMsg"));
              
                for(int m=0;m<fieldListXml.size();m++){
                	fieldXml = (Element) fieldListXml.get(m);
                	if(((String[])this.event.getBody().get(fieldXml.getText()))!=null&&((String[])this.event.getBody().get(fieldXml.getText())).length>maxrow)
                 maxrow=((String[])this.event.getBody().get(fieldXml.getText())).length;
                }
                for (int j = 0; j < fieldListXml.size(); j++) {

                   // field[j] = new Field();
                    fieldXml = (Element) fieldListXml.get(j);
                   // field[j].setFieldName(fieldXml.getText());
                   // if(this.event.getBody().get(fieldXml.getText())==null){
                   // 	inputvalue=new String[1];
                   // 	inputvalue[0]="";
                   // }else{
                   // inputvalue=(String[])this.event.getBody().get(fieldXml.getText());
                  //  }
                   // field[j].setFieldValue(inputvalue);
                    
                    if(((String[])this.event.getBody().get(fieldXml.getText()))!=null){
                        inputvalue=((String[])this.event.getBody().get(fieldXml.getText())).clone();
                        }else{
                        	inputvalue=null;
                        }
                    if(inputvalue==null){
                    	inputvalue=new String[maxrow];
                    	for(k=0;k<inputvalue.length;k++){
                    	inputvalue[k]="";
                    	}
                    }
                    for(k=0;k<inputvalue.length;k++){
                        if((inputvalue[k]==null||inputvalue[k].equals(""))&&fieldXml.getAttributeValue(
                        "Sequences")!=null){
                          //  field[j].setSequences(fieldXml.getAttributeValue(
                           // "Sequences"));
                            
                            	inputvalue[k]=FormBean.getRandom(20);
                            }
                        }  
                    for(k=0;k<inputvalue.length;k++){
                        if((inputvalue[k]==null||inputvalue[k].equals(""))&&fieldXml.getAttributeValue(
                        "DefaultValue")!=null){
               // field[j].setDefaultValue(fieldXml.getAttributeValue(
                       // "DefaultValue"));
                  
                	  
                		  inputvalue[k]=fieldXml.getAttributeValue(
                          "DefaultValue");
                	  
                  }
                        }           
                        
                        if(fieldXml.getAttributeValue("SValue")!=null){
                        	
                        	JSONObject user =new JSONObject(RedisUtil.getString(event.getToken()));
                        	
                        	if(user.getString(fieldXml.getAttributeValue("SValue"))==null&&fieldXml.getAttributeValue(
                            "DefaultValue")==null){
                        		throw new WebException("错误代码：未登陆或长时间未操作！");
                        	}
                        
                           // inputvalue=new String[1];
                        	for(k=0;k<inputvalue.length;k++){
                            inputvalue[k]=(String)user.getString(fieldXml.getAttributeValue("SValue"));
                        	}
                        }   

                    

                    
                  //  field[j].setCheck(fieldXml.getAttributeValue("Check"));
                    if(fieldXml.getAttributeValue("Check")!=null){
                  
                    	if(fieldXml.getAttributeValue("Check").equals("Rand")){

                            for(k=0;k<inputvalue.length;k++){
                          	  if(!inputvalue[k].equals(this.event.getRand())){
                          		 throw new WebException("验证码输入错误！");
                          	  }
                            }
                         
                    	}else{

                            Pattern p = Pattern.compile(fieldXml.getAttributeValue("Check").split("%")[1]);  
                            

                            for(k=0;k<inputvalue.length;k++){
                            	try{
                                Matcher m = p.matcher(inputvalue[k]);  
                                
                                 m.matches();
                            	}catch(Exception e){
                          		  throw new WebException(fieldXml.getAttributeValue("Check").split("%")[0]+"�������");
                            	}
                          	  
                            }
                    	}
              
            }                    

                    
                    if(Boolean.valueOf(Tools.nvl(fieldXml.
                            getAttributeValue(
                                    "Encrypt"), "false"))){
                       // field[j].setEncrypt(Boolean.valueOf(Tools.nvl(fieldXml.
                         //       getAttributeValue(
                                  //      "Encrypt"), "false")));
                        for(k=0;k<inputvalue.length;k++){
                        	inputvalue[k]=Tools.encrypt(inputvalue[k]);
                        }
                    }


                    if(fieldXml.getAttributeValue(
                    "OtherOperation")!=null){
                   // field[j].setOtherOperation(fieldXml.getAttributeValue(
                   // "OtherOperation"));
                    if(fieldXml.getAttributeValue(
                    "OtherOperation").indexOf("operation")>=0){
                    	fieldt=(HashMap)operation[Integer.parseInt(fieldXml.getAttributeValue(
                        "OtherOperation").substring(fieldXml.getAttributeValue(
                        "OtherOperation").indexOf("operation")+9))-1].getField();
                    	
                    		
                    	inputvalue=(String[])fieldt.get(fieldXml.getText());
                    	
                    	}
                    }
                    
                    
                    
                    
                    if(fieldXml.getAttributeValue(
                    "QueryValue")!=null){
                    	int t=0,tt=0;
                    	while((t=sql.indexOf(":"+fieldXml.getText(),tt))>=0&&PrepareSql.isEnd(sql.charAt(t+fieldXml.getText().length()+1))){
                    		tt=t+fieldXml.getText().length()+1;
                    		if(!inputvalue[0].equals("")){
                    			sql.replace(t,tt,fieldXml.getAttributeValue("QueryValue"));
                    		}else{
                    			sql.replace(t,tt,"1=1");
                    		}
                    		tt=t+fieldXml.getAttributeValue("QueryValue").length();
                    	}
                    }
                    		

                    if(fieldXml.getAttributeValue(
                    "OrderBy")!=null&&fieldXml.getAttributeValue(
                    "OrderBy").equals("1")){
                    	int t=0,tt=0;
                    	while((t=sql.indexOf(":"+fieldXml.getText(),tt))>=0&&PrepareSql.isEnd(sql.charAt(t+fieldXml.getText().length()+1))){
                    		tt=t+fieldXml.getText().length()+1;
                    	
                    				if(!inputvalue[0].equals("")){
                    					sql.replace(t,tt,inputvalue[0]);
                    	
                    			}else{
                    				sql.replace(t,tt,"'1'");
                    					
                    			}
                    				tt=t+fieldXml.getAttributeValue("OrderBy").length();
                    			}
                    	}
                    field.put(fieldXml.getText(), inputvalue);

            }
                operation[i].setField(field);
                operation[i].setRow(maxrow);
                operation[i].setSql(sql.toString());
                }
            return operation;
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "ProcessXml.readXml()" +
                                   e.getErrorPlace());
        }

        catch (Exception e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "ProcessXml.readXml()");
       }
        finally{
           
         
        }

    }


    public Element getOther() {
        return other;
    }

    public String getUID() {
        return UID;
    }

    public void setOther(Element other) {
        this.other = other;
    }

    public void setUID(String UID) {
        this.UID = UID;
    }
    private String getParamName(String name, String value) throws
    WebException {
int index = value.indexOf(PrepareSql.VAR_CHAR);
String tempStr = "";
try {
    if (index == -1) {
    	 throw new WebException("错误代码：s0000016"+name);
    } while ((index < value.length()) &&
             !PrepareSql.isEnd(value.charAt(index))) {
        tempStr = tempStr + value.charAt(index);
        index++;
    }
} catch (WebException e) {
    throw new WebException(e.getMessage(),
                           "==>" + "BaseDBImpl.getParamName()" +
                           e.getErrorPlace());
} catch (Exception e) {
    throw new WebException(e.getMessage(),
                           "==>" + "BaseDBImpl.getParamName()");
}
return tempStr;
}
}
