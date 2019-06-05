package com.arch.dbaccess;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2005</p>
 *
 * <p>Company: </p>
 *
 * @author dmbf
 * @version 1.0
 */
public class PrepareSql {
    private String oriSql = "";
    private StringBuffer newSql;
    private String params[];
    public static final char VAR_CHAR = ':';
    private static final char DES_CHAR = '?';

    public static boolean isEnd(char c) {
        return (c == ' ' || c == ',' || c == ';' || c == 39 || c == 13 ||
                c == 10 || c == ')' || c == '%' || c== '|');
    }

    public PrepareSql() {
       
    }

    public String getSql() {
        return newSql.toString();
    }

    public int getIndex(String param) {
        int result = 0;
        for (int i = 0; i < params.length; i++) {
            if (params[i].equals(param)) {
                result = i + 1;
                break;
            }
        }
        if (result == 0) {
            return -1;
        } else {
            return result;
        }
    }

    public void setSql(String inSql) {
        oriSql = inSql;
        int i;
        String tempStr;

        int paramCount = 0; //记录参数的个数
        for (i = 0; i < oriSql.length(); i++) {
            if (oriSql.charAt(i) == VAR_CHAR) {
                paramCount++;
            }
        }
        params = new String[paramCount];
        i = 0;
        int paramIndex = 0;
        newSql = new StringBuffer();
        while (i < oriSql.length()) {
            newSql.append(oriSql.charAt(i));
            if (oriSql.charAt(i) == VAR_CHAR) {
                newSql.setCharAt(newSql.length() - 1, DES_CHAR);
                i++;
                tempStr = "";
                while ((i < oriSql.length()) && !isEnd(oriSql.charAt(i))) {
                    tempStr = tempStr + oriSql.charAt(i);
                    i++;
                }
                if (i < oriSql.length()) {
                    newSql.append(oriSql.charAt(i++));
                }
                params[paramIndex++] = tempStr;
            } else {
                i++;
            }
        }
        //去掉多余的分号
        newSql = new StringBuffer(newSql.toString().replace(";", ""));
    }

    public String[] getParams() {
        return params;
    }
}
