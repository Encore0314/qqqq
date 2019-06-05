package com.arch.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;

import org.im4java.core.CompositeCmd;
import org.im4java.core.ConvertCmd;
import org.im4java.core.GMOperation;
import org.im4java.core.IM4JavaException;
import org.im4java.core.IMOperation;
import org.im4java.core.IdentifyCmd;
import org.im4java.process.ArrayListOutputConsumer;

public  class ImageTools {
	/**
	  * 居中切割<strong>图片</strong>(不支持gif<strong>图片</strong>切割) 1、如果源图宽高都小于目标宽高，则只压缩<strong>图片</strong>，不做切割
	  * 2、如果源图宽高都大于目标宽度，则根据宽度等比压缩后再居中切割 3、其它条件下，则压缩<strong>图片</strong>（不做缩放）后再居中切割
	  *
	  * 该方法在知道源图宽度（sw）和高度（sh）的情况下使用
	  *
	  * @param srcPath
	  *            源图路径
	  * @param desPath
	  *            切割<strong>图片</strong>保存路径
	  * @param sw
	  *            源图宽度
	  * @param sh
	  *            源图高度
	  * @param dw
	  *            切割目标宽度
	  * @param dh
	  *            切割目标高度
	  * @throws Exception
	  */
	 public void cropImage(String srcPath, String desPath, int sw, int sh,
	         int dw, int dh) throws Exception {
	     if (sw <= 0 || sh <= 0 || dw <= 0 || dh <= 0)
	         return;
	     IMOperation op = new IMOperation();
	     op.addImage(srcPath);
	     if ((sw <= dw) && (sh <= dh)) // 如果源图宽度和高度都小于目标宽高，则仅仅压缩<strong>图片</strong>
	     {
	         op.resize(sw, sh);
	     }
	     if ((sw <= dw) && (sh > dh))// 如果源图宽度小于目标宽度，并且源图高度大于目标高度
	     {
	         op.resize(sw, sh); // 压缩<strong>图片</strong>
	         op.append().crop(sw, dh, 0, (sh - dh) / 2);// 切割<strong>图片</strong>
	     }
	     if ((sw > dw) && (sh <= dh))// 如果源宽度大于目标宽度，并且源高度小于目标高度
	     {
	         op.resize(sw, sh);
	         op.append().crop(dw, sh, (sw - dw) / 2, 0);
	     }
	     if (sw > dw && sh > dh) // 如果源图宽、高都大于目标宽高
	     {
	         float ratiow = (float) dw / sw; // 宽度压缩比
	         float ratioh = (float) dh / sh; // 高度压缩比
	         if (ratiow >= ratioh) // 宽度压缩比小（等）于高度压缩比（是宽小于高的<strong>图片</strong>）
	         {
	             int ch = (int) (ratiow * sh); // 压缩后的<strong>图片</strong>高度
	             op.resize(dw, null); // 按目标宽度压缩<strong>图片</strong>
	             op.append().crop(dw, dh, 0, (ch > dh) ? ((ch - dh) / 2) : 0); // 根据高度居中切割压缩后的<strong>图片</strong>
	         } else // （宽大于高的<strong>图片</strong>）
	         {
	             int cw = (int) (ratioh * sw); // 压缩后的<strong>图片</strong>宽度
	             op.resize(cw, null); // 按计算的宽度进行压缩
	             op.append().crop(dw, dh, (cw > dw) ? ((cw - dw) / 2) : 0, 0); // 根据宽度居中切割压缩后的<strong>图片</strong>
	         }
	     }
	     op.addImage(desPath);
	     ConvertCmd convert = new ConvertCmd(true);
	     convert.run(op);
	 }
	   /**
	  * 
	  * 根据坐标裁剪<strong>图片</strong>
	  * 
	  * @param srcPath   要裁剪<strong>图片</strong>的路径
	  * @param newPath   裁剪<strong>图片</strong>后的路径
	  * @param x         起始横坐标
	  * @param y         起始挫坐标
	  * @param x1                结束横坐标
	  * @param y1                结束挫坐标
	  */ 
	 public static void cutImage(String srcPath, String newPath, int x, int y, int x1,   int y1) throws Exception { 
	     int width = x1 - x; 
	     int height = y1 - y; 
	     IMOperation op = new IMOperation(); 
	     op.addImage(srcPath); 
	     /**
	      * width：  裁剪的宽度
	      * height：裁剪的高度
	      * x：          裁剪的横坐标
	      * y：          裁剪的挫坐标
	      */ 
	     op.crop(width, height, x, y); 
	     op.addImage(newPath); 
	     ConvertCmd convert = new ConvertCmd(); 
	     // linux下不要设置此值，不然会报错 
	     convert.run(op); 
	 } 

