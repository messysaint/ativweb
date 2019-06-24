<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*"
%>

<%@ page errorPage="showError.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>debug</title>

<script type="text/javascript">
function validateNotificationEmailsForm() {
	
	var nickname = document.notificationemails.nickname.value;
	var notifyemail = document.notificationemails.notifyemail.value;
	
	
	if (nickname==null || nickname=="") { // null or empty
		alert("Please enter nickname value.");
		return false;
	}

	if (notifyemail==null || notifyemail=="") { // null or empty
		alert("Please enter email addresses value.");
		return false;
	}
	
}
</script>

</head>
<body>

<font face="Georgia, Arial, Garamond" size = "1">

<% // get all attributes and parameters
String VIN = (String) session.getAttribute( "IVWEB_VIN" );
%>

<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">    
	select * from abrstech_obd2db.ref_car_tbl 
	where vin = <%="\"" + VIN + "\""%> 				
</sql:query>

<H4>Notify Addresses</H4>

<form name="notificationemails" action="/ivweb/saveNewNotificationEmailsToDB.jsp" onsubmit="return validateNotificationEmailsForm()" method="post">

<table border="0">

  <c:forEach var="row" items="${rs.rows}"> 

  	<tr>
    	<td> Vehicle Nickname: &nbsp;  </td>
    	<td> 
    	<input type="text" name="nickname"   maxlength="20" size="20" style="font-size:11px" value="${row.nickname}"/> 
    	</td>
  	</tr>
  	<tr>
    	<td> Emails Addresses: &nbsp;  </td>
    	<td>
    	<textarea name="notifyemail" rows="2" cols="50" style="font-size:11px"> ${row.notifyemail} </textarea> 
    	</td>
  	</tr>
  
  </c:forEach>
  
</table> 
    
<INPUT type="submit" value="Save updates" style="font-size:11px" >

</form>

</font>

</body>
</html>