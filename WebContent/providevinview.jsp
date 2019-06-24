<%@ page language="java" 
    import="com.abrstech.obd2.log.FindVin"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

	String htmlbreak = "<br>";
	String htmlNBSP = "&nbsp;";
	String nologfilesmsg = "No OBD2 logs found ...<br><br>";
	
	String htmlMultipleTripDetailsLink = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewMultipleTripDetails.jsp\">View Multiple Trip Data Averages</A>&nbsp;&nbsp;]";
	String htmlSingleTripDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewSingleTripDetails.jsp\">View Single Trip Details</A>&nbsp;&nbsp;]";
	//String htmlMaintenanceRecordDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewMaintenanceDetails.jsp\">View Maintenance Record Details</A>&nbsp;&nbsp;]";
	//String htmlVehicleNotesDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewNotesDetails.jsp\">View Vehicle Notes Details</A>&nbsp;&nbsp;]";
	
	//String vin = request.getParameter( "vin" ).trim(); 
	
	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
	String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
	String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
	String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
	String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
	String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );
	String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
	
    if ( IVWEB_VIN == null ) {
        
    	String errorMsg = "<H3>No vehicle has been selected yet ...</H3>";
    	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
    	
    	out.println( errorMsg );
    	out.println( redirectMsg );
    	
    	response.setHeader("Refresh", "2; URL=/ivweb/selectVehicle.jsp");
    	
    } else {
    	
    	//session.setAttribute( "IVWEB_VIN", vin ); // create HTTP SESSION header "IVWEB_VIN=vin"
    	
        // out.println( "<H3>VIN: " + IVWEB_VIN + "</H3>");
        
        FindVin vinlogs = new FindVin( IVWEB_VIN );
        String[] logs = vinlogs.searchVIN();
        
        if ( logs == null ) {
        	out.println( htmlbreak );
        	out.println( nologfilesmsg );
        } else {      
        %>
        
        <table border="0">
 		<tr><th><% out.println( htmlSingleTripDetailsLink +  htmlbreak + htmlbreak ); %> </th></tr>
        <tr><th><% out.println( htmlMultipleTripDetailsLink +  htmlbreak + htmlbreak ); %> </th></tr>
		</table>
		
        <%
        }
        
        // out.println( htmlMaintenanceRecordDetailsLink +  htmlbreak + htmlbreak ); // view maintenance record
        // out.println( htmlVehicleNotesDetailsLink +  htmlbreak + htmlbreak ); // view vehicle notes
        
    } // end if
%>

</font>

</body>
</html>