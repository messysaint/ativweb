<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,com.abrstech.sql.*,com.abrstech.obd2.security.*"%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save New Maintenance to DB</title>

</head>
<body>

	<font face="Georgia, Arial, Garamond" size="2"> <%
	
	String sessiontimeout = "/ivweb/z_securityquery.jsp";
	
 	String notSaved = "<h3>This maintenance record was not saved.</h3>";
 	String message1 = "<h3>Thank you. This maintenance record was saved to the database.</h3>";

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
 		
 		String zipcode = request.getParameter("zipcode");
 		String date = request.getParameter("dateofservice");
 		String odometer = request.getParameter("odometer");
 		
 		// correct data format from mm/dd/yyyy
 		/// to yyyy/mm/dd
 		String yr = date.substring(6);
 		String mmdd = date.substring(0, 5);
 		date = yr + '/' + mmdd;
 		

 		String servicesRequested = "";

 		Enumeration enumPar = request.getParameterNames();
 		String objName = "";
 		String tmp = "";
 		String notes = "";

 		while (enumPar.hasMoreElements()) {
 			objName = (String) enumPar.nextElement();
 			tmp = request.getParameter(objName);
 			if (objName.startsWith("dateofservice") ) {
 				// do nothing	
 			} else if (objName.startsWith( "costofservice" ) ) {
 				// do nothing
 			} else if (objName.startsWith( "odometer" ) ) {
 				// do nothing
 			} else if (objName.startsWith( "zipcode" ) ) {
 				// do nothing
 			} else if (tmp.trim().length() == 0) {
 				// do nothing
 			} else if (objName.endsWith( "-text" )) {
 				notes += request.getParameter(objName);
 			} else {
 				servicesRequested += request.getParameter(objName) + ".  ";
 			}

 		}

 		servicesRequested += notes.trim() ;	
 		String vin = IVWEB_VIN; 
 		
 		boolean saveOk = false;
 		
 		if( servicesRequested.length() > 0 ) {
 			saveVehicleToMarketplace newMtncRequest = new saveVehicleToMarketplace();
 	 		saveOk = newMtncRequest.WriteToDB( date, vin, odometer, servicesRequested, zipcode ); 
 	 		//boolean saveOk = false;
 	 		newMtncRequest.CloseDB();
 		}
 		

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