<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%@page import="sun.jdbc.rowset.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%@page import="net.sf.json.*"%>

<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
HashMap data=null,olddata=null;
OracleRowSet[] ors= null;
OracleRowSet[] ors1= null;
OracleRowSet[] ors2= null;
JSONObject jsonObject = new JSONObject();
JSONArray jsonArray = new JSONArray();
if(eventResponse!=null){
	data=(HashMap)eventResponse.getBody();
	ors=(OracleRowSet[])data.get("operation1");
}

%>
<div class="zz"></div>
    <div class="inp_pass">
    		<div class=" basic-grey" >
 
        <div class="div-table" >
       	 <p align="center"><strong>历史申请信息</strong></p>
          	<table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tbody>
              <tr>
                <th nowrap="nowrap" scope="col">申请编号</th>
                <th scope="col">姓名</th>

                
               	<th scope="col">身份证号</th>
               	<th scope="col">所在单位</th>
                <th scope="col">户口所属镇（街道）</th>
                <th scope="col">首次申请日期</th>
                <th scope="col">申请日期</th>
                <th scope="col">申请补贴金额</th>
              </tr>
            <%for(int i=0;i<ors.length;i++){ %>
            <tr>
            	<td><%=ors[i].getValue("sqbm") %></td>
                <td><%=ors[i].getValue("fzr") %></td>

                
                <td><%=ors[i].getValue("sfzhm") %></td>
                <td><%=ors[i].getValue("dwmc") %></td>
                <td><%=ors[i].getValue("szjdname") %></td>
                <td><%=ors[i].getValue("scsqrqa") %></td>

                
                <td><%=ors[i].getValue("sqrq") %></td>
                <td><%=ors[i].getValue("sqze") %></td>
            </tr>
            <%} %>
            </tbody></table>
             <p align="center"><input class="button-add"  type="button" value="关闭" onclick="$('#sqlsdiv').css('display','none');"/></p>
          </div>
    </div>
    </div>
