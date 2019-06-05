<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page  contentType="text/html; charset=GBK" pageEncoding="GB18030"%>
 <%@ page import="java.util.*"%>
 <%@ page import="com.arch.util.*"%>
<%@ page import="com.arch.event.*"%>
<%@ page import="com.arch.basebean.*"%>
<%@ page import="java.util.HashMap"%>
<%
HttpServletRequest hreq = (HttpServletRequest) request;
HashMap user = (HashMap) hreq.getSession(false).getAttribute(SysConst.LOGIN_USER);
if(user!=null){
   String username=(String)user.get("id");
    hreq.getSession(false).removeAttribute(SysConst.LOGIN_USER);
    hreq.getSession(false).removeAttribute(SysConst.FUNCTION_LIST);
    hreq.getSession(false).invalidate();

}
out.print("<script>location='/login.jsp';</script>");
%>
<script language="Javascript">
//window.opener=null;//不提示是否关闭
//window.close();
</script>
