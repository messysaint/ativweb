<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "com.abrstech.obd2.security.*"
%>

<%@ page errorPage="showError.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide VIN</title>

<script type="text/javascript" src="http://www.carqueryapi.com/js/jquery.min.js"></script>
<script type="text/javascript" src="http://www.carqueryapi.com/js/carquery.0.3.3.js"></script>

<script type="text/javascript" src="/ivweb/jscript/validateEmail.js"></script>



</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%
String sessiontimeout = "/ivweb/z_securityquery.jsp";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	
%>

	<h3>Search for Trusted Mechanics:</h3>

	<form name="searchMechanicOtherEmail" action="/ivweb/searchMechanicOtherEmail.jsp" onsubmit="return validateEmail()" method="post">

	<table border="0">

  

  <tr>
    <td>Email: &nbsp;</td>
    <td><input type="text" name="email" maxlength="30" size="30" value=""/> </td>
  </tr>
 
  
</table> 

<br>
<br>
	
	

<INPUT type="submit" value="Search">
</form>

<%
}
%>

</font>

</body>
</html>