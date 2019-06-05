package com.arch.util;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;

public class ExcelUtil {
	
	/**
     * 获取合并单元格的值
     * @param sheet
     * @param row
     * @param column
     * @return
     */
    public static String getMergedRegionValue(Sheet sheet ,int row , int column){
 
        int sheetMergeCount = sheet.getNumMergedRegions();
 
        for(int i = 0 ; i < sheetMergeCount ; i++){
            CellRangeAddress ca = sheet.getMergedRegion(i);
            int firstColumn = ca.getFirstColumn();
            int lastColumn = ca.getLastColumn();
            int firstRow = ca.getFirstRow();
            int lastRow = ca.getLastRow();
 
            if(row >= firstRow && row <= lastRow){
                if(column >= firstColumn && column <= lastColumn){
                    Row fRow = sheet.getRow(firstRow);
                    Cell fCell = fRow.getCell(firstColumn);
                    return getCellValue(fCell) ;
                }
            }
        }
        
        Row rRow = sheet.getRow(row);
        Cell rCell = rRow.getCell(column);
        
        return getCellValue(rCell) ;
    }
    
    
    
    /**
     * 获取合并单元格的值
     * @param sheet
     * @param row
     * @param column
     * @return
     */
    public static String getMergedRegionValueNotRow(Sheet sheet ,int row , int column){
 
        int sheetMergeCount = sheet.getNumMergedRegions();
 
        for(int i = 0 ; i < sheetMergeCount ; i++){
            CellRangeAddress ca = sheet.getMergedRegion(i);
            int firstColumn = ca.getFirstColumn();
            int lastColumn = ca.getLastColumn();
            int firstRow = ca.getFirstRow();
            int lastRow = ca.getLastRow();
            //如果是合并的单元格
            if(row >= firstRow && row <= lastRow){
                if(column >= firstColumn && column <= lastColumn){
                	//如果单纯是一行的合并
                	if((row == firstRow && row== lastRow)){
                		return "";
                	}else{
                		Row fRow = sheet.getRow(firstRow);
                        Cell fCell = fRow.getCell(firstColumn);
                        return getCellValue(fCell) ;
                	}
                }
            }
        }
        
        Row rRow = sheet.getRow(row);
        Cell rCell = rRow.getCell(column);
        
        return getCellValue(rCell) ;
    }
    
    
    /**
     * 获取单元格的值
     * @param cell
     * @return
     */
    public static String getCellValue(Cell cell){
 
        if(cell == null) return "";
        
        cell.setCellType(Cell.CELL_TYPE_STRING);
        return  String.valueOf(cell.getRichStringCellValue().getString());
        
    }
    
    
    /**
     * 获取单元格的值
     * @param cell
     * @return
     */
    public static String getCellValue1(Cell cell){
 
        if(cell == null) return "";
 
        if(cell.getCellType() == Cell.CELL_TYPE_STRING){   //字符串
 
            return cell.getStringCellValue();
 
        }else if(cell.getCellType() == Cell.CELL_TYPE_BOOLEAN){   //Boolean
 
            return String.valueOf(cell.getBooleanCellValue());
 
        }else if(cell.getCellType() == Cell.CELL_TYPE_FORMULA){   //公式
//            return cell.getCellFormula() ;
            return String.valueOf(cell.getCellFormula());
 
        }else if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC){   //数字
//            return String.valueOf((int)cell.getNumericCellValue());
            return String.valueOf(cell.getNumericCellValue());
 
        }else if(cell.getCellType() == Cell.CELL_TYPE_ERROR){   //故障
 
            return "非法字符";
 
        }
        return "";
    }
	
	
}
