package com.arch.initfunmapping;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class ViewMappingDAOFactory {
  public ViewMappingDAOFactory() {
  }
  public static ViewMappingDAO getDAO() {
    ViewMappingDAO dao = new ViewMappingDAOImpl();
    return dao;
  }

}
