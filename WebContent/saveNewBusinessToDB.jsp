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
 	String sessiontimeout = "/ivweb/z_securityquery.jsp";
  	
   	String notSaved = "<h3>This new business record was not saved.</h3>";
   	String message1 = "<h3>This Trusted Mechanic record was saved to the database.</h3>";

   	checkAuth check = new checkAuth();

   	String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

   	if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
   		response.sendRedirect( sessiontimeout );
   	} else { 
   		
  		
   		String referreremail = request.getParameter("referreremail");
   		String country = request.getParameter("country");
   		String businessname = request.getParameter("businessname");
   		String citytown = request.getParameter("citytown");
   		String state = request.getParameter("state");
   		
   		String zipcode = request.getParameter("zipcode");
   		String servicedzipcodes = request.getParameter("servicedzipcodes");
   		String email = request.getParameter("email");
   		String businessdescription = request.getParameter("businessdescription-text");
   		
   		String reminderquestion = request.getParameter("reminderquestion");
   		String reminderanswer = request.getParameter("reminderanswer");
   		
   		String website = request.getParameter("website");
   		String phone = request.getParameter("phone");
   		
   		
   		
   		saveNewBusinessRecord newBus = new saveNewBusinessRecord();   
   		boolean saveOk = newBus.WriteToDB( referreremail, country, businessname, citytown, state, zipcode, email, businessdescription, website, phone, reminderquestion, reminderanswer, servicedzipcodes );
   		newBus.CloseDB();

   		//out.println("Date: " + date + "<br>");
   		//out.println("Cost: " + cost + "<br>");
   		//out.println("Services: " + servicesPerformed + "<br>");

   		//boolean saveOk = false;

   		// save to DB
   		if (!saveOk) {
   			out.println(notSaved);
   		} else {
   			out.println(message1);
   			String emailSubject = "Auto Business Notice from Autotalky.com";
   			String emailMessage = "New Business Added:\n\n" + 
   							  	  "Country: " + country + 
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