<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*,com.abrstech.sql.*, com.abrstech.obd2.security.*"
%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save New VIN to DB</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">
 
<% 

String sessiontimeout = "/ivweb/z_securityquery.jsp";

String notFound  = "<h3>This VIN was not found in the database. You may need to add it first.</h3>";
String message1 = "Display data here and allow user to add information";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	

	String vin = request.getParameter( "vin" );
	String year = request.getParameter( "car-years" );
	String make = request.getParameter( "car-makes" );
	String model = request.getParameter( "car-models" );
	String trim = request.getParameter( "car-model-trims" );
	
	
	searchVehicle newSrch = new searchVehicle();
	boolean foundOk = newSrch.isExisting( vin, year, make, model, trim);
	newSrch.CloseDB();
	
	String email = newSrch.getEmail();
	String question = newSrch.getQuestion();
	String answer = newSrch.getAnswer();
	String zipcode = newSrch.getZipcode();
	
	// save to DB
	if( !foundOk ) {
		out.println( notFound + "<br>" );
		
	} else {
		out.println( "<h3>VIN: " + newSrch.getVin() + "</h3>" );	
		out.println( "Year: " + newSrch.getYear() + " &nbsp; &nbsp; &nbsp; &nbsp; Make: " + newSrch.getMake().toUpperCase() + " &nbsp; &nbsp; &nbsp; &nbsp; Model: " + newSrch.getModel() + "<br><br><br>");
		
		
		session.setAttribute( "IVWEB_VIN", vin ); 
		session.setAttribute( "IVWEB_YEAR", year ); 
		session.setAttribute( "IVWEB_MAKE", make ); 
		session.setAttribute( "IVWEB_MODEL", model ); 
		session.setAttribute( "IVWEB_TRIM", trim ); 
		session.setAttribute( "IVWEB_EMAIL", email );
		session.setAttribute( "IVWEB_SECURITY_QUESTION", question ); 
		session.setAttribute( "IVWEB_SECURITY_ANSWER",  answer); 
		session.setAttribute( "IVWEB_ZIPCODE",  zipcode);
%>
		
<h3>Please verify your identity:</h3>

<form name="verifyidentity" action="/ivweb/showMaintenanceEntryForm.jsp" method="post">

<table border="0">

  <tr>
    <td>Email Address: &nbsp;</td>
    <td><input type="text" name="email"   maxlength="30" size="30" value=""/> </td>
  </tr>
  <tr>
    <td>Question: &nbsp;</td>
    <td><%=(String) session.getAttribute( "IVWEB_SECURITY_QUESTION" ) %>?</td>
  </tr>
  
  <tr>
    <td>Answer: &nbsp;</td>
    <td><input type="password" name="answer"   maxlength="50" size="50" value=""/> </td>
  </tr>
    
</table> 

<br>
<br>

<INPUT type="submit" value="Submit">

</form>


   
<%
	}
	
}

%>


</font>

</body>
</html>