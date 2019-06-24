<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*,com.abrstech.sql.*,com.abrstech.obd2.security.*,com.abrstech.obd2.util.*"
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
String notSaved  = "<h3>This VIN was not save to DB.  It might be already existing.</h3>";
String message1 = "<h3>This vehicle info has been saved.</h3>";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	

	String Xemail = (String) session.getAttribute( "IVWEB_LOGIN_SECURITY_EMAIL" );
	String Xvin   = (String) session.getAttribute( "IVWEB_LOGIN_SECURITY_VIN" );
	String Xquestion = (String) session.getAttribute( "IVWEB_LOGIN_SECURITY_QUESTION" ); 
	String Xanswer = (String) session.getAttribute( "IVWEB_LOGIN_SECURITY_ANSWER" ); 
	
	
	String emailSubject = "Vehicle Owner Password from Autotalky.com";
	String emailMessage = Xanswer;
	
	SmtpMailer mailerToBusiness = new SmtpMailer();
	mailerToBusiness.sendMessageToAddress( Xemail, emailSubject , emailMessage);
		
	
	out.println( "Your password has been sent to " + Xemail );
	
	response.setHeader("Refresh", "2; URL=/ivweb/selectVehicle.jsp");
	
}

%>


</font>

</body>
</html>