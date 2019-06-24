<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,com.abrstech.sql.*,com.abrstech.obd2.security.*"%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save New Maintenance to DB</title>
<script type="text/javascript"
	src="/ivweb/jscript/validateAddMaintenanceForm.js"></script>
</head>
<body>

	<font face="Georgia, Arial, Garamond" size="2"> <%
 	
	String sessiontimeout = "/ivweb/z_securityquery.jsp";
	
 	String notSaved = "<h3>This note record was not saved.</h3>";
 	String message1 = "<h3>Thank you. This note record was saved to the database.</h3>";

 	checkAuth check = new checkAuth();

 	String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

 	if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
 		response.sendRedirect( sessiontimeout );
 	} else { 
 		

 		String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
 		
 		// check for session timed out
 		if( IVWEB_VIN == null ) {
 			response.sendRedirect( sessiontimeout );
 		}
 		
 		String cityhighwaympg = request.getParameter("cityhighwaympg");
 		String citympg = request.getParameter("citympg");
 		String highwaympg = request.getParameter("highwaympg");
 		
 		String reliabilitydependabilityRating =  request.getParameter("reliable-group");
 		String reliabilitydependabilityKudos = new String( " " ); //request.getParameter("reliability-kudos-text");
 		String reliabilitydependabilityComplaints = new String( " " ); //request.getParameter("reliability-complaints-text");
 		
 		String comfortRating =  request.getParameter("comfort-group");
 		String comfortKudos = new String( " " ); //request.getParameter("comfort-kudos-text");
 		String comfortComplaints = new String( " " ); //request.getParameter("comfort-complaints-text");
 		
 		String performanceRating =  request.getParameter("performance-group");
 		String performanceKudos = new String( " " ); //request.getParameter("performance-kudos-text");
 		String performanceComplaints = new String( " " ); //request.getParameter("performance-complaints-text");
 		
 		String looksRating =  request.getParameter("looks-group");
 		String looksKudos = new String( " " ); //request.getParameter("looks-kudos-text");
 		String looksComplaints = new String( " " ); //request.getParameter("looks-complaints-text");
 			
 		String valueRating =  request.getParameter("value-group");
 		String valueKudos = new String( " " ); //request.getParameter("value-kudos-text");
 		String valueComplaints = new String( " " ); //request.getParameter("value-complaints-text");
 		
 		String overAllRating =  request.getParameter("overall-group");
 		String otherNotes = request.getParameter("other-notes-text");
 		
 		
 		String vin = IVWEB_VIN; 
 		
 		saveNewAssessmentRecord newAssess = new saveNewAssessmentRecord();
 		boolean saveOk = newAssess.WriteToDB( "100", vin, cityhighwaympg, citympg, highwaympg, reliabilitydependabilityRating, reliabilitydependabilityKudos, reliabilitydependabilityComplaints, comfortRating, comfortKudos, comfortComplaints, performanceRating, performanceKudos, performanceComplaints, looksRating, looksKudos, looksComplaints, valueRating, valueKudos, valueComplaints, overAllRating, otherNotes );
 		newAssess.CloseDB();

 		//out.println("Date: " + date + "<br>");
 		//out.println("Cost: " + cost + "<br>");
 		//out.println("Services: " + servicesPerformed + "<br>");

 		//boolean saveOk = false;

 		// save to DB
 		if (!saveOk) {
 			out.println(notSaved);
 		} else {
 			out.println(message1);

 		}

 	}
 %>


	</font>

</body>
</html>