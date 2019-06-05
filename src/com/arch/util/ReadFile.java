/*
 * 版权所有
 * 项目名称 管网资产管理
 * 包名称   com.waterqd.util
 *
 * 文件名称 ReadFile.java
 *
 */
package com.arch.util;
import java.io.*;

/**
 * 功能描述  读取文件<br><br>
 * 创建日期 2004-3-8 10:59:33
 *
 * @author
 * @version 1.0
 *
 */
public class ReadFile {

	private String currentRecord = null;//保存文本的变量
	private BufferedReader file; //BufferedReader对象，用于读取文件数据
	private String path;//文件完整路径名

	public ReadFile(String filePath) throws FileNotFoundException {
		path = filePath;
		//创建新的BufferedReader对象
		file = new BufferedReader(new FileReader(path));
		//  自动生成构造函数存根
	}

//	ReadFile方法用来读取文件filePath中的数据，并返回这个数据
  public String Read() throws FileNotFoundException  {

	String returnStr = null;
	try {
	  //读取一行数据并保存到currentRecord变量中
	  currentRecord = file.readLine();
	}catch (IOException e){//错误处理
	  SysConst.trace("读取数据错误.");
	}

//	返回读取文件的数据
	return currentRecord;
  }

  	public void close() throws IOException{
		file.close();
  	}

}
