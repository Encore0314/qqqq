package com.arch.basebean;

/**
 * <p>Title: </p>
 *
 * <p>Description: 存放一个字段的名称，值等一些属性</p>
 *
 * <p>Copyright: Copyright (c) 2006</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class Field {
    public Field() {
    }

    public String getSequences() {
        return sequences;
    }

    public Object getFieldValue() {
        return fieldValue;
    }

    public String getFieldName() {
        return fieldName;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public String getQueryValue() {
        return queryValue;
    }

    public boolean isEncrypt() {
        return encrypt;
    }

    public boolean isDecrypt() {
        return decrypt;
    }
    public String getIsFile() {
        return isfile;
    }

    public String getSvalue() {
        return svalue;
    }

    public String getOtherOperation() {
        return otheroperation;
    }
 
    public String getCheck() {
        return check;
    }
    
    public void setSequences(String sequences) {
        this.sequences = sequences;
    }

    public void setFieldValue(Object fieldValue) {
        this.fieldValue = fieldValue;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public void setQueryValue(String queryValue) {
        this.queryValue = queryValue;
    }

    public void setEncrypt(boolean encrypt) {
        this.encrypt = encrypt;
    }

    public void setDecrypt(boolean decrypt) {
        this.decrypt = decrypt;
    }

    public void setIsFile(String isfile) {
        this.isfile = isfile;
    }



    public void setSValue(String svalue) {
        this.svalue = svalue;
    }

    public void setOtherOperation(String otheroperation) {
        this.otheroperation = otheroperation;
    }    
    public void setCheck(String check) {
        this.check = check;
    }     
    //字段名称
    private String fieldName = "";
//字段值
    private Object fieldValue = "";
//如果这个字段的值取sequences的话，那么这个sequences的名称
    private String sequences = "";
//这个字段的默认值，当没有找到这个字段的值时，就使用默认值
    private String defaultValue = "";
    //如果字段有这个属性，说明当这个字段的值为空时，他就不记录查询的条件
    private String queryValue = "";
    //是否要加密
    private boolean encrypt = false;
    //是否要解密
    private boolean decrypt = false;
    //是否要解密
    private String isfile = "";
 
    //文件类型
    private String svalue = "";
    //session中数据
    private String otheroperation = "";
    //取其他操作数据
    private String check = "";
    //取其他操作数据
    }
