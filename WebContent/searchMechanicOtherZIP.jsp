<%@ page language="java" 
    import="com.abrstech.obd2.log.FindVin, com.abrstech.sql.*,com.abrstech.obd2.security.*"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   

<html>
<head>
<title>OBDII logs for this VIN</title>
</head>

<body>



<font face="Georgia, Arial, Garamond" size = "2">

<%
// get System Date



String sessiontimeout = "/ivweb/z_securityquery.jsp";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} 

String SESSIONZipcode = request.getParameter( "zip" ).trim();

String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );

String SESSIONCountry = (String) session.getAttribute( "IVWEB_COUNTRY" );

if( IVWEB_VIN == null ) {
	String errorMsg = "<H3>No vehicle has been selected yet ...</H3>";
	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
	
	out.println( errorMsg );
	
} else {
	
	int i = 0;
	
%>


<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">    
	SELECT * 
	FROM abrstech_obd2db.auto_business_tbl as MECHANIC 
	WHERE MECHANIC.country="<%=SESSIONCountry%>" and LOCATE( "<%=SESSIONZipcode%>", MECHANIC.servicedzipcodes ) > 0;   
</sql:query>

<form action="/ivweb/saveSelectedTrustedMechanicsOtherZIP.jsp" method="post">
<INPUT type="submit" value="Add to Selected Trusted Mechanics">

<c:forEach var="row" items="${rs.rows}">
	 <br> <br>
	 <INPUT type="checkbox"  name="${row.seqno}" value="${row.seqno}">
	 <%=++i%>. &nbsp;
     ${row.businessname} &nbsp; <br>
	 ${row.citytown} &nbsp;  ${row.zipcode}; <br>
	 ${row.country} &nbsp; <br>
	 ${row.website} &nbsp; <br>
	 Email: ${row.email} &nbsp; Phone: ${row.phone} &nbsp; <br>
	 Serviced Zip Codes: ${row.servicedzipcodes} &nbsp; <br>
	 Description: ${row.businessdescription} &nbsp;  <br>

</c:forEach>

</form>

<%
}
%>

</font>

</body>

</html>