<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.arch.event.*"%>
<%@page import="com.arch.util.*"%>
<%@page import="sun.jdbc.rowset.*"%>
<%@ page import="com.arch.basebean.OracleRowSet" %>
<%@page import="org.json.JSONObject"%>


<%@page import="java.sql.*"%>


<%

//拿本地的数据库连接
DBTransUtil dbutil = new DBTransUtil();
//查询数据
String sesql = "select * from tb_sms where status=0";

CachedRowSet smslist = dbutil.getResultBySelect(sesql);

//String fid=Azdg.encryptsubmit("fid=prodept.xml@setphonesuccess",SysConst.FORMACTION);

JSONObject jsonObject = new JSONObject();

//连接外数据库链接
Connection connection = null;
PreparedStatement statement = null;
ResultSet resultSet = null;


//String url = "jdbc:mysql://127.0.0.1:3306/test";
//String u = "root";
//String p = "root";

String url = "jdbc:mysql://223.105.2.23:63099/massif";
String u = "ictf";
String p = "jsyd@2018f";

//String sql = "INSERT INTO `phone` ("+
//		"	`phone`,"+
//		"	`context` "+
//		")"+
//		"VALUES"+
//		"	("+
//		"		?,"+
//		"		?"+
//		"	)";


String sql = "INSERT INTO sms_outbox ("+
		"	SISMSID,"+
		"	EXTCODE,"+
		"	DESTADDR,"+
		"	MESSAGECONTENT,"+
		"	REQDELIVERYREPORT,"+
		"	MSGFMT,"+
		"	SENDMETHOD,"+
		"	REQUESTTIME,"+
		"	APPLICATIONID"+
		")"+
		"VALUES"+
		"	("+
		"		1,"+
		"		'12',"+
		"		?,"+
		"		?,"+
		"		1,"+
		"		8,"+
		"		2,"+
		"		CURRENT_TIMESTAMP,"+
		"		'p201811261601166'"+
		"	)";


jsonObject.put("msg","success");

while(smslist.next()){
	
try {
	
	connection = DriverManager.getConnection(url, u, p);
	Class.forName("com.mysql.jdbc.Driver");
	
	statement = connection.prepareStatement(sql);
	//	statement.setString(1, phone);
	//	statement.setString(2, content);
	
	Integer id= smslist.getInt("id");
	String phone = smslist.getString("phone");
	String content = smslist.getString("content");

	statement.setString(1, phone);
	statement.setString(2, content);
	//添加到批处理
	int res = statement.executeUpdate();
	//成功的话
	if(res==1){
		dbutil.executeSql("update tb_sms set status=1 where id="+id);
	}
	
	jsonObject.put("msg","success");
	
	//response.sendRedirect("/mainservlet?handle="+fid);
	
//	while(resultSet.next()){
		
//		String name = resultSet.getString("phone");
//		String pass = resultSet.getString("content");
		
//		System.out.println(name+"---"+pass);
		
//	}
	
	
	
} catch (SQLException e) {
	// TODO Auto-generated catch block
	jsonObject.put("msg","error");
	e.printStackTrace();
} catch (ClassNotFoundException e) {
	// TODO Auto-generated catch block
	jsonObject.put("msg","error");
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

}

//request.getRequestDispatcher("/data_json.jsp").forward(request, response);


out.print(jsonObject.toString());
%>

