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

String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";

String notFound  = "<h3>This VIN was not found in the database. You may need to add it first.</h3>";
String message1 = "Display data here and allow user to add information";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	

	String vin = request.getParameter( "vin" );
	
	searchVehicle newSrch = new searchVehicle();
	boolean foundOk = newSrch.isExisting( vin ); 
	newSrch.CloseDB();
	
	
	
	// save to DB
	if( !foundOk ) {
		out.println( notFound + "<br>" );
		
	} else {
		//out.println( "<h3>VIN: " + newSrch.getVin() + "</h3>" );	
		//out.println( "Year: " + newSrch.getYear() + " &nbsp; &nbsp; &nbsp; &nbsp; Make: " + newSrch.getMake().toUpperCase() + " &nbsp; &nbsp; &nbsp; &nbsp; Model: " + newSrch.getModel() + "<br><br><br>");
		
		
		session.setAttribute( "IVWEB_VIN", newSrch.getVin() ); 
		session.setAttribute( "IVWEB_YEAR", newSrch.getYear() ); 
		session.setAttribute( "IVWEB_MAKE", newSrch.getMake() ); 
		session.setAttribute( "IVWEB_MODEL", newSrch.getModel() ); 
		session.setAttribute( "IVWEB_TRIM", newSrch.getTrim() ); 
		session.setAttribute( "IVWEB_EMAIL", newSrch.getEmail() );
		session.setAttribute( "IVWEB_ZIPCODE", newSrch.getZipcode() );
		session.setAttribute( "IVWEB_COUNTRY",  newSrch.getCountry());
		session.setAttribute( "IVWEB_SECURITY_QUESTION", newSrch.getQuestion() ); 
		session.setAttribute( "IVWEB_SECURITY_ANSWER",  newSrch.getAnswer()); 

		String goToDataDashBoard = "/ivweb/viewVinTM.jsp";
    	response.sendRedirect( goToDataDashBoard ); 
    	
	}
	
}

%>


</font>

</body>
</html>