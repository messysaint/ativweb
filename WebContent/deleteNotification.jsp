<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Check DB Connection</title>
</head>
<body>

<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:update var="rs">    
	delete from abrstech_obd2db.car_obd2_notifications where seqno = ? 		
	<sql:param value="${param.no}" />	 					
</sql:update>

<jsp:forward page="/activeNotificationRules.jsp" />

</body>
</html>