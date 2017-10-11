<%---------------------------------------------------------------------------
  Copyright ⓒ 2017 DAHAMI COMMUNICATIONS
  All rights reserved.
  -----------------------------------------------------------------------------
  @fileName : FileName
  @author   : JEON,HYUNGGUK
  @date     : 2017. 9. 21. 오후 3:27:27
  @comment   : 
 
  @revision history
  date            author         comment
  ----------      ---------      ----------------------------------------------
  2017. 9. 21.     
---------------------------------------------------------------------------%>


<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	home
	<div>한글한글 한글한글</div>
	<%
		out.println(request.getParameter("test"));
		List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
		items = (List<Map<String,Object>>)request.getAttribute("test");
		out.println(items.get(1).get("descriptionKr"));

		//String [] arr = (String[])request.getAttribute("test");
		//for(int i=0;i<arr.length;i++){
		//out.println(arr[i]+"<br>");
		//}
	%>


</body>
</html>