<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,com.abrstech.sql.*" 
%>

<%@ page errorPage="showError.jsp" %>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Modify business form</title>

	<script type="text/javascript" src="/ivweb/jscript/validateOfferForm.js"></script>
	
	
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

	Integer IVWEB_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_VIN from HTTP Session
	String sessiontimeout = "/ivweb/z_securityquery.jsp";
	// check for session timed out
	if( IVWEB_SEQNO == null ) {
		response.sendRedirect( sessiontimeout );
	}
	
	String htmlbreak = "<br>";

	String errorMsg = "<H3>Your information does not match out record ...</H3>";
	String htmlMaintenanceRecordDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewMaintenanceDetails.jsp\">View Maintenance Record Details</A>&nbsp;&nbsp;]";
	String htmlVehicleNotesDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewNotesDetails.jsp\">View Vehicle Notes Details</A>&nbsp;&nbsp;]";
	
	String reqno = request.getParameter( "no" );
	
	Integer SESSIONSeqno = IVWEB_SEQNO;
	String SESSIONCountry = (String) session.getAttribute( "IVWEB_COUNTRY" );
	String SESSIONCitytown = (String) session.getAttribute( "IVWEB_CITYTOWN" );
	String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
	String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
	String SESSIONBusinessname = (String) session.getAttribute( "IVWEB_BUSINESSNAME" );
	String SESSIONBusinessdescription = (String) session.getAttribute( "IVWEB_BUSINESSDESCRIPTION" );
	String SESSIONWebsite = (String) session.getAttribute( "IVWEB_WEBSITE" );
	String SESSIONPhone = (String) session.getAttribute( "IVWEB_PHONE" );
	String SESSIONReminderquestion = (String) session.getAttribute( "IVWEB_REMINDERQUESTION" );
	String SESSIONReminderanswer = (String) session.getAttribute( "IVWEB_REMINDERANSWER" );
	String SESSIONServicedzipcodes = (String) session.getAttribute( "IVWEB_SERVICEDZIPCODES" );
	
	
	
%>
       
<h3>Company Details:</h3>

<table border="0">

  <tr>
    <td><%=SESSIONCountry%>, &nbsp; <%=SESSIONBusinessname%>, &nbsp; <%=SESSIONCitytown%>, &nbsp; <%=SESSIONZipcode%>, &nbsp; (<%=SESSIONPhone%>) &nbsp; &nbsp; <%=SESSIONWebsite%></td>
  </tr>
 
  <tr>
    <td>Serviced ZIP Code/s: &nbsp; <%=SESSIONServicedzipcodes%> </td>
  </tr>
    
</table> 
    
<table border="0">
  <tr>
    <td><h3>Requested Maintenance: </h3> </td>
    <td><%=htmlMaintenanceRecordDetailsLink%></td>
    <td><%=htmlVehicleNotesDetailsLink%></td>
  </tr>   
</table> 

<%

searchMaintenanceRequest srch = new searchMaintenanceRequest();
srch.isExisting(SESSIONCountry, SESSIONServicedzipcodes, reqno); 

//String carReqno = srch.getRequestNo();
String carVin = srch.getCarVin();
session.setAttribute( "IVWEB_VIN", carVin );
String carCountry = srch.getCarCountry();
String caZip = srch.getCarZip();
String carServiceDate = srch.getCarServiceDate();
String carYear = srch.getCarYear();
String carMake = srch.getCarMake();
String carModel = srch.getCarModel();
String carOdometer = srch.getCarOdometer();
String carServicesRequested = srch.getCarServicesRequested();
String carEmail = srch.getCarEmail();

session.setAttribute("IVWEB_REQUESTEDSERVICES", carServicesRequested);
session.setAttribute("IVWEB_CAREMAIL", carEmail);
session.setAttribute("IVWEB_CARREQNO", reqno);

%>

Country: <%=carCountry %> &nbsp;
Zip: <%=caZip %> &nbsp; <br>
Requested Service Date: <%=carServiceDate %> &nbsp; <br>
Car Info: Year: <%=carYear %> &nbsp;
Make: <%=carMake %> &nbsp;
Model: <%=carModel %> &nbsp;
Odometer: <%=carOdometer %> &nbsp; <br>
Services Requested: <%=carServicesRequested %> &nbsp;
<br>
<br>


<h3>Make an Offer:</h3>

<form name="makeoffer" action="/ivweb/saveMarketPlaceOffer.jsp" onsubmit="return validateOfferForm()" method="post">

<table border="0">

  <tr>
    <td>Estimated Cost: ($) &nbsp;</td>
    <td><input type="text" name="estimatedcost"   maxlength="6" size="7" value="0.00"/> </td>
  </tr>
  <tr>
    <td>Notes: &nbsp;</td>
    <td><textarea name="notes" rows="5" cols="50"></textarea> </td>
  </tr>
    
</table> 

<br>
<br>

<INPUT type="submit" value="Submit">

</form>


</font>

</body>
</html>