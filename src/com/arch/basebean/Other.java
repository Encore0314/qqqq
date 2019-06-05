package com.arch.basebean;

import java.util.*;

import com.arch.exception.*;
import com.arch.util.*;
import org.jdom.*;

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
public class Other {
    public Other(Element ele, String uid) {
        this.other = ele;
        this.UID = uid;
        this.faultMsg = getValue(this.other, "FaultMsg");
        this.successMsg = getValue(this.other, "SuccessMsg");
    }

    private String successMsg = "";
    private String faultMsg = "";
    private String successPage = null;
    private String faultPage = null;
    //设置跳转的目标target
    private String successTarget = "";
    private String faultTarget = "";
    private String UID = "";
    //存储handle中的other跳转信息
    private Element other = null;
    //在hash中找到name跳转页面并构成url返回
    public String parseUrlVar(HashMap hash, String name) throws WebException {
        StringBuffer url = null;
        Element successXml = other.getChild(name);
        try {
            if (name.equals("SuccessPage")) {
                if (successXml == null) {
                    throw new WebException("UID=" +
                                           this.UID + "的操作没有设置成功页面！");
                }

                this.setSuccessTarget(Tools.nvl(successXml.getAttributeValue(
                        "Target"), "location"));
            } else if (name.equals("FaultPage")) {
                if (successXml == null) {
                    throw new WebException("UID=" +
                                           this.UID + "的操作没有设置失败页面！");
                }

                this.setFaultTarget(Tools.nvl(successXml.getAttributeValue(
                        "Target"), "location"));
            }
            //得到主url
            url = new StringBuffer(Tools.nvl(successXml.getChild("Url").getText()));
            //得到参数列表并解析其值
            List paramListXml = successXml.getChildren("Param");
            if (paramListXml == null) {
                return url.toString();
            }
            //开始解析参数
            Element paramXml=null ;
            String paramName="";
            String paramValue = "";
            String operation = "",value="";
            HashMap field=null;
            Object temp=null;
            for (int i = 0; i < paramListXml.size(); i++) {
            	paramXml= (Element) paramListXml.get(i);
            	paramName = paramXml.getText();
                
                //有默认值，则直接取默认值
                if (paramXml.getAttributeValue("ConstValue") != null) {
                    paramValue = paramXml.getAttributeValue("ConstValue");
                } else {
                    //没有默认值则根据设定的Operation和Name去hash中取值
                   
                                       value = paramXml.getAttributeValue(
                                               "Name");
                    if (value == null) {
                        throw new WebException("UID=" +
                                               this.UID + "的操作中的" + name +
                                               "页面跳转参数" +
                                               paramName + "没有设置取值的名称value！");
                    }
                    if (paramXml.getAttributeValue("Operation") == null) {
                        operation = "operation1";
                    } else {
                        operation = paramXml.getAttributeValue("Operation");
                    }
                     field = (HashMap) hash.get(operation);
                    if (field == null) {
                        throw new WebException(
                                "在hashOrigin中没有没有找到对象：" +
                                name + "." +
                                operation);
                    }
                    temp = field.get(value);
                    if (temp == null) {
                        paramValue = "";
                    }
                    //如果地址参数对应的值是个数组且数据的元素不相等，那么就无法解析参数，不知道取哪个值
                    else if (!(temp instanceof String)) {
                        if (isEqual((String[]) temp) == null) {
                            throw new WebException(
                                    "UID=" +
                                    this.UID + "的操作中的" + name +
                                    "页面跳转参数" +
                                    paramName +
                                    "对应的值不唯一，无法解析路径参数:" +
                                    paramName);
                        } else {
                            temp = isEqual((String[]) temp);
                        }
                    }
                    paramValue = (String) temp;
                }
                //第一个参数应该用？连接
                if (i == 0&&url.indexOf("?")==-1) {
                    url.append("?");
                } else {
                    url.append("&");
                }
                url.append(paramName + "=" + paramValue);
            }
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "Other.parseUrlVar()" +
                                   e.getErrorPlace());

        } catch (Exception e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "Other.parseUrlVar()"
                    );
        }

        return url.toString();
    }

    //找到name跳转页面并构成url返回,不需要解析变量
    public String parseUrlVar(String name) throws WebException {
        StringBuffer url = null;
        Element successXml = other.getChild(name);
        try {
            if (name.equals("SuccessPage")) {
                if (successXml == null) {
                    throw new WebException("UID=" +
                                           this.UID + "的操作没有设置成功页面！");
                }

                this.setSuccessTarget(Tools.nvl(successXml.getAttributeValue(
                        "Target"), "location"));
            } else if (name.equals("FaultPage")) {
                if (successXml == null) {
                    throw new WebException("UID=" +
                                           this.UID + "的操作没有设置失败页面！");
                }
                this.setFaultTarget(Tools.nvl(successXml.getAttributeValue(
                        "Target"), "location"));
            }
            //得到主url
            url = new StringBuffer(Tools.nvl(successXml.getChild("Url").getText()));
            //得到参数列表并解析其值
            List paramListXml = successXml.getChildren("Param");
            if (paramListXml == null) {
                return url.toString();
            }
            //开始解析参数
            Element paramXml =null;
            String paramName =null;
            String paramValue = null;
            for (int i = 0; i < paramListXml.size(); i++) {
                 paramXml = (Element) paramListXml.get(i);
                 paramName = paramXml.getText();
                
                //有默认值，则直接取默认值
                if (paramXml.getAttributeValue("ConstValue") != null) {
                    paramValue = paramXml.getAttributeValue("ConstValue");
                } else {
                    paramValue = "";
                }
                //第一个参数应该用？连接
                if (i == 0) {
                    url.append("?");
                } else {
                    url.append("&");
                }
                url.append(paramName + "=" + paramValue);
            }
        }

        catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "Other.parseUrlVar()" +
                                   e.getErrorPlace());
        } catch (Exception e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "Other.parseUrlVar()"
                    );
        }
        return url.toString();
    }


