<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,com.abrstech.sql.*,com.abrstech.obd2.security.*,com.abrstech.obd2.util.*"
%>

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
 	
	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	
 	String notSaved = "<h3>This update was not saved.</h3>";
 	String message1 = "<h3>This Trusted Mechanic record was updated.</h3>";

 	checkAuth check = new checkAuth();

 	String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

 	if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
 		response.sendRedirect( sessiontimeout );
 	} else { 
 		
		
 		Integer seqno = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_SEQNO from HTTP Session
 		
 		// check for session timed out
 		if( seqno == null ) {
 			response.sendRedirect( sessiontimeout );
 		}
 		
 		String businessname = request.getParameter("businessname");
 		String citytown = request.getParameter("citytown");
 		String state = request.getParameter("state");
 		
 		String zipcode = request.getParameter("zipcode");
 		String servicedzipcodes = request.getParameter("servicedzipcodes");
 		
 		String email = request.getParameter("email");
 		String businessdescription = request.getParameter("businessdescription-text");
 		
 		String website = request.getParameter("website");
 		String phone = request.getParameter("phone");
 		
 		saveUpdateBusinessRecord newMtnc = new saveUpdateBusinessRecord();   
 		boolean saveOk = newMtnc.WriteToDB( seqno, businessname, citytown, state, zipcode, email, businessdescription, website, phone, servicedzipcodes );
 		newMtnc.CloseDB();

 		//out.println("Date: " + date + "<br>");
 		//out.println("Cost: " + cost + "<br>");
 		//out.println("Services: " + servicesPerformed + "<br>");

 		//boolean saveOk = false;

 		// save to DB
 		if (!saveOk) {
 			out.println(notSaved);
 		} else {
 			out.println(message1);
 			String emailSubject = "Updated Auto Business Notice from Autotalky.com";
 			String emailMessage = "Auto Business information has been updated:\n\n" + 
 							  	  "\nBusiness Name:   " + businessname + 
 							  	  "\nCity/Town:  " + citytown + 
 							  	  "\nZip:  " + zipcode +
 			 					  "\n\n Thank you for using http://autotalky.com";
 			SmtpMailer mailerToBusiness = new SmtpMailer();
 			mailerToBusiness.sendMessageToAddress( email, emailSubject , emailMessage);
 			
 		}

 	}
 %>


	</font>

</body>
</html>