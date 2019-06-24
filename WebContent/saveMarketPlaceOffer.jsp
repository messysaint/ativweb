<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,com.abrstech.sql.*,com.abrstech.obd2.security.*,com.abrstech.obd2.util.*"%>

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
	
 	String notSaved = "<h3>This offer was not saved nor sent to car owner.</h3>";
 	String messageOk = "<h3>Thank you. Your offer was sent to car owner.</h3>";

 	checkAuth check = new checkAuth();

 	String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

 	if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
 		response.sendRedirect( sessiontimeout );
 	} else { 
 		
		
 		String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
 		Integer IVWEB_BUS_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve business seqno
 		String IVWEB_CARREQNO = (String) session.getAttribute( "IVWEB_CARREQNO" ); // retrieve request seqno
 		String IVWEB_BUS_Email = (String) session.getAttribute( "IVWEB_EMAIL" );
 		String IVWEB_CAR_Email = (String) session.getAttribute( "IVWEB_CAREMAIL" );
 		String IVWEB_REQUESTEDSERVICES = (String) session.getAttribute( "IVWEB_REQUESTEDSERVICES" );
 		
 		// get other business info to send to car owner
 		String SESSIONBusinessname = (String) session.getAttribute( "IVWEB_BUSINESSNAME" );
 		String SESSIONCitytown = (String) session.getAttribute( "IVWEB_CITYTOWN" );
 		String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
 		String SESSIONCountry = (String) session.getAttribute( "IVWEB_COUNTRY" );
 		String SESSIONBusinessdescription = (String) session.getAttribute( "IVWEB_BUSINESSDESCRIPTION" );
 		String SESSIONWebsite = (String) session.getAttribute( "IVWEB_WEBSITE" );
 		String SESSIONPhone = (String) session.getAttribute( "IVWEB_PHONE" );
 		String SESSIONServicedzipcodes = (String) session.getAttribute( "IVWEB_SERVICEDZIPCODES" );
 		
 		
 		// check for session timed out
 		if( IVWEB_VIN == null ) {
 			response.sendRedirect( sessiontimeout );
 		}
 		
 		String estimatedcost = request.getParameter("estimatedcost");
 		String notes = request.getParameter("notes");
 		
 		saveAutoBusinessMntncOffer newMtnc = new saveAutoBusinessMntncOffer();   
 		boolean saveOk = newMtnc.WriteToDB( IVWEB_BUS_SEQNO, IVWEB_CARREQNO, IVWEB_VIN, estimatedcost, notes ); 
 		newMtnc.CloseDB();

 		
 		// save to DB
 		if (!saveOk) {
 			out.println(notSaved);
 		} else {
 			
 			out.println(messageOk);
 			
			// send confirmation email to business owner
			String subject1 = "Autotalky.com: Confirmation of your maintenance service offer for VIN = " + IVWEB_VIN;
			String message1 = "You offered an estimated cost of $ " + estimatedcost + " \n\nRequested Services:\n\n" + 
			                 IVWEB_REQUESTEDSERVICES + "\n\nYour Note to Vehicle Owner:\n\n" + notes +
			                 "\n\n\n\nThank You for using http://www.Santamesa.com";
 			SmtpMailer mailerToBusiness = new SmtpMailer();
 			mailerToBusiness.sendMessageToAddress( IVWEB_BUS_Email, subject1 , message1);
 			
 			// send confirmation email to car owner
 			String subject2 = "Autotalky.com: Maintenance service offer for VIN = " + IVWEB_VIN;
			String message2 = "Estimated cost of $ " + estimatedcost + " \n\nRequested Services:\n\n" + 
			                  IVWEB_REQUESTEDSERVICES + "\n\nNote from Mechanic:\n\n" + notes + "\n\n" +
			                  "Offered by: \n\n" +
			                  SESSIONBusinessname + "\n" +
			                  SESSIONCitytown + ", " + SESSIONZipcode + "\n" +
			                  SESSIONCountry + "\n\n" +
			                  SESSIONBusinessdescription + "\n\n" +
			                  "Website: " + SESSIONWebsite + "\n" +
			                  "Email: " + IVWEB_BUS_Email + "\n" +
			                  "Phone: " + SESSIONPhone + "\n" + 
			                  "Serviced Zip Codes: " + SESSIONServicedzipcodes +
			                  "\n\n\n\nThank You for using http://autotalky.com";
 			SmtpMailer mailerToCarOwner = new SmtpMailer();			                		 
 			mailerToCarOwner.sendMessageToAddress( IVWEB_CAR_Email, subject2, message2);
 			
 			
 			// for page to business listing
 			String answer = (String) session.getAttribute("IVWEB_BUSINESSNAME_ANSWER");
 			
 			response.setHeader("Refresh", "2; URL=/ivweb/marketPlaceMyOffersListingTM.jsp");
 			
 		}

 	}
 %>


	</font>

</body>
</html>