//返回数组s中的元素是不是相等,如果相等则返回这个元素值，否则返回null
    private String isEqual(String[] s) {
        String s1 = s[0];
        for (int i = 1; i < s.length; i++) {
            if (s1.equals(s[i])) {
                continue;
            } else {
                return null;
            }
        }
        return s1;

    }

    public String getFaultPage(HashMap hash) throws WebException {
        try {
            this.faultPage = parseUrlVar(hash, "FaultPage");
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "Other.getFaultPage()" +
                                   e.getErrorPlace());
        }
        return faultPage.trim();
    }

    public String getFaultPage() throws WebException {
        try {
            this.faultPage = parseUrlVar("FaultPage");
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "Other.getFaultPage()" +
                                   e.getErrorPlace());
        }
        return faultPage.trim();
    }


    public String getSuccessMsg() {
        return successMsg;
    }

    public String getSuccessTarget() {
        return successTarget;
    }

    public String getFaultTarget() {
        return faultTarget;
    }


    public String getSuccessPage(HashMap hash) throws WebException {
        try {
            this.successPage = parseUrlVar(hash, "SuccessPage");
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "Other.getSuccessPage()" +
                                   e.getErrorPlace());
        }
        return successPage.trim();
    }

    public String getSuccessPage() throws WebException {
        try {
            this.successPage = parseUrlVar("SuccessPage");
        } catch (WebException e) {
            throw new WebException(e.getMessage(),
                                   "==>" + "Other.getSuccessPage()" +
                                   e.getErrorPlace());
        }
        return successPage.trim();
    }

    public String getFaultMsg() {
        return faultMsg;
    }

    private String getValue(Element ele, String name) {
        if (ele == null || ele.getChild(name) == null) {
            return "";
        }
        return Tools.nvl(ele.getChild(name).getText());
    }

    public void setSuccessTarget(String successTarget) {
        this.successTarget = successTarget;
    }

    public void setFaultTarget(String faultTarget) {
        this.faultTarget = faultTarget;
    }

    public void setFaultMsg(String faultMsg) {
        this.faultMsg = faultMsg;
    }
}
