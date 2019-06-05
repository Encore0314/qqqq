package com.arch.exception;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class BussinessProcessException extends WebException{
    public BussinessProcessException() {
      super();
    }
    public BussinessProcessException(String msg){
       super(msg);
    }
}
