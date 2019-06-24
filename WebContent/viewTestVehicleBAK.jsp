<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.sql.*,java.util.*,com.abrstech.obd2.log.*,java.text.Collator" 
%>

<%@ page errorPage="showError.jsp" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />	
	<link type="text/css" href="/ivweb/datepicker/css/south-street/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
	<script type="text/javascript" src="/ivweb/datepicker/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/ivweb/datepicker/js/jquery-ui-1.8.22.custom.min.js"></script>

	<script type="text/javascript" src="/ivweb/jscript/validateAddMaintenanceForm.js"></script>
	
	<script>
	$(function() {
		$( "#datepicker" ).datepicker({ minDate: -180, maxDate: "+0D" });
	});
	</script>
	
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2"> 

<%	
String TestVIN = "--NULL--";
String Xemail = "--NULL--@yahoo.com";
	
searchVehicle newSrch = new searchVehicle();
boolean foundOk = newSrch.isExisting( TestVIN );
newSrch.CloseDB();

if( foundOk ) {
	session.setAttribute( "IVWEB_VIN",  TestVIN ); 
	session.setAttribute( "IVWEB_YEAR", newSrch.getYear() ); 
	session.setAttribute( "IVWEB_MAKE", newSrch.getMake() ); 
	session.setAttribute( "IVWEB_MODEL", newSrch.getModel() ); 
	session.setAttribute( "IVWEB_TRIM", newSrch.getTrim() ); 
	session.setAttribute( "IVWEB_EMAIL", Xemail );
	session.setAttribute( "IVWEB_SECURITY_QUESTION",  newSrch.getQuestion() ); 
	session.setAttribute( "IVWEB_SECURITY_ANSWER",  newSrch.getAnswer() );
	session.setAttribute( "IVWEB_ZIPCODE", newSrch.getZipcode() );
	session.setAttribute( "IVWEB_COUNTRY", newSrch.getCountry() );
	
	String goToDataDashBoard = "/ivweb/viewVin.jsp";
	response.sendRedirect( goToDataDashBoard ); 		
	
} else {
	
	session.setAttribute( "IVWEB_VIN", null ); 
	session.setAttribute( "IVWEB_YEAR", null ); 
	session.setAttribute( "IVWEB_MAKE", null ); 
	session.setAttribute( "IVWEB_MODEL", null ); 
	session.setAttribute( "IVWEB_TRIM", null ); 
	session.setAttribute( "IVWEB_EMAIL", null );
	session.setAttribute( "IVWEB_SECURITY_QUESTION", null ); 
	session.setAttribute( "IVWEB_SECURITY_ANSWER",  null ); 
	session.setAttribute( "IVWEB_ZIPCODE", null );
	session.setAttribute( "IVWEB_COUNTRY", null );
	
	String errorMsg = "<H3>Your " + TestVIN + " does not match out record ...</H3>";
	//String redirectMsg = "<br>Redirecting to Select Vehicle ...";
	
	out.println( errorMsg );
	//out.println( redirectMsg );
	
	response.setHeader("Refresh", "2; URL=/ivweb/addVin.jsp");
}

%>


</font>

</body>
</html>