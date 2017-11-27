<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    response.setHeader("Content-Disposition","attachment;filename=member.xls");    //디폴트 파일명 지정
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