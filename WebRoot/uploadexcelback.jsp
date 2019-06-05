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
<%@ page import = "org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@ page import = "org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import = "org.apache.poi.ss.usermodel.*"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.arch.event.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%!	public String getValue(Cell xssfCell, Workbook workbook) {
		String value = "";
		
		//switch (xssfCell.getCellType()) {
		//case Cell.CELL_TYPE_STRING:
		//	value = String.valueOf(xssfCell.getRichStringCellValue()
		//			.getString());
		//	System.out.print("|");
		//	break;
		//case Cell.CELL_TYPE_NUMERIC:
			//if (DateUtil.isCellDateFormatted(xssfCell)) {
			//	value = String.valueOf(String.valueOf(xssfCell
			//			.getDateCellValue()));
			//} else {
			//	value = String.valueOf(xssfCell.getNumericCellValue());
			//}
			//System.out.print("|");
			//break;
		//case Cell.CELL_TYPE_BOOLEAN:
			//value = String.valueOf(xssfCell.getBooleanCellValue());
			//System.out.print("|");
		//	break;
		// 公式,
		//case Cell.CELL_TYPE_FORMULA:
			// 获取Excel中用公式获取到的值,//=SUM(P4-Q4-R4-S4)Excel用这种类似的公式计算出来的值用POI无法获取，要想获取的话，就必须一下操作
		//	FormulaEvaluator evaluator = workbook.getCreationHelper()
		//			.createFormulaEvaluator();
		//	evaluator.evaluateFormulaCell(xssfCell);
		//	CellValue cellValue = evaluator.evaluate(xssfCell);
		//	value = String.valueOf(cellValue.getNumberValue());
		//	break;
		//case Cell.CELL_TYPE_ERROR:
			//value = String.valueOf(xssfCell.getErrorCellValue());
			//break;
		//default:
		xssfCell.setCellType(Cell.CELL_TYPE_STRING);
		    value = String.valueOf(xssfCell.getStringCellValue());
		//}
		return value;
	}
 %>
 <%! public void read(String fpath) throws IOException  
    {  
        InputStream stream = new FileInputStream(fpath);  
        Workbook wb = null;  
        String fileType="xlsx";
        if (fileType.equals("xls")) {  
            wb = new HSSFWorkbook(stream);  
        }  
        else if (fileType.equals("xlsx")) {  
            wb = new XSSFWorkbook(stream);  
        }  
        else {  
            System.out.println("您输入的excel格式不正确");  
        }  
        Sheet sheet1 = wb.getSheetAt(0);  
        for (Row row : sheet1) {  
            for (Cell cell : row) {  
              cell.setCellType(HSSFCell.CELL_TYPE_STRING);
               System.out.print(cell.getStringCellValue()+"  ");  
            }  
            System.out.println();  
        }  
    }  
   %>
 
<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
FormUtil form = new FormUtil();
OracleRowSet[] ors=new OracleRowSet[1];
ors[0]=new OracleRowSet(50);
HashMap data=null,olddata=null;
if(eventResponse!=null){
     data=(HashMap)eventResponse.getBody();
     ors=(OracleRowSet[])data.get("operation1");
}



	JSONObject jsonObject = new JSONObject();
																String p_worgid = "";
																String p_wcodeflag = "";
																String p_wdate = "";
                                                                String p_worgname         ="";
                                                                String p_uname        ="";
                                                                String p_uid = "";
                                                                String p_value = "";
                                                                
                                                                  Cell xssfCell=null;
                                                                    DBTransUtil transUtil = new DBTransUtil();
  Connection con = transUtil.getConnection();
  String filename=ors[0].getValue("inputfile");
   p_wcodeflag=ors[0].getValue("wcodeflag");
   p_wdate=ors[0].getValue("wdate");

    String fpath="C:\\run\\uploadDemo-master\\nodeServer\\uploads\\"+filename.split("/")[filename.split("/").length-1];
	//String fpath="C:\\test\\demo.xlsx";
	 
	//System.out.println(fpath);  
	
