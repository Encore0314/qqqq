package com.arch.basebean;


import java.util.*;

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
public class OracleRowSet {
    public OracleRowSet(int capacity) {
        hash = new HashMap(capacity);
    }

    private HashMap hash = null;
    private String[] cols=new String[0];
    public void setCols(String[] cols) {
       this.cols=cols;
    }
    public String[] getCols() {
        return this.cols;
    }
    public void setValue(String name, String value) {
        hash.put(name, value);
    }

    public String getValue(String name) throws Exception {
        try {
            Object temp = hash.get(name);
            if (temp == null) {
                return "";
            } else {
                return (String) hash.get(name);
            }
        } catch (Exception e) {
            throw new Exception("错误发生在OracleRowSet.getValue()中，可能的原因为参数" + name +
                                "对应的值不唯一。Other:" + e.getMessage());
        }
    }

    public HashMap getHash() {
        return hash;
    }
}
