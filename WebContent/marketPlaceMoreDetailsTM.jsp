<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator, java.text.DateFormat, java.text.SimpleDateFormat,java.util.Date" 
%>
    
<%@ page errorPage="showError.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Modify business form</title>

	<script type="text/javascript" src="/ivweb/jscript/validateModifyBusinessForm.js"></script>
	
	
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date date = new Date();
	String SystemDT = dateFormat.format(date);

	Integer IVWEB_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_VIN from HTTP Session
	
	
	
	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	
	// check for session timed out
	if( IVWEB_SEQNO == null ) {
		String errorMsg = "<H3>No Trusted Mechanic has been selected yet ...</H3>";
    	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
    	
    	out.println( errorMsg );
	} else {
	
	String htmlbreak = "<br>";

	String errorMsg = "<H3>Your information does not match out record ...</H3>";
	String htmlMyOffersLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/marketPlaceMyOffersListingTM.jsp\">My Maintenance Service Offers</A>&nbsp;&nbsp;]";
	
	//String answer = request.getParameter( "answer" ).trim().toLowerCase();
	
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
	
	
	//SESSIONReminderanswer = SESSIONReminderanswer.trim().toLowerCase();
	
	//Collator collator = Collator.getInstance();
	

	//int compareAnswer = collator.compare( SESSIONReminderanswer, answer );
	
    //if ( compareAnswer == 0 ) {
    	
    	//session.setAttribute( "IVWEB_BUSINESSNAME_ANSWER", answer);
    	//out.println( "<h3>Country: " + SESSIONCountry + "</h3>" );	
    	  		
%>
       
<table border="0">
  <tr>
    <td><h3>All Maintenance Requests</h3> </td>
    <td><%=htmlMyOffersLink%></td>
  </tr>   
</table> 

	
<table border="0">

  <tr>
    <td><%=SESSIONCountry%>, &nbsp; <%=SESSIONBusinessname%>, &nbsp; <%=SESSIONCitytown%>, &nbsp; <%=SESSIONZipcode%>, &nbsp; (<%=SESSIONPhone%>) &nbsp; &nbsp; <%=SESSIONWebsite%></td>
  </tr>
 
  <tr>
    <td>Serviced ZIP Code/s: &nbsp; <%=SESSIONServicedzipcodes%> </td>
  </tr>
    
</table> 
    
<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">    
	SELECT CAR.country, CAR.year, CAR.make, CAR.model, REQUEST.seqno, REQUEST.vin, REQUEST.currentzipcode, REQUEST.odometer, REQUEST.datetime, REQUEST.servicesrequested   
	FROM abrstech_obd2db.car_mtnc_request_tbl as REQUEST 
	JOIN (abrstech_obd2db.ref_car_tbl as CAR) 
	ON (REQUEST.vin=CAR.vin) 
	WHERE CAR.country="<%=SESSIONCountry%>" and locate( REQUEST.currentzipcode, "<%=SESSIONServicedzipcodes%>") and REQUEST.active="y" and REQUEST.datetime>"<%=SystemDT%>"		
</sql:query>

<br><br>

<%
int i = 0; 
%>
<c:forEach var="row" items="${rs.rows}">
	 (<%=++i%>) &nbsp;
     Country: ${row.country} &nbsp;
     Zip: ${row.currentzipcode} &nbsp; (<a href="/ivweb/marketPlaceOfferAutoService.jsp?no=${row.seqno}">Offer Service</a>) <br>
     Requested Service Date: ${row.datetime} &nbsp; <br>
     Car Info: Year: ${row.year} &nbsp;
     Make: ${row.make} &nbsp;
     Model: ${row.model} &nbsp;
     Odometer: ${row.odometer} &nbsp; <br>
     Services Requested: ${row.servicesrequested} &nbsp;
    <br>
    <br>
</c:forEach>


<%
    }
%>


</font>

</body>
</html>