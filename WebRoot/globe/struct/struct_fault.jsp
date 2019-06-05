<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%

String flag = request.getParameter("flag");
if (flag != null && flag.equals("1")) {
  out.print("<script>");
  out.print("alert('您的操作已超时或尚未登陆系统！');");
  out.print("window.parent.location.href='/logout.jsp';");
  out.print("</script>");
  return;
}
if (flag != null && flag.equals("2")) {
  out.print("<script>");
  out.print("alert('操作异常！');");
  out.print("window.parent.location.href='/logout.jsp';");
  out.print("</script>");
  return;
}
if (flag != null && flag.equals("3")) {
	    out.print("<script>");
	    out.print("alert('上传文件过大！');");
	    out.print("</script>");
	    return;
	  }   
if (flag != null && flag.equals("4")) {
	    out.print("<script>");
	    out.print("alert('未授权！');");
	    out.print("window.parent.location.href='/logout.jsp';");
	    out.print("</script>");
	    return;
}  
if (flag != null && flag.equals("5")) {
	    out.print("<script>");
	    out.print("alert('非法访问！');");
	    out.print("window.parent.location.href='/';");
	    out.print("</script>");
	    return;
	  }  
if (flag != null && flag.equals("6")) {
	    out.print("<script>");
	    out.print("alert('请登陆！');");
	    out.print("window.parent.location.href='/logout.jsp';");
	    out.print("</script>");
	    return;
	  }
if (flag != null && flag.equals("7")) {
    out.print("<script>");
    out.print("alert('您没有访问此功能的权限，请联系管理员！');");
    out.print("</script>");
    return;
  }
   EventResponse eventResponse = (EventResponse) request.getAttribute("result");
   if(eventResponse!=null){
     FormUtil form = new FormUtil();
    String urlpattern=  eventResponse.getFaultPage();
  String msg=eventResponse.getFaultMsg().replace("\r\n","").replace("\n","");
  if(msg.indexOf("ORA-2")>0){
	  msg=msg.split("ORA-")[1];
  }
  if(msg.startsWith("ORA")){
    msg="操作异常！";
  }
  String target=eventResponse.getFaultTarget();
  if(target.equals("")){
    target="location";
  }
  if (msg.indexOf("未登陆或长时间未操作")>0) {
	  out.print("<script>");
	  out.print("alert('您未登陆或长时间未操作,请重新登陆！');");
	  out.print("window.parent.location.href='/logout.jsp';");
	  out.print("</script>");
	  return;
	}
  String url,urle="";
  if(!urlpattern.equals("")&&urlpattern.indexOf("struct_fault.jsp")<0){
        if(urlpattern.indexOf("mainservlet")>=0){
        	Azdg azdg = new Azdg();
        	urle=urlpattern.split("\\?")[1];
        	urle ="/mainservlet?handle="+azdg.encrypt(urle,SysConst.FORMACTION).replace("\r\n","");
        }else{
                   String jspcode = FormBean.getRandom(8);
		session.setAttribute("jspcode",jspcode);
            if(urlpattern.indexOf("?")>0){
              urle=urlpattern+"&jspcode="+Azdg.encrypt(jspcode,SysConst.FORMACTION);
            }else{
             urle=urlpattern+"?jspcode="+Azdg.encrypt(jspcode,SysConst.FORMACTION);
            }
        }
  //设定了成功信息则提示信息
  if (!msg.equals("")){
    if(msg.split("$").length>1){
      url=msg.split("$")[0];
      msg=msg.split("$")[1];
      out.print("<script>window."+ target + "='"+url + "?msg="+msg+"&returnurl="+urle+"';</script>");
    }
    else{
      if(msg.equals("$")){
        out.print("<script>window."+ target + "='"+urle + "';</script>");
      }else{
    out.println(form.showSuccessMsg(msg));
    out.print("<script>window."+ target + "='"+urle + "';</script>");
    }
    }
  }
  }else{

  //设定了成功信息则提示信息
  if (!msg.equals("")){
    if(msg.split("$").length>1){
      url=msg.split("$")[0];
      msg=msg.split("$")[1];
      out.print("<script>window."+ target + "='"+url + "?msg="+msg+"&returnurl=';</script>");
       //response.sendRedirect(url+"?msg="+msg);
    }
    else{
    out.println(form.showSuccessMsg(msg));
    out.print("<script>window.history.go(-1);</script>");
    }
  } else{ 
  	out.println(form.showSuccessMsg("操作失败！"));
    out.print("<script>window.history.go(-1);</script>");
    }
   }

    }else
    {
      out.print("<script>alert('操作异常！');window.parent.location.href='/logout.jsp';</script>");
    }
%>

