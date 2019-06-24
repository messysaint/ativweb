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
	

	String country = request.getParameter( "country" );
	String year = request.getParameter( "car-years" );
	String make = request.getParameter( "car-makes" );
	String model = request.getParameter( "car-models" );
	String trim = request.getParameter( "car-model-trims" );
	String vin = request.getParameter( "vin" );
	String email = request.getParameter( "email" );
	String question = request.getParameter( "reminderquestion" );
	String answer = request.getParameter( "reminderanswer" );   
	String zipcode = request.getParameter( "zipcode" );
	
	boolean saveOk = false;
	vin = vin.trim();
	
	if( vin.length() == 0) {
		saveOk = false;
	} else {
		saveNewVIN newVin = new saveNewVIN(); 
		saveOk = newVin.WriteToDB(country, vin, year, make, model, trim, email, question, answer, zipcode);
		newVin.CloseDB();	
	}
	
	
	// save to DB
	if( !saveOk ) {
		out.println( notSaved );
	} else {
		out.println( message1 );
		String howToUseAutotalky = "https://www.youtube.com/watch?v=bHcch3jcHHI";
		String emailSubject = "Registration Notice from Autotalky";
		
		String emailMessage = "You added a new Vehicle:\n\n" +
				              year + "  " + make.toUpperCase() + "  " + model + 
						  	  "\nVIN: " + vin + 
						  	  "\n" + country + 						  	  
						  	  "\n\n How to integrate your car with Autotalky: " + howToUseAutotalky;
		
		SmtpMailer mailerToBusiness = new SmtpMailer();
		mailerToBusiness.sendMessageToAddress( email, emailSubject , emailMessage);
		
	}
	
} 

%>


</font>

</body>
</html>