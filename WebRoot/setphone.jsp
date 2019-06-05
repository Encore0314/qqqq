<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%@page import="sun.jdbc.rowset.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%@page import="org.json.JSONObject"%>


<%@page import="java.sql.*"%>


<%
EventResponse eventResponse = (EventResponse) request.getAttribute("result");
HashMap data=null,olddata=null;

JSONObject jsonObject = new JSONObject();

olddata = (HashMap) ((HashMap) eventResponse.getOriginBody()).get("operation1");

jsonObject.put("token",eventResponse.getToken()==null?"":eventResponse.getToken());

jsonObject.put("olddata",new JSONObject(olddata));

String phone=null;
String content=null;
if(olddata.get("phone")!=null){
	phone = ((String[])olddata.get("phone"))[0];
}

if(olddata.get("content")!=null){
	content = ((String[])olddata.get("content"))[0];
}


jsonObject.put("phone",phone);
jsonObject.put("content",content);


Connection connection = null;
PreparedStatement statement = null;
ResultSet resultSet = null;

//String url = "jdbc:mysql://39.106.102.2:63306/performace";
//String u = "dev";
//String p = "qwe123";


String url = "jdbc:mysql://127.0.0.1:3306/test";
String u = "root";
String p = "root";

//String sql = "INSERT INTO testphone (phone,content) values (?,?) ";

String sql = "INSERT INTO phone ("+
		"	phone,"+
		"	context"+
		") "+
		"VALUES"+
		"	("+
		"		?,"+
		"		?"+
		"	)";


try {
	
	Class.forName("com.mysql.jdbc.Driver");
	
	connection = DriverManager.getConnection(url, u, p);
	statement = connection.prepareStatement(sql);
			statement.setString(1, phone);
			statement.setString(2, content);
	
	Integer res = statement.executeUpdate();
	
	
	
	
//	while(resultSet.next()){
		
//		String name = resultSet.getString("phone");
//		String pass = resultSet.getString("content");
		
//		System.out.println(name+"---"+pass);
		
//	}
	
	
	
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (ClassNotFoundException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}finally{
	
	try {
		if(resultSet != null){
			resultSet.close();
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	try {
		if(statement != null){
			statement.close();
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	try {
		if(connection != null){
			connection.close();
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}

//request.getRequestDispatcher("/data_json.jsp").forward(request, response);


out.print(jsonObject.toString());
%>

