<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%
/**
���ݸ�ʽ��
{text:'apple', value:'100'}
{text:'pear', value:'200'}
{text:'aop', value:'300'}
{text:'java', value:'400'}
{text:'jee', value:'500'}
{text:'are', value:'600'}
{text:'auto', value:'700'}
{text:'application', value:'800'}
{text:'book', value:'900'}
{text:'bock', value:'000'}
**/
//��������
Map<String, Integer> dataMap = new HashMap<String, Integer>();
dataMap.put("abdicate", 1);
dataMap.put("abduct", 2);
dataMap.put("accede", 3);
dataMap.put("abhor", 4);
dataMap.put("append", 5);
dataMap.put("abjure", 6);
dataMap.put("apple", 7);
dataMap.put("baba", 8);
dataMap.put("book", 9);
dataMap.put("back", 10);
dataMap.put("bike", 11);
dataMap.put("babur", 12);
dataMap.put("baby", 13);
dataMap.put("catch", 14);
dataMap.put("cat", 15);
dataMap.put("car", 16);
dataMap.put("cook", 17);
dataMap.put("cool", 18);
dataMap.put("cake", 19);
dataMap.put("client", 20);
dataMap.put("can", 21);
dataMap.put("duck", 22);
dataMap.put("dog", 23);
dataMap.put("damp", 24);
dataMap.put("data", 25);
dataMap.put("date", 26);
dataMap.put("deal", 27);
dataMap.put("�л����񹲺͹�", 28);
dataMap.put("�й���", 29);
dataMap.put("�������̨", 30);
dataMap.put("�����й���", 31);

//���ص�����
StringBuffer retData = new StringBuffer();

//�õ������ؼ���
String s = String.valueOf(request.getParameter("s"));
//���ؼ�����ת��
s = new String(s.getBytes("iso-8859-1"), "GBK");

System.out.println(s);

//��ѯ���ϸùؼ��ֵ�����
Set<String> keySet = dataMap.keySet();
for(String key : keySet)
{
	if(key.toUpperCase().indexOf(s.toUpperCase())>-1)
	{
		retData.append("{text:'" + key + "', value:'" + dataMap.get(key) + "'}");
		retData.append("\n");
	}
}

//����ҳ�治����   
response.setHeader("Pragma", "No-cache");   
response.setHeader("Cache-Control", "no-cache");   
response.setDateHeader("Expires", 0);

//���
System.out.println(retData.toString());
response.getWriter().println(retData.toString());
%>