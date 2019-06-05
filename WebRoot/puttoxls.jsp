<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.arch.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="sun.jdbc.rowset.*" %>
<%@ page import="jxl.*" %>
<%@ page import="jxl.write.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
OracleRowSet[] ors=new OracleRowSet[1];
ors[0]=new OracleRowSet(50);

HashMap data=null,olddata=null;

FormUtil futil = new FormUtil();
int up=1,down=1;
int length= 0;
if(eventResponse!=null){
  data=(HashMap)eventResponse.getBody();
  ors=(OracleRowSet[])data.get("operation1");
  length= ors.length;
  olddata=(HashMap)((HashMap)eventResponse.getOriginBody()).get("operation1");
}

String destfilename="output.xls";
String fieldnamestr="111";
     String  sourcefilename = "model.xls";

//if(olddata!=null){
//  destfilename=(String)olddata.get("destfilename");
//  fieldnamestr=(String)olddata.get("fieldnamestr");
//}

     WritableFont titleFont = new WritableFont(jxl.write.WritableFont.ARIAL,
                                                   10,
                                                   jxl.write.WritableFont.NO_BOLD, false,
                                                   jxl.format.UnderlineStyle.
                                                   NO_UNDERLINE,
                                                   jxl.format.Colour.BLACK);
     WritableCellFormat titleFormat = new WritableCellFormat(titleFont);

     response.reset();

     try{
      // crs = getRowSet(strSql);
       // 设置文件头，以及下载框中出现的文件名
       response.setHeader("Content-disposition","attachment;filename="+destfilename);
       // 设置类型
       response.setContentType("application/x-download");
       String path = request.getSession().getServletContext().
           getRealPath("");
       String file = path.replace('\\', '/') + "/"+sourcefilename;

       FileInputStream fileinputstream = new FileInputStream(file);
       Workbook workbook = Workbook.getWorkbook(fileinputstream);
       WritableWorkbook writableworkbook = Workbook.createWorkbook(
           response.getOutputStream(), workbook);
       WritableSheet ws = writableworkbook.getSheet(0);
       int i=2;
       String title[] = fieldnamestr.split("s");
       String col[]=ors[0].getCols();
            //for(int j=0; j<col.length; j++){
         //ws.addCell(new Label(j, 0,title[j],titleFormat));
       //}
      for(int k=0;k<ors.length;k++){
         ws.addCell(new Label(0, i, (i-1)+"", titleFormat));
         for(int j=0; j<col.length; j++){
           ws.addCell(new Label(j, i, ors[k].getValue(col[j]), titleFormat));
         }
         i++;
       }

       writableworkbook.write();
       writableworkbook.close();

     
  }
     catch(Exception fe){
       SysConst.trace("error at ExportExcelServlet : "+fe.getMessage());
     }
  out.clear();
  out = pageContext.pushBody();     
%>

