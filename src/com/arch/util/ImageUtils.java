package com.arch.util;

import java.awt.AlphaComposite;   
import java.awt.Color;   
import java.awt.Font;   
import java.awt.Graphics2D;   
import java.awt.Image;   
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;   
import java.awt.image.AffineTransformOp;   
import java.awt.image.BufferedImage;   
import java.io.File;   
import java.io.FileOutputStream;
import java.io.IOException;   
  
import javax.imageio.ImageIO;   

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
  
/**  
 * @author Eric Xu  
 *  
 */  
public final class ImageUtils {   
    /**  
     * 锲剧墖姘村嵃  
     * @param pressImg 姘村嵃锲剧墖  
     * @param targetImg 鐩爣锲剧墖  
     * @param x 淇链?榛樿鍦ㄤ腑闂? 
     * @param y 淇链?榛樿鍦ㄤ腑闂? 
     * @param alpha 阃忔槑搴? 
     */  
    public final static void pressImage(String pressImg, String targetImg, int x, int y, float alpha) {   
        try {   
            File img = new File(targetImg);   
            Image src = ImageIO.read(img);   
            int wideth = src.getWidth(null);   
            int height = src.getHeight(null);   
            BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);   
            Graphics2D g = image.createGraphics();   
            g.drawImage(src, 0, 0, wideth, height, null);   
            //姘村嵃鏂囦欢   
            Image src_biao = ImageIO.read(new File(pressImg));   
            int wideth_biao = src_biao.getWidth(null);   
            int height_biao = src_biao.getHeight(null);   
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));   
            g.drawImage(src_biao, x , y, wideth_biao, height_biao, null);   
            //姘村嵃鏂囦欢缁撴潫   
            g.dispose();   
            
            FileOutputStream output = new FileOutputStream(targetImg);  
            
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(output);
            encoder.encode(image);   
            output.close();
            // ImageIO.write((BufferedImage) image, "jpg", img);   
        } catch (Exception e) {   
            e.printStackTrace();   
        }   
    }   
  
    /**  
     * 鏂囧瓧姘村嵃  
     * @param pressText 姘村嵃鏂囧瓧  
     * @param targetImg 鐩爣锲剧墖  
     * @param fontName 瀛椾綋鍚岖О  
     * @param fontStyle 瀛椾綋镙峰纺  
     * @param color 瀛椾綋棰滆壊  
     * @param fontSize 瀛椾綋澶у皬  
     * @param x 淇链? 
     * @param y 淇链? 
     * @param alpha 阃忔槑搴? 
     */  
    public static void pressText(String pressText, String targetImg, String fontName, int fontStyle, Color color, int fontSize, int x, int y, float alpha) {   
        try {   
            File img = new File(targetImg); 
            
            //Image src = ImageIO.read(img);   
            
            
            BufferedImage image = ImageIO.read(img);

            // 銮峰缑缂╂斁镄勬瘮渚?
            double ratio = 1.0;
            int width = image.getWidth(null);   
            int height = image.getHeight(null); 
            int[] ImageArrayOne = new int[width*height];
            ImageArrayOne = image.getRGB(0,0,width,height,ImageArrayOne,0,width);
            
            
            
            // 鍒ゆ柇濡傛灉楂朴€佸閮戒笉澶т簬璁惧畾链硷紝鍒欎笉澶勭悊
            if (image.getHeight() > height || image.getWidth() > width) {
                if (image.getHeight() > image.getWidth()) {
                    ratio = height / image.getHeight();
                } else {
                    ratio = width / image.getWidth();
                }
            }
            // 璁＄畻鏂扮殑锲鹃溃瀹藉害鍜岄佩搴?
            int newWidth = (int) (image.getWidth() * ratio);
            int newHeight = (int) (image.getHeight() * ratio);
            int type= image.getColorModel().getTransparency();// 
            BufferedImage bfImage = new BufferedImage(newWidth, newHeight,
                    type);
            bfImage.getGraphics().drawImage(
                    image.getScaledInstance(newWidth, newHeight,
                            Image.SCALE_SMOOTH), 0, 0, null);

            bfImage.setRGB(0, 0, width, height,ImageArrayOne , 0, width);
            
            
            
             
         //   BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);   
            Graphics2D g = bfImage.createGraphics();   
          //  g.drawImage(src, 0, 0, width, height, null);   
            g.setColor(color);   
            g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
            	     RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

            g.setFont(new Font(fontName, fontStyle, fontSize));   
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));   
            g.drawString(pressText, (width - (getLength(pressText) * fontSize)) / 2 + x, (height - fontSize) / 2 + y);   
            g.dispose();   
            ImageIO.write((BufferedImage) bfImage, "png", img);   
        } catch (Exception e) {   
            e.printStackTrace();   
        }   
    }   
  
    /**  
     * 缂╂斁  
     * @param filePath 锲剧墖璺缎  
     * @param height 楂桦害  
     * @param width 瀹藉害  
     * @param bb 姣斾緥涓嶅镞舵槸鍚﹂渶瑕佽ˉ鐧? 
     */  
    public static void resize(String filePath, int height, int width, boolean bb) {   
        try {   
            double ratio = 0.0; //缂╂斁姣斾緥    
            File f = new File(filePath);   
            BufferedImage bi = ImageIO.read(f);   
            Image itemp = bi.getScaledInstance(width, height, bi.SCALE_SMOOTH);   
            //璁＄畻姣斾緥   
            if ((bi.getHeight() > height) || (bi.getWidth() > width)) {   
                if (bi.getHeight() > bi.getWidth()) {   
                    ratio = (new Integer(height)).doubleValue() / bi.getHeight();   
                } else {   
                    ratio = (new Integer(width)).doubleValue() / bi.getWidth();   
                }   
                AffineTransformOp op = new AffineTransformOp(AffineTransform.getScaleInstance(ratio, ratio), null);   
                itemp = op.filter(bi, null);   
            }   
            if (bb) {   
                BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);   
                Graphics2D g = image.createGraphics();   
                g.setColor(Color.white);   
                g.fillRect(0, 0, width, height);   
                if (width == itemp.getWidth(null))   
                    g.drawImage(itemp, 0, (height - itemp.getHeight(null)) / 2, itemp.getWidth(null), itemp.getHeight(null), Color.white, null);   
                else  
                    g.drawImage(itemp, (width - itemp.getWidth(null)) / 2, 0, itemp.getWidth(null), itemp.getHeight(null), Color.white, null);   
                g.dispose();   
                itemp = image;   
            }   
            ImageIO.write((BufferedImage) itemp, "jpg", f);   
        } catch (IOException e) {   
            e.printStackTrace();   
        }   
    }   
  
    public static void main(String[] args) throws IOException {   
        pressImage("f:\\imgtest\\sy.gif", "f:\\imgtest\\test1.jpg", 0, 0, 1f);   
        //pressText("鎴戞槸鏂囧瓧姘村嵃", "G:\\imgtest\\test1.jpg", "榛戜綋", 36, Color.white, 80, 0, 0, 0.3f);   
       //resize("G:\\imgtest\\test1.jpg", 500, 500, true);   
    }   
  
    public static int getLength(String text) {   
        int length = 0;   
        for (int i = 0; i < text.length(); i++) {   
            if (new String(text.charAt(i) + "").getBytes().length > 1) {   
                length += 2;   
            } else {   
                length += 1;   
            }   
        }   
        return length / 2;   
    }   
}  