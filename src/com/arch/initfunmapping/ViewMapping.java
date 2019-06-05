package com.arch.initfunmapping;

import java.util.*;
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class ViewMapping {
  private HashMap viewMappings = new HashMap(10);

  public ViewMapping(HashMap viewMappings) {
    this.viewMappings = viewMappings;
  }

  public String getView(String functionID) {
      if(this.viewMappings == null)
          return null;
      return (String)viewMappings.get(functionID);
  }

  public HashMap getViewMapping(){
    return viewMappings;
  }

}
