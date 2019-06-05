package com.arch.dbaccess;

import com.arch.basebean.*;
import com.arch.util.*;
import java.util.HashMap;
import com.arch.dbaccess.*;
import com.arch.exception.WebException;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2006</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class BaseDBImpl {
    public BaseDBImpl() {
    }

   

    //解决field数组中的元素值有的是多行,有的是单行的问题,统一将所有元素以最大行数的标准去平滑单行的元素
    //如果一个元素不是单行操作,但又不等于其他正常的操作行数则抛出异常
    //将字段的seq属性和defaultvalue属性转换成其值
    public Field[] smoothField(Operation operation,HashMap originfield,String rand) throws WebException {
        int maxRow = operation.getRow();

        Field[] field=(Field[])operation.getField();
        try {


                String temp;
                String[] tempData;
                for (int i = 0; i < field.length; i++) {
                    if(field[i].getCheck()!=null&&field[i].getCheck().equals("Rand")){
                		if(field[i].getFieldValue()==null||!field[i].getFieldValue().equals(rand)){
                			throw new WebException("验证码输入错误！");
                		}
                	}
                    //前台获得的值为null
                    if (field[i].getFieldValue() == null||field[i].getFieldValue().equals("")) {
                        if (field[i].getSequences() != null &&
                            !field[i].getSequences().equals("")) {
                            //如果有seq属性，则使用seq的值
                             tempData = new String[maxRow];
                            //循环取maxRow个seq值
                            SysConst.trace(field[i].getFieldName() + ":" +
                                               field[i].getSequences());
                            for (int j = 0; j < maxRow; j++) {
                               // tempData[j] = dbUtil.getSequence(field[i].
                                    //    getSequences());
                            	tempData[j]=FormBean.getRandom(20);
                            }
                            field[i].setFieldValue(tempData);
                            tempData=null;
                        } else if (field[i].getDefaultValue() != null) {
                            //否则如果提供了默认值，那么就使用默认值
                            temp = field[i].getDefaultValue();
                            SysConst.trace(field[i].getFieldName() +
                                               ":DefaultValue");
                            //将这几行操作都用这个默认值去赋值
                            field[i].setFieldValue( temp);
                        }
                        else if (field[i].getOtherOperation() != null) {
                        	field[i].setFieldValue((String[])((HashMap)originfield.get(field[i].getOtherOperation())).get(field[i].getFieldName()));
                        	}
                        
                        else { //否则抛出异常
                        	field[i].setFieldValue( "");
                        }
                    }
                    //多行操作中，以这个提供的单值去初始化每一行的值
                    else  {
                        field[i].setFieldValue(field[i].getFieldValue());
                    }

                }
                temp=null;
           
          
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "BaseDBImpl.smoothField()" +
                                   e.getErrorPlace());
        }

        catch (Exception e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "BaseDBImpl.smoothField()");
        }
       
        return field;
    }

   

    //判断前台传过来的field中，是多行操作还是单行操作，将值以字段名为名称存储在hashmap对象中
    public HashMap getFieldData(Field[] field) throws WebException {
        Object temp = null;
        String filename ="";
        HashMap result = new HashMap();
        //设置操作的行数，默认为1行
        result.put("row", 1);
        for (int i = 0; i < field.length; i++) {
            try {
                temp = field[i].getFieldValue();
                //temp=null，那么说明在smoothField()方法中还有没有处理的情况
                if (temp == null) {
                    throw new WebException(
                            "错误代码：s0000014");
                }
                //值是数组的形式，多行操作
                if (temp instanceof String[]) {
                    //设置操作的行数
                    String[] t = (String[]) temp;
                    result.put("row", t.length);
                    //对每个元素进行加密
                    if (field[i].isEncrypt()) {
                        for (int e = 0; e < t.length; e++) {
                            t[e] = Tools.encrypt(t[e]);
                        }
                    }
                    //对每个元素进行解密
                    else if (field[i].isDecrypt()) {
                        for (int e = 0; e < t.length; e++) {
                            t[e] = Tools.decrypt(t[e]);
                        }
                    }

                    temp = t;
                    t=null;
                } else {
                    //对元素进行加密
                    if (field[i].isEncrypt()) {
                        temp = Tools.encrypt((String) temp);
                    }
                    //对元素进行解密
                    else if (field[i].isDecrypt()) {
                        temp = Tools.decrypt((String) temp);
                    }
                }
                //将值以fieldname为名存储在hashmap中
                result.put(field[i].getFieldName(), temp);
            } catch (WebException e) {
                throw new WebException(e.getMessage(),
                                       "==>" + "BaseDBImpl.getFieldData()" +
                                       e.getErrorPlace());
            }

            catch (Exception e) {
                throw new WebException(e.getMessage(),
                                       "==>" + "BaseDBImpl.getFieldData()");
            }

        }
        temp=null;
        return result;

    }

    //重新解析sql语句，有QueryValue属性的字段为空时，该字段不计入到sql语句的的查询条件
    public String processSqlByQueryValue(String sql, Field[] field) throws
            WebException {
        SysConst.trace("OriSql=" + sql);
        String paramName=null;
        try {
            for (int i = 0; i < field.length; i++) {
                if (field[i].getQueryValue() != null) {
                    if (field[i].getFieldValue() instanceof String[]) {
                        throw new WebException(
                                "错误代码：s0000015"+field[i].getFieldName());
                    } else if (field[i].getFieldValue() instanceof String) {
                        //获得要替换的变量名
                    	paramName = getParamName(field[i].getFieldName(),
                                field[i].getQueryValue());
                        //如果为空则去掉sql中的该段查询条件
                        if (((String) field[i].getFieldValue()).equals("")) {
                            sql = sql.replace(paramName, "1=1");
                        }
                        //否则不为空，该查询条件有效
                        else {
                            sql = sql.replace(paramName,
                                                 field[i].getQueryValue());
                        }
                        paramName=null;
                    }
                }
            }
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "BaseDBImpl.processQueryValue()" +
                                   e.getErrorPlace());
        }

        catch (Exception e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "BaseDBImpl.processQueryValue()");
        }

        return sql;
    }

//获取QueryValue属性里要替换的变量名
    private String getParamName(String name, String value) throws
            WebException {
        int index = value.indexOf(PrepareSql.VAR_CHAR);
        String tempStr = "";
        try {
            if (index == -1) {
                throw new WebException("错误代码：s0000016"+name);
            } while ((index < value.length()) &&
                     !PrepareSql.isEnd(value.charAt(index))) {
                tempStr = tempStr + value.charAt(index);
                index++;
            }
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "BaseDBImpl.getParamName()" +
                                   e.getErrorPlace());
        } catch (Exception e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "BaseDBImpl.getParamName()");
        }
        return tempStr;
    }


}
