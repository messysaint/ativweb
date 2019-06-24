<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator, java.text.DateFormat, java.text.SimpleDateFormat,java.util.Date, com.abrstech.obd2.security.*" 
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
	
	String htmlbreak = "<br>";

	//String errorMsg = "<H3>No Trusted Mechanic has been selected yet ...</H3>";
	String htmlMyOffersLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/marketPlaceMyOffersListingTM.jsp\">My Maintenance Service Offers</A>&nbsp;&nbsp;]";
	
	
	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	
	checkAuth check = new checkAuth();

	String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

	if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
		response.sendRedirect( sessiontimeout );
	}
	
	
	
	
	// check for session timed out
	if( IVWEB_SEQNO == null ) {
		String errorMsg = "<H3>No Trusted Mechanic has been selected yet ...</H3>";
    	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
    	
    	out.println( errorMsg );
	} else {
	
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
    <td><h3><%=SESSIONBusinessname.toUpperCase()%>, &nbsp; <%=SESSIONCitytown.toUpperCase()%>, &nbsp; <%=SESSIONZipcode%>  
    <br>Serviced ZIP Code/s: &nbsp; <%=SESSIONServicedzipcodes%> </h3></td>
  </tr>
     
</table> 
    
<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">    
	SELECT CAR_MECHANIC.seqno, CAR_MECHANIC.auto_business_seqno, CAR_MECHANIC.vin, CAR.country, CAR.zipcode, CAR.year, CAR.make, CAR.model, CAR.trim, CAR.nickname   
	FROM abrstech_obd2db.ref_car_tbl as CAR
	JOIN (abrstech_obd2db.car_mechanic_tbl as CAR_MECHANIC) 
	ON (CAR_MECHANIC.vin=CAR.vin) 
	WHERE CAR_MECHANIC.auto_business_seqno=<%=IVWEB_SEQNO%>		
</sql:query>

<br><br>

<%
int i = 0; 
%>
<c:forEach var="row" items="${rs.rows}">
	 <%=++i%>. &nbsp; <a href="/ivweb/viewTrustFleetVehicleTM.jsp?vin=${row.vin}">Select this Vehicle</a> &nbsp;  <br> 
     ${row.nickname} &nbsp; 
     VIN: ${row.vin} &nbsp; 
     ZIP: ${row.zipcode} &nbsp; <br> 
     ${row.year} &nbsp; 
     ${row.make} &nbsp; 
     ${row.model} &nbsp; 
     ${row.trim} &nbsp;
      
    <br>
    <br>
</c:forEach>


<% 
		// check if there are no vehicles listed
		if( i == 0) { 
			String backToMyAutoMechanic = "/ivweb/whatisneededTM.html";
        	response.sendRedirect( backToMyAutoMechanic );
		}

	}
%>


</font>

</body>
</html>