package com.arch.exception;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class NotFindException extends WebException{
  public NotFindException(String msg)
   {
     super(100204000,msg);


   }

   public NotFindException(String msg,Throwable myException)
   {
     super(100204000,msg,myException);
   }

}
