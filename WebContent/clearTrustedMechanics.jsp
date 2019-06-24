<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*,com.abrstech.sql.*,com.abrstech.obd2.security.*,com.abrstech.obd2.util.*"
%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Con  tent-Type" content="text/html; charset=UTF-8"> 
<title>Save New VIN to DB</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">
 
<% 

String sessiontimeout = "/ivweb/z_securityquery.jsp";
String notSaved  = "<h3>Problem saving selected Trusted Mechanics ...</h3>";
String savedMsg = "<h3>Selected Trusted Mechanics have been saved.</h3>";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} 

String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );
String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
 

if( IVWEB_VIN == null ) {
	
	String errorMsg = "<H3>No vehicle has been selected yet ...</H3>";
	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
	
	out.println( errorMsg );
	
} else {
	
	boolean saveOk = true;
	saveMyTrustedMechanic tm1 = new saveMyTrustedMechanic(); 
	tm1.DeleteFromDB( IVWEB_VIN );
	tm1.CloseDB();
		 		
	String backToMyAutoMechanic = "/ivweb/myAutoMechanic.jsp";					
	response.sendRedirect( backToMyAutoMechanic );
				
}

%>


</font>

</body>
</html>