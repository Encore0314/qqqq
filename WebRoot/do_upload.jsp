<%@ page contentType="text/html; charset=gb2312" language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.util.*"%>
<%@ page import ="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import = "com.arch.util.*"%>
<%@ page import = "java.io.*,java.sql.*,sun.jdbc.rowset.*"%>
<%@ page import = "org.apache.poi.hpsf.*"%>
<%@ page import = "org.apache.poi.*"%>
<%@ page import = "org.apache.poi.poifs.*"%>
<%@ page import = "org.apache.poi.poifs.filesystem.*"%>
<%@ page import = "org.apache.poi.hssf.usermodel.*"%>

<html>
<head>
<title>文件上传处理页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../../css/style.css" rel="stylesheet" type="text/css">
</head>

<body  >
<%
String dwmc="",dwdm="",cid="",shxydm="",dwszdz="",lxdh="",ssqx="",dwlb="",hylb="",gsdjzzzl="";
String zzhm="",qybsm="",zcdz="",zcrq="",zcdssqx="",yxqx="",dwlx="",qyfzrxm="",qyfzrzjhm="",qyfzrlxdz="",zczj="",bxdjm="",bxjfzt="";

try{
 FormUtil futil = new FormUtil();
  String filepath=request.getParameter("reportfile");
  String version=request.getParameter("version");
  String title=request.getParameter("ptitle");
  String pubtype=request.getParameter("pubtype");
    String fpath=futil.getFilePath(filepath);
	// 上传文件
//out.print(fpath);
	java.io.File tempFile=new java.io.File(fpath);


  DBTransUtil transUtil = new DBTransUtil();
  Connection con = transUtil.getConnection();
  PreparedStatement preparedStatement = null;
  CachedRowSet crs=null;
  POIFSFileSystem fs = null;
  HSSFWorkbook wb = null;
  String message = "";
  FileInputStream stream = null;
  try {
   // str取得excel.xls路径
   stream = new FileInputStream(fpath);
   fs = new POIFSFileSystem(stream);
   wb = new HSSFWorkbook(fs);
  } catch (Exception e) {
   System.out.println("poi ExcelImportLogic---"+e.getMessage());
   if(fs == null) {
    out.print("<script language=javascript>alert('请下载最新模版，按照要求填写数据!!!');</script>");
   }
  } finally {
   try {
    stream.close();
   } catch (Exception ee) {
    ee.getMessage();
   }
  }
  //if(pubtype.equals("0")){
	//  transUtil.executeSql("delete from tb_proteinpair where version='"+version+"'");
	  
  //}
  HSSFSheet sheet = wb.getSheetAt(0);
 
  HSSFRow row = null;
  HSSFCell cell = null;
  int s0= sheet.getPhysicalNumberOfRows();
	//in_bill
    preparedStatement = con.prepareStatement("delete from tb_matchdwxx");
    preparedStatement.executeUpdate();
	preparedStatement = con.prepareStatement("call sp_impdwxx(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	for(int i=1;i<s0;i++){
	      row = sheet.getRow(i);
	      if(row == null) {//过滤掉Excel的空行
	       continue;     
	      }
	      cell = row.getCell(0);
	      
	      if(cell == null ){//判断是否为空
	    	  cid = "";
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  cid = cell.getStringCellValue();//不为空时取值
	      }
	      cell = row.getCell(1);
	      
	      if(cell == null ){//判断是否为空
	    	  dwdm="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  dwdm = cell.getStringCellValue();//不为空时取值
	      }
	     cell = row.getCell(2);
	      
	      if(cell == null ){//判断是否为空
	    	  shxydm = "";
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  shxydm = cell.getStringCellValue();//不为空时取值
	      }
	      cell = row.getCell(3);
	     
	      if(cell == null ){//判断是否为空
	    	  dwmc = "";
	    	 

	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  dwmc = cell.getStringCellValue();//不为空时取值
	      }
	      cell = row.getCell(4);
	     
	      if(cell == null ){//判断是否为空
	    	  dwszdz= "";
	    	 
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  dwszdz = cell.getStringCellValue();//不为空时取值
	      }

	      cell = row.getCell(5);
	      
	      if(cell == null ){//判断是否为空
	    	  lxdh = "";
	    	 
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  lxdh = cell.getStringCellValue();//不为空时取值
	      }	      
	      cell = row.getCell(6);
	     
	      if(cell == null ){//判断是否为空
	    	  ssqx = "";
	    	 
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  ssqx = cell.getStringCellValue();//不为空时取值
	      }
	      cell = row.getCell(7);
	      
	      if(cell == null ){//判断是否为空
	    	  dwlb = "";
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  dwlb = cell.getStringCellValue();//不为空时取值
	    	  
	      }	      
	      cell = row.getCell(8);
	
	      if(cell == null ){//判断是否为空
	    	  hylb = "";
	    	  
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  hylb = cell.getStringCellValue();//不为空时取值
	      }	
	      cell = row.getCell(9);
	      
	      if(cell == null ){//判断是否为空
	    	  gsdjzzzl = "";
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  gsdjzzzl = cell.getStringCellValue();//不为空时取值
	      }		      
	      
	     
	      cell = row.getCell(10);
	     
	      if(cell == null ){//判断是否为空
	    	  zzhm="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  zzhm = cell.getStringCellValue();//不为空时取值
	      }
	      cell = row.getCell(11);
	      if(cell == null ){//判断是否为空
	    	  qybsm="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  qybsm = cell.getStringCellValue();//不为空时取值
	      }
	      cell = row.getCell(12);
	      if(cell == null ){//判断是否为空
	    	  zcdz="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  zcdz = cell.getStringCellValue();//不为空时取值
	      }
	      cell = row.getCell(13);
	      if(cell == null ){//判断是否为空
	    	  zcrq="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  zcrq = cell.getStringCellValue();//不为空时取值
	      }
	      
	      cell = row.getCell(14);
	      if(cell == null ){//判断是否为空
	    	  zcdssqx="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  zcdssqx = cell.getStringCellValue();//不为空时取值
	      }
	      
	      cell = row.getCell(15);
	      if(cell == null ){//判断是否为空
	    	  yxqx="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  yxqx = cell.getStringCellValue();//不为空时取值
	      }
	      
	      cell = row.getCell(16);
	      if(cell == null ){//判断是否为空
	    	  dwlx="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  dwlx = cell.getStringCellValue();//不为空时取值
	      }
	      
	      cell = row.getCell(17);
	      if(cell == null ){//判断是否为空
	    	  qyfzrxm="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  qyfzrxm = cell.getStringCellValue();//不为空时取值
	      }
	      
	      cell = row.getCell(18);
	      if(cell == null ){//判断是否为空
	    	  qyfzrzjhm="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  qyfzrzjhm = cell.getStringCellValue();//不为空时取值
	      }
	      
	      cell = row.getCell(19);
	      if(cell == null ){//判断是否为空
	    	  qyfzrlxdz="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  qyfzrlxdz = cell.getStringCellValue();//不为空时取值
	      }
	      
	      
	      cell = row.getCell(20);
	      if(cell == null ){//判断是否为空
	    	  zczj="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  zczj = cell.getStringCellValue();//不为空时取值
	      }
	      
	      cell = row.getCell(21);
	      if(cell == null ){//判断是否为空
	    	  bxdjm="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  bxdjm = cell.getStringCellValue();//不为空时取值
	      }
	      
	      cell = row.getCell(22);
	      if(cell == null ){//判断是否为空
	    	  bxjfzt="";   
	      }else{
	    	  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    	  bxjfzt = cell.getStringCellValue();//不为空时取值
	      }
	      
	      preparedStatement.setString(1,dwmc          );
	      preparedStatement.setString(2,dwdm                   );
	      preparedStatement.setString(3,cid                     );
	      preparedStatement.setString(4,shxydm           );
	      preparedStatement.setString(5,dwszdz                   );
	      preparedStatement.setString(6,lxdh                     );
	      preparedStatement.setString(7,ssqx           );
	      preparedStatement.setString(8,dwlb                   );
	      preparedStatement.setString(9,hylb                     );
	      preparedStatement.setString(10,gsdjzzzl           );
	      preparedStatement.setString(11,zzhm                   );
	      preparedStatement.setString(12,qybsm                   );
	      preparedStatement.setString(13,zcdz                   );
	      preparedStatement.setString(14,zcrq                   );
	      preparedStatement.setString(15,zcdssqx                   );
	      preparedStatement.setString(16,yxqx                   );
	      preparedStatement.setString(17,dwlx                   );
	      preparedStatement.setString(18,qyfzrxm                   );
	      preparedStatement.setString(19,qyfzrzjhm                   );
	      preparedStatement.setString(20,qyfzrlxdz                   );
	      preparedStatement.setString(21,zczj                   );
	      preparedStatement.setString(22,bxdjm                   );
	      preparedStatement.setString(23,bxjfzt                   );
	      
	      preparedStatement.executeUpdate();
	      //System.out.print(gzrq);
	}

	 
}
		 catch (Exception e)
			{
				//sInBillMap.deleteInBill(new_id);
			    System.out.println(e.getMessage());
			 
				out.print("<script>alert('有异常，请检查！');window.history.go(-1);</script>");
				return;
			}

	       

		 out.print("发布成功！");


%>
 
</body>
</html>
