<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator,com.abrstech.obd2.security.*" 
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

String sessiontimeout = "/ivweb/z_securityquery.jsp";


checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
}
	 

String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session

// check for session timed out
if( IVWEB_VIN == null ) {
	response.sendRedirect( sessiontimeout );
}

String offerSeqno = request.getParameter( "no" );
String IVWEB_YEAR = (String) session.getAttribute( "IVWEB_YEAR" ); 
String IVWEB_MAKE = (String) session.getAttribute( "IVWEB_MAKE" ); 
String IVWEB_MODEL = (String) session.getAttribute( "IVWEB_MODEL" ); 
String IVWEB_EMAIL = (String) session.getAttribute( "IVWEB_EMAIL" );
String IVWEB_SECURITY_QUESTION = (String) session.getAttribute( "IVWEB_SECURITY_QUESTION" ); 
String IVWEB_SECURITY_ANSWER = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER"); 
	
IVWEB_MAKE = IVWEB_MAKE.toUpperCase();
IVWEB_MODEL = IVWEB_MODEL.toUpperCase();

%>
       
<table border="0">
  <tr>
    <td><h3>Auto Business Service Offer for your Vehicle</h3> </td>
    <td><input type=button value="Your Vehicle Maintenance Request Listing" onClick="history.go(-1);return true;"></td>
  </tr>   
</table> 

	
<table border="0">

  <tr>
    <td>Vin: <%=IVWEB_VIN%>, &nbsp; <%=IVWEB_YEAR%>, &nbsp; <%=IVWEB_MAKE%>, &nbsp; <%=IVWEB_MODEL%></td>
  </tr>
   
</table> 
    
<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">  
SELECT OFFERS.seqno, OFFERS.datetime as OFFdatetime, OFFERS.business_seqno, OFFERS.mntnc_request_seqno, OFFERS.vin, OFFERS.cost, OFFERS.notes, OFFERS.active, 
BUSINESS.seqno as BUSseqno, BUSINESS.datetime as BUSdatetime, BUSINESS.country, BUSINESS.businessname, BUSINESS.citytown, BUSINESS.zipcode, BUSINESS.servicedzipcodes, BUSINESS.email, BUSINESS.businessdescription, BUSINESS.website, BUSINESS.phone  
FROM abrstech_obd2db.auto_business_mtnc_offers_tbl as OFFERS  
JOIN (abrstech_obd2db.auto_business_tbl as BUSINESS) 
ON (OFFERS.business_seqno=BUSINESS.seqno )    
WHERE OFFERS.mntnc_request_seqno=<%=offerSeqno%>  and OFFERS.active="y"

</sql:query>

<br><br>

<%
int i = 0; 
%>
<c:forEach var="row" items="${rs.rows}">
	 (<%=++i%>) &nbsp;
     Business Name: ${row.businessname} &nbsp; Location: ${row.citytown} &nbsp; Website: ${row.website} &nbsp;  <br>
     Email: ${row.email} &nbsp; Phone: ${row.phone} &nbsp; Serviced Zip Codes: ${row.servicedzipcodes} &nbsp;  <br>
     Offer Cost: ${row.cost} &nbsp; <br>
     Offer Notes:  ${row.notes} &nbsp;
    <br>
    <br>
</c:forEach>


</font>

</body>
</html>