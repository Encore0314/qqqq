package com.arch.initfunmapping;

import java.io.*;
import java.util.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class ActionMapping implements Serializable{
  private HashMap functionMappings;
  private HashMap transMappings;

  public ActionMapping(HashMap functionMappings,HashMap transMappings) {
      this.functionMappings = functionMappings;
      this.transMappings = transMappings;
  }

  public String getAction(String functionID) {
      if(this.functionMappings == null)
          return null;
      return (String)functionMappings.get(functionID);
  }

  public String getTransAction(String functionID){
      if(this.transMappings == null)
          return null;
      return (String)this.transMappings.get(functionID);
  }

  public String toString(){
      StringBuffer buffer = new StringBuffer();
      buffer.append(this.getClass());
      buffer.append("["+this.hashCode()+"] @");
      buffer.append(" FunctionMapping ={");
      java.util.Iterator key = functionMappings.keySet().iterator();
      while(key.hasNext()){
          Object name = key.next();
          Object value = functionMappings.get(name);
          buffer.append(name+":"+value+" ");
      }
      buffer.append("} ActionMapping ={");
      java.util.Iterator key2 = transMappings.keySet().iterator();
      while(key.hasNext()){
          Object name = key2.next();
          Object value = transMappings.get(name);
          buffer.append(name+":"+value+" ");
      }
      buffer.append("}");
      return buffer.toString();
  }
}
