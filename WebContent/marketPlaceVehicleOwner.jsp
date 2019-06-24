<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*,com.abrstech.sql.*, com.abrstech.obd2.security.*,java.text.Collator" 
%>

<%@ page errorPage="showError.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save New VIN to DB</title>
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">
 
<% 

String sessiontimeout = "/ivweb/z_securityquery.jsp";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} 

String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );
String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );


// check for session timed out
if( IVWEB_VIN == null ) {
	String errorMsg = "<H3>No vehicle has been selected yet ...</H3>";
	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
	
	out.println( errorMsg );
	
} else {

String htmlbreak = "<br>";


%>
		
<h3>Your Vehicle Maintenance Request Listing:</h3>

<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">    
	SELECT CAR.country, CAR.year, CAR.make, CAR.model, REQUEST.seqno, REQUEST.vin, REQUEST.currentzipcode, REQUEST.odometer, REQUEST.datetime, REQUEST.servicesrequested 
	FROM abrstech_obd2db.car_mtnc_request_tbl as REQUEST 
	JOIN (abrstech_obd2db.ref_car_tbl as CAR) 
	ON (REQUEST.vin=CAR.vin) 
	WHERE REQUEST.vin="<%=IVWEB_VIN%>" and active="y" 	
	ORDER BY REQUEST.datetime DESC 
	LIMIT 500				
</sql:query>

<%
int i = 0;
%>
<c:forEach var="row" items="${rs.rows}">
	 (<a href="/ivweb/marketPlaceDeleteVehicleListing.jsp?no=${row.seqno}">x</a>)
	 (<%=++i%>) &nbsp;
     Country: ${row.country} &nbsp;
     Zip: ${row.currentzipcode} &nbsp; (Views) &nbsp; (<A href="/ivweb/marketPlaceMyMtncReqOffers.jsp?no=${row.seqno}">Offers</A>) <br>
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
} // endif
%>


</font>

</body>
</html>