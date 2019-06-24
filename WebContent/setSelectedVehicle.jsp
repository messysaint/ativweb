<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator" 
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

	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
	
	String sessiontimeout = "/ivweb/z_securityquery.jsp";
	
	// check for session timed out
	if( IVWEB_VIN == null ) {
		response.sendRedirect( sessiontimeout );
	}
	
	String htmlbreak = "<br>";

	String errorMsg = "<H3>Your information does not match out record ...</H3>";
	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
	
	String addToMarketPlace = "&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; <A href=\"/ivweb/showVehicleToMarketplace.jsp\">or Post to Marketplace</A> &nbsp;]";
	String htmlMaintenanceRecordDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewMaintenanceDetails.jsp\">View History</A>&nbsp;&nbsp;]";
	
	String email = request.getParameter( "email" ).trim().toLowerCase(); 
	String answer = request.getParameter( "answer" ).trim().toLowerCase();
	
	String SESSIONVin = IVWEB_VIN;
	String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
	String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
	String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
	String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
	String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );
	String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
	
	SESSIONEmail = SESSIONEmail.trim().toLowerCase();
	SESSIONAnswer = SESSIONAnswer.trim().toLowerCase();
	
	Collator collator = Collator.getInstance();
	
	
	int compareEmail = collator.compare( SESSIONEmail, email );
	int compareAnswer = collator.compare( SESSIONAnswer, answer );
	
    if ( ( compareEmail == 0 )  &&  ( compareAnswer == 0 ) ) {
    	
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
		session.setAttribute( "IVWEB_SECURITY_ANSWER",  null); 
    	
    	out.println( errorMsg );
    	out.println( redirectMsg );
    	
    	
    	response.setHeader("Refresh", "2; URL=/ivweb/selectVehicle.jsp");
    	
    	//out.println( SESSIONEmail + " " + email );
    	//out.println( SESSIONAnswer + " " + answer );
    	        
    } // end if
%>






</font>

</body>
</html>