try{
	
	System.out.println("111");  
	
 FormUtil futil = new FormUtil();

	// 上传文件
//out.print(fpath);
	java.io.File tempFile=new java.io.File(fpath);



    con.setAutoCommit(false);
  PreparedStatement preparedStatement = null;
  CachedRowSet crs=null;

  Workbook workbook = null;

  String message = "";
  FileInputStream stream = null;

   // str取得excel.xls路径
  InputStream inputStream = new FileInputStream(fpath);
   			if (tempFile.getName().endsWith("xlsx")||tempFile.getName().endsWith("XLSX")){
				workbook = new XSSFWorkbook(inputStream);
				}
			else{
				workbook = new HSSFWorkbook(inputStream);
		}
   

	preparedStatement = con.prepareStatement("insert into tb_wages (uid,wdate,wcodeflag,uname,worgname,worgid,wname,wvalue) values (?,?,?,?,?,?,?,?)");
		for (int numSheet = 0; numSheet < workbook.getNumberOfSheets(); numSheet++) {
			Sheet xssfSheet = workbook.getSheetAt(numSheet);
			// 这种主要是判断是否含空以免包空指针
			if (xssfSheet == null) {
				continue;
			}
 
			//表头有多少列
			int headnum = xssfSheet.getRow(0).getLastCellNum();
			if(headnum<8){
				throw new Exception("列数不正确");
			}
			System.out.println("多少列" + headnum);
			
			// 循环行Row
			// 从第二行读取(这个根据自己的实际需求而定,因为我是在第二行之后才是我需要的数据)
			for (int rowNum = 1; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
				Row xssfRow = xssfSheet.getRow(rowNum);
				if (xssfRow == null) {
					continue;
				}
				
				// 循环列Cell
				//System.out.println("多少列" + xssfRow.getLastCellNum());
				
					
				
					p_worgid=	ExcelUtil.getMergedRegionValueNotRow(xssfSheet, rowNum, 1);
					p_worgname=	ExcelUtil.getMergedRegionValueNotRow(xssfSheet, rowNum, 2);
					p_uid=	ExcelUtil.getMergedRegionValueNotRow(xssfSheet, rowNum, 3);
					p_uname=	ExcelUtil.getMergedRegionValueNotRow(xssfSheet, rowNum, 4);
					
					
					
				    
					//uid,wdate,wcodeflag,uname,worgname
					
				
                  	preparedStatement.setString(1,p_uid);
                  	preparedStatement.setString(2,p_wdate);
                  	preparedStatement.setString(3,p_wcodeflag);
                  	preparedStatement.setString(4,p_uname);
                  	preparedStatement.setString(5,p_worgname);
                  	preparedStatement.setString(6,p_worgid);
                  	
					
                
				for(int j=7;j<headnum;j++){
					String value = 	ExcelUtil.getMergedRegionValueNotRow(xssfSheet, rowNum, j);
					//String wname =  ExcelUtil.getMergedRegionValueNotRow(xssfSheet, 0, j);
					
					xssfCell = xssfSheet.getRow(0).getCell(j);
					xssfCell.setCellType(Cell.CELL_TYPE_STRING);
					String wname =	xssfCell.getStringCellValue();
					
					System.out.println("wname" + wname + "---------" + "value" + value);
					
					if(!value.equals("") && !wname.equals("")){
						preparedStatement.setString(7,wname);
	                  	preparedStatement.setString(8,value);
	                	preparedStatement.executeUpdate();
					}
				}
                  	
                   
                   
               




			}
				
		}
			 con.commit();
		

 


   
	  
}
		 catch (Exception e)
			{
			con.rollback();
		
				//sInBillMap.deleteInBill(new_id);
			    System.out.println(e.getMessage());
			 jsonObject.put("resl", "倒入失败");
				
			}

	           
	

jsonObject.put("resl", "倒入成功");
out.print(jsonObject.toString());
%>

