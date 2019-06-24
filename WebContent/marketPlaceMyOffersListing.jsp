<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator" 
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

	Integer IVWEB_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_VIN from HTTP Session
	String sessiontimeout = "/sessiontimedout.html";
	// check for session timed out
	if( IVWEB_SEQNO == null ) {
		response.sendRedirect( sessiontimeout );
	}
	
	String htmlbreak = "<br>";

	String errorMsg = "<H3>Your information does not match out record ...</H3>";
	
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
       
<table border="0">
  <tr>
    <td><h3>My Maintenance Service Offers</h3> </td>
    <td><input type=button value="All Maintenance Requests" onClick="history.go(-1);return true;"></td>
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
SELECT REQUEST.vin, REQUEST.currentzipcode, REQUEST.odometer, REQUEST.datetime, REQUEST.servicesrequested, OFFERS.cost, OFFERS.notes, CAR.year, CAR.make, CAR.model 
	FROM abrstech_obd2db.car_mtnc_request_tbl as REQUEST  
	JOIN (abrstech_obd2db.auto_business_mtnc_offers_tbl as OFFERS) 
        JOIN (abrstech_obd2db.ref_car_tbl as CAR) 
	ON (REQUEST.seqno=OFFERS.mntnc_request_seqno and REQUEST.vin=CAR.vin)    
	WHERE OFFERS.business_seqno="<%=IVWEB_SEQNO%>"  and OFFERS.active="y" 
	ORDER BY REQUEST.datetime DESC 
	LIMIT 500
</sql:query>

<br><br>

<%
int i = 0; 
%>
<c:forEach var="row" items="${rs.rows}">
	 (<%=++i%>) &nbsp;
     VIN: ${row.vin} &nbsp; Zip: ${row.currentzipcode} &nbsp; <br>
     Requested Service Date: ${row.datetime} &nbsp; <br>
     Car Info: Year: ${row.year} &nbsp;
     Make: ${row.make} &nbsp;
     Model: ${row.model} &nbsp;
     Odometer: ${row.odometer} &nbsp; <br>
     Services Requested: ${row.servicesrequested} &nbsp; <br>
     Offer Notes:  ${row.notes} &nbsp;
    <br>
    <br>
</c:forEach>


</font>

</body>
</html>