package com.arch.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class SysConst {
    //trace的开关
    public static boolean CANWRITE = true;
    //字符集
    public static String CHARSET = "GBK";
    //global全局变量
    public static String JNDI = "java:comp/env/jdbc/myDB";
    public static String VERSION = null; //系统版本号
    public static String URL_PROVIDER = "http://127.0.0.1";
    public static String INITIAL_FACTORY =
            "weblogic.jndi.WLInitialContextFactory";
    public static String ACTION_MAPPINGS = "ACTION_MAPPINGS";
    public static String VIEW_MAPPINGS = "VIEW_MAPPINGS";
    public static boolean PERFERMANCE_FLAG = true; //性能调试
    public static String EMAILQUEUE = null; //email发送Queue
    public static String EQCONNFACTORY = null; //emailQueueConnectionFactory
    public static String TRANS_LOG = "transLog";
    public static String REQ_STRING = "reqString";
    public static String FUNCTION_LIST = "functionList";
    public static String ERROR = "error";
    public static String LOGIN_USER = "curUser";
    public static String IS_LOG_OFF = "isLogoff";
    public static String NEW_LOGON = "newLogon";
    public static String REQ_HEAD = "reqHead";
    public static String ENV_HEAD = "envHead";
    public static String PAR_FUNCTIONID = "fid";
    public static String PAR_USERID = "id";
    //全局标记，=new时，用新的架构，=old时，用旧的架构
    public static String GLOBE_FLAG = "globe_flag";
    public static String BASE_DIRECTORY = "/";
    //设置登陆对应的fid
    public static String LOGIN_FID = "login.xml@f100;login.xml@f101";
    public static String FUNCTION_FILE_NAME =BASE_DIRECTORY+
            "globe/struct/function.xml";
    public static String UPLOAD_PATH_TEMP = "c:\\temp";
    public static String UPLOAD_PATH ="c:\\temp";
    public static String FORMACTION = "ddadf";
    public static String Xmldoc = "xdoc";
    public static String DBTYPE = "ORACLE";
    public static String FSQL = "";
    public static boolean LOGWRITE = true;
    public static String encrypt(String str,String key){
        String sn=key; //密钥
              int[] snNum=new int[str.length()];
              String result="";
              String temp="";

              for(int i=0,j=0;i<str.length();i++,j++){
                  if(j==sn.length())
                      j=0;
                  snNum[i]=str.charAt(i)^sn.charAt(j);
              }

              for(int k=0;k<str.length();k++){

                  if(snNum[k]<10){
                      temp="00"+snNum[k];
                  }else{
                      if(snNum[k]<100){
                          temp="0"+snNum[k];
                      }
                  }
                  result+=temp;
              }
              return result;

    }
          public static String getEncrypt(String str,String key){
            String sn=key; //密钥
            char[] snNum=new char[str.length()/3];
            String result="";

            for(int i=0,j=0;i<str.length()/3;i++,j++){
                if(j==sn.length())
                    j=0;
                int n=Integer.parseInt(str.substring(i*3,i*3+3));
                snNum[i]=(char)((char)n^sn.charAt(j));
            }

            for(int k=0;k<str.length()/3;k++){
                result+=snNum[k];
            }
            return result;
    }
    public static void trace(String traMsg) {
        if (CANWRITE) {
            System.out.println(traMsg);
        }
    }

}