	 /**
	  * 
	  * 根据尺寸缩放<strong>图片</strong>
	  * @param width             缩放后的<strong>图片</strong>宽度
	  * @param height            缩放后的<strong>图片</strong>高度
	  * @param srcPath           源<strong>图片</strong>路径
	  * @param newPath           缩放后<strong>图片</strong>的路径
	  */ 
	 public static void cutImage(int width, int height, String srcPath,  String newPath) throws Exception { 
	     IMOperation op = new IMOperation(); 
	     op.addImage(srcPath); 
	     op.resize(width, height); 
	     op.addImage(newPath); 
	     ConvertCmd convert = new ConvertCmd(); 
	     convert.run(op); 
	 } 

	 /**
	  * 根据宽度缩放<strong>图片</strong>
	  * 
	  * @param width            缩放后的<strong>图片</strong>宽度
	  * @param srcPath          源<strong>图片</strong>路径
	  * @param newPath          缩放后<strong>图片</strong>的路径
	  */ 

	 public static void cutImage(int width, String srcPath, String newPath)  throws Exception { 
	     IMOperation op = new IMOperation(); 
	     ConvertCmd cmd = new ConvertCmd();
	     op.addImage(); 
	     op.resize(width); 
	     op.addImage(); 
	    
			String osName = System.getProperty("os.name").toLowerCase();
			if (osName.indexOf("win") != -1) {
				// linux下不要设置此值，不然会报错
				cmd.setSearchPath("C:\\Program Files\\GraphicsMagick-1.3.19-Q16");
			}
	    
	 	try {
			cmd.run(op, srcPath, newPath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	 } 
	 public static void cutImage(int width, int height, String srcPath,
				String newPath,int type) throws Exception {
		    GMOperation op = new GMOperation();
	        op.addImage(srcPath);
	        op.resize(width, height);
	        op.quality(95.0);
	        op.addImage(newPath);
	        //如果使用ImageMagick，设为false,使用GraphicsMagick，就设为true，默认为false
	        ConvertCmd cmd = new ConvertCmd(true);
	        //linux下不要设置此值，不然会报错
			String osName = System.getProperty("os.name").toLowerCase();
			if (osName.indexOf("win") != -1) {
				// linux下不要设置此值，不然会报错
				 cmd.setSearchPath("C:\\Program Files\\GraphicsMagick-1.3.19-Q16");
			}
			try {
				cmd.run(op);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	 /**
	  * 给<strong>图片</strong>加水印
	  * @param srcPath            源<strong>图片</strong>路径
	  */ 
	 public static void addImgText(String srcPath) throws Exception { 
	     IMOperation op = new IMOperation(); 
	     op.font("宋体").gravity("southeast").pointsize(18).fill("#BCBFC8").draw("text 5,5 juziku.com"); 
	     op.addImage(); 
	     op.addImage(); 
	     ConvertCmd convert = new ConvertCmd(); 
	     convert.run(op, srcPath, srcPath); 
	 }
	  
	 /**
	  * <strong>图片</strong>信息
	  *
	  * @param imagePath
	  * @return
	  */
	 public static String getImageInfo(String imagePath) {
	     String line = null;
	     try {
	         IMOperation op = new IMOperation();
	         op.format("width:%w,height:%h,path:%d%f,size:%b%[EXIF:DateTimeOriginal]");
	         op.addImage(1);
	         IdentifyCmd identifyCmd = new IdentifyCmd(true);
	         ArrayListOutputConsumer output = new ArrayListOutputConsumer();
	         identifyCmd.setOutputConsumer(output);
	         identifyCmd.run(op, imagePath);
	         ArrayList<String> cmdOutput = output.getOutput();
	         assert cmdOutput.size() == 1;
	         line = cmdOutput.get(0);
	     } catch (Exception e) {
	         e.printStackTrace();
	     }
	     return line;
	 }
	  
	 /**
	  * 根据尺寸缩放<strong>图片</strong>[等比例缩放:参数height为null,按宽度缩放比例缩放;参数width为null,按高度缩放比例缩放]
	  *
	  * @param imagePath
	  *            源<strong>图片</strong>路径
	  * @param newPath
	  *            <strong>处理</strong>后<strong>图片</strong>路径
	  * @param width
	  *            缩放后的<strong>图片</strong>宽度
	  * @param height
	  *            缩放后的<strong>图片</strong>高度
	  * @return 返回true说明缩放成功,否则失败
	  */
	 public boolean zoomImage(String imagePath, String newPath, Integer width,Integer height) {
	     boolean flag = false;
	     try {
	         IMOperation op = new IMOperation();
	         op.addImage(imagePath);
	         if (width == null) {// 根据高度缩放<strong>图片</strong>
	             op.resize(null, height);
	         } else if (height == null) {// 根据宽度缩放<strong>图片</strong>
	             op.resize(width);
	         } else {
	             op.resize(width, height);
	         }
	         op.addImage(newPath);
	         ConvertCmd convert = new ConvertCmd(true);
	         convert.run(op);
	         flag = true;
	     } catch (IOException e) {
	         System.out.println("文件读取错误!");
	         flag = false;
	     } catch (InterruptedException e) {
	         flag = false;
	     } catch (IM4JavaException e) {
	         flag = false;
	     } finally {
	     }
	     return flag;
	 }

	 /**
	  * <strong>图片</strong>旋转
	  *
	  * @param imagePath
	  *            源<strong>图片</strong>路径
	  * @param newPath
	  *            <strong>处理</strong>后<strong>图片</strong>路径
	  * @param degree
	  *            旋转角度
	  */
	 public boolean rotate(String imagePath, String newPath, double degree) {
	     boolean flag = false;
	     try {
	         // 1.将角度转换到0-360度之间
	         degree = degree % 360;
	         if (degree <= 0) {
	             degree = 360 + degree;
	         }
	         IMOperation op = new IMOperation();
	         op.addImage(imagePath);
	         op.rotate(degree);
	         op.addImage(newPath);
	         ConvertCmd cmd = new ConvertCmd(true);
	         cmd.run(op);
	         flag = true;
	     } catch (Exception e) {
	         flag = false;
	         System.out.println("<strong>图片</strong>旋转失败!");
	     }
	     return flag;
	 }
	  
	 
	 /** 
	  * 根据尺寸缩放<strong>图片</strong> 
	  * @param width  缩放后的<strong>图片</strong>宽度 
	  * @param height  缩放后的<strong>图片</strong>高度 
	  * @param srcPath   源<strong>图片</strong>路径 
	  * @param newPath   缩放后<strong>图片</strong>的路径 
	  */   
	 public static void zoomImage(Integer width, Integer height, String srcPath, String newPath) throws Exception {   
	     IMOperation op = new IMOperation();   
	     op.addImage(srcPath);   
	     if(width == null){//根据高度缩放<strong>图片</strong> 
	         op.resize(null, height);     
	     }else if(height == null){//根据宽度缩放<strong>图片</strong> 
	         op.resize(width, null); 
	     }else { 
	         op.resize(width, height); 
	     } 
	     op.addImage(newPath);   
	     ConvertCmd convert = new ConvertCmd(true);   
	     convert.run(op);   
	 }   
	       
	 /** 
	  * 给<strong>图片</strong>加水印 
	  * @param srcPath   源<strong>图片</strong>路径 
	  */   
	 public static void addImgText(String srcPath,String content) throws Exception {   
	     IMOperation op = new IMOperation();   
	     op.font("微软雅黑"); 
	     op.gravity("southeast"); 
	     op.pointsize(18).fill("#BCBFC8").draw("text 0,0 "+content);   //("x1 x2 x3 x4") x1 格式，x2 x轴距离 x3 y轴距离  x4名称     
	     op.addImage();   
	     op.addImage();   
	     ConvertCmd convert = new ConvertCmd(true);   
	     try { 
	       convert.run(op,srcPath,srcPath); 
	     } catch (Exception e) { 
	         e.printStackTrace(); 
	     } 
	 }   
	 /**
	  * <strong>图片</strong>水印
	  *
	  * @param srcImagePath   源<strong>图片</strong>
	  * @param waterImagePath 水印
	  * @param destImagePath  生成<strong>图片</strong>
	  * @param gravity  <strong>图片</strong>位置
	  * @param dissolve 水印透明度
	  */ 
	 public static void waterMark(String waterImagePath, String srcImagePath, String destImagePath, String gravity, int dissolve) { 
	     GMOperation op = new GMOperation(); 
	     op.gravity(gravity); 
	    // op..dissolve(dissolve); 
	     op.addImage(waterImagePath); 
	     op.addImage(srcImagePath); 
	     op.addImage(destImagePath); 
	     CompositeCmd cmd = new CompositeCmd(true); 
	     try { 
	         cmd.run(op); 
	     } catch (IOException e) { 
	         e.printStackTrace(); 
	     } catch (InterruptedException e) { 
	         e.printStackTrace(); 
	     } catch (IM4JavaException e) { 
	         e.printStackTrace(); 
	     } 
	 } 
	    
	 /**
	  * <strong>图片</strong>信息
	  *
	  * @param imagePath
	  * @return
	  */ 
	 public static String showImageInfo(String imagePath) { 
	     String line = null; 
	     try { 
	         GMOperation op = new GMOperation(); 
	         //op.format("width:%w,height:%h,path:%d%f,size:%b%[EXIF:DateTimeOriginal]"); 
	         op.addImage(1); 
	         IdentifyCmd identifyCmd = new IdentifyCmd(true); 
	         ArrayListOutputConsumer output = new ArrayListOutputConsumer(); 
	         identifyCmd.setOutputConsumer(output); 
	         identifyCmd.run(op, imagePath); 
	         ArrayList<String> cmdOutput = output.getOutput(); 
	         assert cmdOutput.size() == 1; 
	         line = cmdOutput.get(0); 
	 
	     } catch (Exception e) { 
	         e.printStackTrace(); 
	     } 
	     return line; 
	 } 
	 /**
	  * <strong>图片</strong>合成
	  * @param args
	  * @param maxWidth
	  * @param maxHeight
	  * @param newpath
	  * @param mrg
	  * @param type 1:横,2:竖
	  */ 
	 public static void montage(String[] args,Integer maxWidth,Integer maxHeight,String newpath,Integer mrg,String type) { 
	     GMOperation op = new GMOperation(); 
	     ConvertCmd cmd = new ConvertCmd(true); 
	     String thumb_size = maxWidth+"x"+maxHeight+"^"; 
	     String extent = maxWidth+"x"+maxHeight; 
	     if("1".equals(type)){ 
	         op.addRawArgs("+append"); 
	     }else if("2".equals(type)){ 
	         op.addRawArgs("-append"); 
	     } 
	        
	     op.addRawArgs("-thumbnail",thumb_size); 
	     op.addRawArgs("-gravity","center"); 
	     op.addRawArgs("-extent",extent); 
	        
	     Integer border_w = maxWidth / 40; 
	     op.addRawArgs("-border",border_w+"x"+border_w); 
	     op.addRawArgs("-bordercolor","#ccc"); 
	        
	     op.addRawArgs("-border",1+"x"+1); 
	     op.addRawArgs("-bordercolor","#fff"); 
	        
	     for(String img : args){ 
	         op.addImage(img); 
	     } 
	     if("1".equals(type)){ 
	         Integer whole_width = ((mrg / 2) +1 + border_w + maxWidth + border_w + (mrg / 2) +1)*args.length - mrg; 
	         Integer whole_height = maxHeight + border_w + 1; 
	         op.addRawArgs("-extent",whole_width + "x" +whole_height); 
	     }else if("2".equals(type)){ 
	         Integer whole_width = maxWidth + border_w + 1; 
	         Integer whole_height = ((mrg / 2) +1 + border_w + maxHeight + border_w + (mrg / 2) +1)*args.length - mrg; 
	         op.addRawArgs("-extent",whole_width + "x" +whole_height); 
	     } 
	     op.addImage(newpath); 
	     try { 
	         cmd.run(op); 
	     } catch (Exception e) { 
	         e.printStackTrace(); 
	     } 
	 }
	  
	  
}
