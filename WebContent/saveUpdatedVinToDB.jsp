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
String message1 = "<h3>This vehicle info update has been saved.</h3>";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	

	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" );
	String country = request.getParameter( "country" );
	String email = request.getParameter( "email" );
	String question = request.getParameter( "reminderquestion" );
	String answer = request.getParameter( "reminderanswer" );   
	String zipcode = request.getParameter( "zipcode" );

	saveUpdatedVIN newVin = new saveUpdatedVIN();
	boolean saveOk = newVin.WriteToDB(country, email, question, answer, IVWEB_VIN, zipcode);  
	newVin.CloseDB();
	
	// save to DB
	if( !saveOk ) {
		out.println( notSaved );
	} else {
		out.println( message1 );
		
		String emailSubject = "Updated Vehicle Notice from Autotalky.com";
		String emailMessage = "Information has been updated:\n\n" + 
						  	  "VIN: " + IVWEB_VIN ;
		
		SmtpMailer mailerToBusiness = new SmtpMailer();
		mailerToBusiness.sendMessageToAddress( email, emailSubject , emailMessage);
		
	}
	
}

%>


</font>

</body>
</html>