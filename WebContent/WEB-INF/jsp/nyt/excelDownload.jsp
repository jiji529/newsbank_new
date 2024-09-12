<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Date today = new Date();
	SimpleDateFormat datetime = new SimpleDateFormat("yyyyMMdd_hhmmss");
	String fileName = datetime.format(today);
	String attachment = "attachment;filename=" + fileName + ".xls";
    response.setHeader("Content-Disposition", attachment);    //디폴트 파일명 지정
    response.setHeader("Content-Description", "JSP Generated Data"); 
%>

<!document html>
<style>
	table {
		width:  100%;
	}
</style>
<html lang="ko">
	<body>${excelHtml}
	</body>
</html>